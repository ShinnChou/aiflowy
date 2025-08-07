package tech.aiflowy.ai.node;

import com.agentsflex.core.chain.Chain;
import com.agentsflex.core.chain.node.BaseNode;
import tech.aiflowy.ai.entity.AiWorkflow;
import tech.aiflowy.ai.service.AiWorkflowService;
import tech.aiflowy.common.util.SpringContextUtil;

import java.util.Map;

public class WorkflowNode extends BaseNode {

    private String workflowId;

    public WorkflowNode() {
    }

    public WorkflowNode(String workflowId) {
        this.workflowId = workflowId;
    }

    @Override
    protected Map<String, Object> execute(Chain chain) {

        Map<String, Object> params = chain.getParameterValues(this);
        AiWorkflowService service = SpringContextUtil.getBean(AiWorkflowService.class);
        AiWorkflow workflow = service.getById(workflowId);
        if (workflow == null) {
            throw new RuntimeException("工作流不存在：" + workflowId);
        }
        Chain subChain = workflow.toTinyflow().toChain();

        return subChain.executeForResult(params);
    }

    public String getWorkflowId() {
        return workflowId;
    }

    public void setWorkflowId(String workflowId) {
        this.workflowId = workflowId;
    }
}
