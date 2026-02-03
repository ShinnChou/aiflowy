# 节点上下文

## _state

`_state` 本质上是 `dev.tinyflow.core.chain.NodeState` 类。

可以直接调用里面的方法。

### isUpstreamFullyExecuted 方法

在一些场景中，需要判断上游节点是否已经执行完毕，可以通过 `_state.isUpstreamFullyExecuted()` 方法来判断。

比如上游有多个节点是异步执行的，那就需要在当前节点判断上游节点是否执行完毕，等待上游全部执行完毕才能继续执行当前节点。

如图：

![async-exec.png](resource/async-exec.png)

### getExecuteCount() 方法
`_state.getExecuteCount()` 方法可以获取节点已经执行的次数。

### getTriggerCount() 方法
`_state.getTriggerCount()` 方法可以获取节点触发的次数。

## _chain

`_chain` 本质上是 `dev.tinyflow.core.chain.Chain` 类。

同理，也可以直接调用里面的方法。
