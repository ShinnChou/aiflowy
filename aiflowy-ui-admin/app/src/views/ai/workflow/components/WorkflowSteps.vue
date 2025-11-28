<script setup lang="ts">
import type { ServerSentEventMessage } from 'fetch-event-stream';

import { ref, watch } from 'vue';

import { preferences } from '@aiflowy/preferences';

import { CircleCloseFilled, SuccessFilled } from '@element-plus/icons-vue';
import { ElCollapse, ElCollapseItem, ElIcon } from 'element-plus';
import { JsonViewer } from 'vue3-json-viewer';

import 'vue3-json-viewer/dist/vue3-json-viewer.css';

export interface WorkflowStepsProps {
  workflowId: any;
  executeMessage: null | ServerSentEventMessage;
  nodeJson: any;
}
const props = defineProps<WorkflowStepsProps>();
const themeMode = ref(preferences.theme.mode);
watch(
  () => preferences.theme.mode,
  (newVal) => {
    themeMode.value = newVal;
  },
);
const nodes = ref<any[]>([]);
watch(
  () => props.nodeJson,
  (newVal) => {
    if (nodes.value.length === 0 && newVal && newVal.length > 0) {
      nodes.value = [...newVal];
    }
  },
  { immediate: true },
);
watch(
  () => props.executeMessage,
  (newMsg) => {
    if (newMsg && newMsg.data) {
      try {
        const msg = JSON.parse(newMsg.data).content;
        if (msg.nodeId && msg.status) {
          // 直接在原数组中找到该对象
          const targetNode = nodes.value.find(
            (node) => node.key === msg.nodeId,
          );
          if (targetNode) {
            targetNode.status = msg.status;
            targetNode.content = msg.res || msg.errorMsg;
          }
        }
      } catch (error) {
        console.error('parse sse message error:', error);
      }
    }
  },
  { deep: true },
);
const activeName = ref('1');
</script>

<template>
  <div>
    <ElCollapse v-model="activeName" accordion expand-icon-position="left">
      <ElCollapseItem
        v-for="node in nodes"
        :key="node.key"
        :title="`${node.label}-${node.status}`"
        :name="node.key"
      >
        <template #title>
          <div class="flex items-center justify-between">
            <div>
              {{ node.label }}
            </div>
            <div class="flex items-center">
              <ElIcon v-if="node.status === 'end'" color="green" size="20">
                <SuccessFilled />
              </ElIcon>
              <div v-if="node.status === 'start'" class="spinner"></div>
              <ElIcon v-if="node.status === 'nodeError'" color="red" size="20">
                <CircleCloseFilled />
              </ElIcon>
            </div>
          </div>
        </template>
        <div>
          <JsonViewer :value="node.content || {}" copyable :theme="themeMode" />
        </div>
      </ElCollapseItem>
    </ElCollapse>
  </div>
</template>

<style scoped>
.spinner {
  width: 18px;
  height: 18px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  border-top-color: var(--el-color-primary);
  border-right-color: var(--el-color-primary);
  animation: spin 1s linear infinite;
}
@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
</style>
