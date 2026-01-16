package tech.aiflowy.publicapi.controller;

import jakarta.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import tech.aiflowy.ai.entity.Workflow;
import tech.aiflowy.ai.service.WorkflowService;
import tech.aiflowy.common.domain.Result;

import jakarta.validation.constraints.NotBlank;

/**
 * 工作流
 */
@RequestMapping("/public-api/workflow")
@RestController
@Validated
public class PublicWorkflowController {

    @Resource
    private WorkflowService workflowService;

    /**
     * 通过id或者别名获取工作流详情
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
}
