<script setup lang="ts">
import { onMounted, ref, watch } from 'vue';

import { ElCard, ElCheckbox, ElImage, ElText, ElTooltip } from 'element-plus';

import Tag from '#/components/tag/Tag.vue';
import { useDictStore } from '#/store';
import {
  getResourceOriginColor,
  getResourceTypeColor,
  getSrc,
} from '#/utils/resource';

export interface ResourceCardProps {
  data: any[];
  multiple?: boolean;
  valueProp?: string;
}
withDefaults(defineProps<ResourceCardProps>(), {
  multiple: false,
  valueProp: 'id',
});

const emit = defineEmits(['update:modelValue']);

const dictStore = useDictStore();
const checkedItem = ref<any>({});

onMounted(() => {
  initDict();
});

watch(
  checkedItem,
  (newCheckItem) => {
    if (newCheckItem.id) {
      emit('update:modelValue', [newCheckItem]);
    }
  },
  { immediate: true },
);

function initDict() {
  dictStore.fetchDictionary('resourceType');
  dictStore.fetchDictionary('resourceOriginType');
}

// function handleCheckAllChange(val: any) {
//   if (val) {
//     for (const data of props.data) {
//       data.checkboxValue = data[props.valueProp];
//     }
//   } else {
//     for (const data of props.data) {
//       data.checkboxValue = '';
//     }
//   }
// }
</script>

<template>
  <div class="bg-accent max-h-[60vh] overflow-y-auto rounded-xl p-5">
    <!-- <ElCheckbox
      v-if="multiple"
      :label="$t('button.selectAll')"
      v-model="checkAll"
      @change="handleCheckAllChange"
    /> -->

    <div class="grid grid-cols-[repeat(auto-fill,minmax(254px,1fr))] gap-5">
      <ElCard
        v-for="item in data"
        :key="item.id"
        shadow="hover"
        :style="{
          borderColor:
            item.id === checkedItem.id
              ? 'hsl(var(--primary))'
              : 'var(--el-card-border-color)',
        }"
        :body-style="{
          padding: '12px',
          height: 'auto',
          cursor: 'pointer',
        }"
        @click="checkedItem = item"
      >
        <div class="relative h-[150px]">
          <template v-if="item.resourceType === 0">
            <ElImage
              class="h-full w-full rounded-lg"
              @click.stop
              fit="cover"
              :src="getSrc(item)"
              :preview-src-list="[item.resourceUrl]"
            />
          </template>
          <template v-else>
            <div
              class="bg-background-deep flex h-full w-full items-center justify-center rounded-lg"
            >
              <ElImage class="h-[100px] w-[100px]" :src="getSrc(item)" />
            </div>
          </template>
          <ElCheckbox
            class="!absolute left-0.5 top-0.5 [--el-checkbox-height:auto]"
            :model-value="item.id === checkedItem.id"
            @click.stop="checkedItem = item"
          />
        </div>
        <div>
          <ElTooltip
            :content="`${item.resourceName}.${item.suffix}`"
            placement="top"
          >
            <ElText truncated>
              {{ item.resourceName }}.{{ item.suffix }}
            </ElText>
          </ElTooltip>
        </div>
        <div class="flex gap-1.5">
          <Tag
            size="small"
            :background-color="`${getResourceOriginColor(item)}15`"
            :text-color="getResourceOriginColor(item)"
            :text="dictStore.getDictLabel('resourceOriginType', item.origin)"
          />
          <Tag
            size="small"
            :background-color="`${getResourceTypeColor(item)}15`"
            :text-color="getResourceTypeColor(item)"
            :text="dictStore.getDictLabel('resourceType', item.resourceType)"
          />
        </div>
      </ElCard>
    </div>
  </div>
</template>
