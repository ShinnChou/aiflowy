<script setup lang="ts">
import type { FormInstance, UploadInstance, UploadProps } from 'element-plus';

import { computed, onMounted, ref } from 'vue';

import {
  ElButton,
  ElDialog,
  ElForm,
  ElFormItem,
  ElInput,
  ElMessage,
  ElUpload,
} from 'element-plus';

import { api } from '#/api/request';
import DictSelect from '#/components/dict/DictSelect.vue';
// import Cropper from '#/components/upload/Cropper.vue';
import UploadAvatar from '#/components/upload/UploadAvatar.vue';
import { $t } from '#/locales';

const emit = defineEmits(['reload']);
// vue
onMounted(() => {});
defineExpose({
  openDialog,
});
const saveForm = ref<FormInstance>();
// variables
const dialogVisible = ref(false);
const isAdd = ref(true);
const isImport = ref(false);
const jsonFile = ref<any>(null);
const uploadFileList = ref<any[]>([]);
const uploadRef = ref<UploadInstance>();
const entity = ref<any>({
  alias: '',
  deptId: '',
  title: '',
  description: '',
  icon: '',
  content: '',
  englishName: '',
});
const btnLoading = ref(false);
const jsonFileModel = computed({
  get: () => (uploadFileList.value.length > 0 ? uploadFileList.value[0] : null),
  set: (value: any) => {
    if (!value) {
      uploadFileList.value = [];
    }
  },
});
const rules = computed(() => ({
  title: [{ required: true, message: $t('message.required'), trigger: 'blur' }],
  ...(isImport.value && {
    jsonFile: [
      { required: true, message: $t('message.required'), trigger: 'change' },
    ],
  }),
}));
// functions
function openDialog(row: any, importMode = false) {
  isImport.value = importMode;
  if (row.id) {
    isAdd.value = false;
  }
  entity.value = row;
  dialogVisible.value = true;
}

const beforeUpload: UploadProps['beforeUpload'] = (file) => {
  jsonFile.value = file;
  uploadFileList.value = [file];
  saveForm.value?.clearValidate('jsonFile');
  return false;
};
const handleChange: UploadProps['onChange'] = (file, fileList) => {
  jsonFile.value = file.raw;
  uploadFileList.value = fileList.slice(-1);
  saveForm.value?.clearValidate('jsonFile');
};
const handleRemove: UploadProps['onRemove'] = () => {
  jsonFile.value = null;
  uploadFileList.value = [];
  saveForm.value?.clearValidate('jsonFile');
};
function save() {
  saveForm.value?.validate((valid) => {
    if (valid) {
      btnLoading.value = true;
      if (isImport.value) {
        const formData = new FormData();
        formData.append('jsonFile', jsonFile.value!);
        Object.keys(entity.value).forEach((key) => {
          if (entity.value[key] !== null && entity.value[key] !== undefined) {
            formData.append(key, entity.value[key]);
          }
        });
        api
          .post('/api/v1/workflow/importWorkFlow', formData, {
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          })
          .then((res) => {
            btnLoading.value = false;
            if (res.errorCode === 0) {
              ElMessage.success(res.message);
              emit('reload');
              closeDialog();
            }
          })
          .catch(() => {
            btnLoading.value = false;
          });
      } else {
        api
          .post(
            isAdd.value ? '/api/v1/workflow/save' : '/api/v1/workflow/update',
            entity.value,
          )
          .then((res) => {
            btnLoading.value = false;
            if (res.errorCode === 0) {
              ElMessage.success(res.message);
              emit('reload');
              closeDialog();
            }
          })
          .catch(() => {
            btnLoading.value = false;
          });
      }
    }
  });
}
function closeDialog() {
  saveForm.value?.resetFields();
  uploadRef.value?.clearFiles();
  uploadFileList.value = [];
  jsonFile.value = null;
  isAdd.value = true;
  isImport.value = false;
  entity.value = {};
  dialogVisible.value = false;
}
</script>

<template>
  <ElDialog
    v-model="dialogVisible"
    draggable
    :title="
      isImport
        ? $t('button.import')
        : isAdd
          ? $t('button.add')
          : $t('button.edit')
    "
    :before-close="closeDialog"
    :close-on-click-modal="false"
  >
    <ElForm
      label-width="120px"
      ref="saveForm"
      :model="isImport ? { ...entity, jsonFile: jsonFileModel } : entity"
      status-icon
      :rules="rules"
    >
      <ElFormItem v-if="isImport" prop="jsonFile" label="JSON文件" required>
        <ElUpload
          class="w-full"
          ref="uploadRef"
          v-model:file-list="uploadFileList"
          :limit="1"
          :auto-upload="false"
          :on-change="handleChange"
          :before-upload="beforeUpload"
          :on-remove="handleRemove"
          accept=".json"
          drag
        >
          <div class="el-upload__text w-full">
            将 json 文件拖到此处，或<em>点击上传</em>
          </div>
        </ElUpload>
      </ElFormItem>
      <ElFormItem prop="icon" :label="$t('aiWorkflow.icon')">
        <!-- <Cropper v-model="entity.icon" crop /> -->
        <UploadAvatar v-model="entity.icon" />
      </ElFormItem>
      <ElFormItem prop="title" :label="$t('aiWorkflow.title')">
        <ElInput v-model.trim="entity.title" />
      </ElFormItem>
      <ElFormItem prop="categoryId" :label="$t('aiWorkflow.categoryId')">
        <DictSelect
          v-model="entity.categoryId"
          dict-code="aiWorkFlowCategory"
        />
      </ElFormItem>
      <ElFormItem prop="alias" :label="$t('aiWorkflow.alias')">
        <ElInput v-model.trim="entity.alias" />
      </ElFormItem>
      <ElFormItem prop="englishName" :label="$t('aiWorkflow.englishName')">
        <ElInput v-model.trim="entity.englishName" />
      </ElFormItem>
      <ElFormItem prop="description" :label="$t('aiWorkflow.description')">
        <ElInput v-model.trim="entity.description" />
      </ElFormItem>
      <ElFormItem prop="status" :label="$t('aiWorkflow.status')">
        <DictSelect v-model="entity.status" dict-code="showOrNot" />
      </ElFormItem>
    </ElForm>
    <template #footer>
      <ElButton @click="closeDialog">
        {{ $t('button.cancel') }}
      </ElButton>
      <ElButton
        type="primary"
        @click="save"
        :loading="btnLoading"
        :disabled="btnLoading"
      >
        {{ $t('button.save') }}
      </ElButton>
    </template>
  </ElDialog>
</template>

<style scoped></style>
