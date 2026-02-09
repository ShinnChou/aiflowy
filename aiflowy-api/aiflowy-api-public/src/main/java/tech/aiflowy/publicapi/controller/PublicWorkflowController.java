package tech.aiflowy.publicapi.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import dev.tinyflow.core.chain.ChainDefinition;
import dev.tinyflow.core.chain.Parameter;
import dev.tinyflow.core.chain.runtime.ChainExecutor;
import dev.tinyflow.core.parser.ChainParser;
import jakarta.annotation.Resource;
import jakarta.validation.constraints.NotBlank;
import org.springframework.web.bind.annotation.*;
import tech.aiflowy.ai.entity.Workflow;
import tech.aiflowy.ai.service.WorkflowService;
import tech.aiflowy.ai.tinyflow.entity.ChainInfo;
import tech.aiflowy.ai.tinyflow.entity.NodeInfo;
import tech.aiflowy.ai.tinyflow.service.TinyFlowService;
import tech.aiflowy.common.domain.Result;
import tech.aiflowy.common.web.jsonbody.JsonBody;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 工作流
 */
@RequestMapping("/public-api/workflow")
@RestController
public class PublicWorkflowController {

    @Resource
    private WorkflowService workflowService;
    @Resource
    private ChainExecutor chainExecutor;
    @Resource
    private ChainParser chainParser;
    @Resource
    private TinyFlowService tinyFlowService;

    /**
     * 通过id或别名获取工作流详情
     *
     * @param key id或者别名
     * @return 工作流详情
     */
    @GetMapping(value = "/getByIdOrAlias")
    public Result<Workflow> getByIdOrAlias(
            @RequestParam
            @NotBlank(message = "key不能为空") String key) {
        Workflow workflow = workflowService.getDetail(key);
        return Result.ok(workflow);
    }

    /**
     * 节点单独运行
     */
    @PostMapping("/singleRun")
    @SaCheckPermission("/api/v1/workflow/save")
    public Result<?> singleRun(
            @JsonBody(value = "workflowId", required = true) BigInteger workflowId,
            @JsonBody(value = "nodeId", required = true) String nodeId,
            @JsonBody("variables") Map<String, Object> variables) {

        Workflow workflow = workflowService.getById(workflowId);
        if (workflow == null) {
            return Result.fail(1, "工作流不存在");
        }
        Map<String, Object> res = chainExecutor.executeNode(workflowId.toString(), nodeId, variables);
        return Result.ok(res);
    }

    /**
     * 运行工作流 - v2
     */
    @PostMapping("/runAsync")
    @SaCheckPermission("/api/v1/workflow/save")
    public Result<String> runAsync(@JsonBody(value = "id", required = true) BigInteger id,
                                   @JsonBody("variables") Map<String, Object> variables) {
        if (variables == null) {
            variables = new HashMap<>();
        }
        Workflow workflow = workflowService.getById(id);
        if (workflow == null) {
            throw new RuntimeException("工作流不存在");
        }
        String executeId = chainExecutor.executeAsync(id.toString(), variables);
        return Result.ok(executeId);
    }

    /**
     * 获取工作流运行状态 - v2
     */
    @PostMapping("/getChainStatus")
    public Result<ChainInfo> getChainStatus(@JsonBody(value = "executeId") String executeId,
                                            @JsonBody("nodes") List<NodeInfo> nodes) {
        ChainInfo res = tinyFlowService.getChainStatus(executeId, nodes);
        return Result.ok(res);
    }

    /**
     * 恢复工作流运行 - v2
     */
    @PostMapping("/resume")
    @SaCheckPermission("/api/v1/workflow/save")
    public Result<Void> resume(@JsonBody(value = "executeId", required = true) String executeId,
                               @JsonBody("confirmParams") Map<String, Object> confirmParams) {
        chainExecutor.resumeAsync(executeId, confirmParams);
        return Result.ok();
    }

    @GetMapping("getRunningParameters")
    @SaCheckPermission("/api/v1/workflow/query")
    public Result<?> getRunningParameters(@RequestParam BigInteger id) {
        Workflow workflow = workflowService.getById(id);

        if (workflow == null) {
            return Result.fail(1, "can not find the workflow by id: " + id);
        }

        ChainDefinition definition = chainParser.parse(workflow.getContent());
        if (definition == null) {
            return Result.fail(2, "节点配置错误，请检查! ");
        }
        List<Parameter> chainParameters = definition.getStartParameters();
        Map<String, Object> res = new HashMap<>();
        res.put("parameters", chainParameters);
        res.put("title", workflow.getTitle());
        res.put("description", workflow.getDescription());
        res.put("icon", workflow.getIcon());
        return Result.ok(res);
    }
}
