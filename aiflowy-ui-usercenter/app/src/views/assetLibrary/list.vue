<script setup lang="ts">
import { onMounted } from 'vue';

import { formatBytes } from '@aiflowy/utils';

import {
  Delete,
  Download,
  EditPen,
  MoreFilled,
  View,
} from '@element-plus/icons-vue';
import {
  ElAvatar,
  ElButton,
  ElDropdown,
  ElDropdownItem,
  ElDropdownMenu,
  ElIcon,
  ElTable,
  ElTableColumn,
  ElText,
  ElTooltip,
} from 'element-plus';

import Tag from '#/components/tag/Tag.vue';
import { useDictStore } from '#/store';
import {
  getResourceOriginColor,
  getResourceTypeColor,
  getSrc,
} from '#/utils/resource';

interface ListProps {
  data: any[];
  onCheckedChange?: (ids: any[]) => void;
  onPreview?: (row: any) => void;
  onEdit?: (row: any) => void;
  onRemove?: (row: any) => void;
  onDownload?: (row: any) => void;
}
const props = defineProps<ListProps>();
onMounted(() => {
  initDict();
});
const dictStore = useDictStore();
function initDict() {
  dictStore.fetchDictionary('resourceType');
  dictStore.fetchDictionary('resourceOriginType');
}
function handleSelectionChange(items: any[]) {
  props.onCheckedChange?.(items);
}
</script>

<template>
  <div class="bg-background w-full rounded-lg p-5">
    <ElTable :data="props.data" @selection-change="handleSelectionChange">
      <ElTableColumn type="selection" width="30" />
      <ElTableColumn label="文件名称" show-overflow-tooltip :width="300">
        <template #default="{ row }">
          <div class="flex items-center gap-2.5">
            <ElAvatar :src="getSrc(row)" shape="square" :size="32" />
            <div class="w-[200px]">
              <ElTooltip :content="`${row.resourceName}`" placement="top">
                <ElText truncated>
                  {{ row.resourceName }}
                </ElText>
              </ElTooltip>
            </div>
          </div>
        </template>
      </ElTableColumn>
      <ElTableColumn label="文件来源" align="center">
        <template #default="{ row }">
          <Tag
            size="small"
            :background-color="`${getResourceOriginColor(row)}15`"
            :text-color="getResourceOriginColor(row)"
            :text="dictStore.getDictLabel('resourceOriginType', row.origin)"
          />
        </template>
      </ElTableColumn>
      <ElTableColumn label="文件类型" align="center">
        <template #default="{ row }">
          <Tag
            size="small"
            :background-color="`${getResourceTypeColor(row)}15`"
            :text-color="getResourceTypeColor(row)"
            :text="dictStore.getDictLabel('resourceType', row.resourceType)"
          />
        </template>
      </ElTableColumn>
      <ElTableColumn prop="fileSize" label="文件大小" align="center">
        <template #default="{ row }">
          {{ formatBytes(row.fileSize) }}
        </template>
      </ElTableColumn>
      <ElTableColumn prop="modified" label="修改时间" align="center" />
      <ElTableColumn label="操作" width="80" align="center">
        <template #default="{ row }">
          <ElDropdown>
            <ElIcon>
              <MoreFilled />
            </ElIcon>

            <template #dropdown>
              <ElDropdownMenu>
                <ElDropdownItem @click="onPreview?.(row)">
                  <ElButton :icon="View" link>预览</ElButton>
                </ElDropdownItem>
                <ElDropdownItem @click="onDownload?.(row)">
                  <ElButton :icon="Download" link>下载</ElButton>
                </ElDropdownItem>
                <ElDropdownItem @click="onEdit?.(row)">
                  <ElButton :icon="EditPen" link>编辑</ElButton>
                </ElDropdownItem>
                <ElDropdownItem @click="onRemove?.(row)">
                  <ElButton type="danger" :icon="Delete" link> 删除 </ElButton>
                </ElDropdownItem>
              </ElDropdownMenu>
            </template>
          </ElDropdown>
        </template>
      </ElTableColumn>
    </ElTable>
  </div>
</template>

<style lang="css" scoped>
.el-table {
  --el-table-text-color: hsl(var(--foreground) / 0.9);
  --el-font-size-base: 12px;
  --el-table-header-text-color: hsl(var(--accent-foreground));
  --el-table-header-bg-color: hsl(var(--accent));
  --el-table-border: none;
}

:deep(.el-table__header) {
  border-radius: 8px;
  overflow: hidden;
}

.el-table :deep(.el-table__inner-wrapper:before) {
  display: none;
}

.el-table :deep(thead),
.el-table :deep(tr) {
  height: 60px;
}

.el-table :deep(thead th) {
  font-weight: 400;
}
</style>
