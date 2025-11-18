<script lang="ts" setup>
import type { UploadProps } from 'element-plus';

import { ref } from 'vue';

import { useAppConfig } from '@aiflowy/hooks';
import { useAccessStore } from '@aiflowy/stores';

import { Plus } from '@element-plus/icons-vue';
import { ElIcon, ElImage, ElMessage, ElUpload } from 'element-plus';

const props = defineProps({
  action: {
    type: String,
    default: '/api/v1/commons/upload',
  },
});

const accessStore = useAccessStore();
const headers = ref({
  'aiflowy-token': accessStore.accessToken,
});

const imageUrl = ref('');

const { apiURL } = useAppConfig(import.meta.env, import.meta.env.PROD);

const handleAvatarSuccess: UploadProps['onSuccess'] = (
  response,
  uploadFile,
) => {
  imageUrl.value = URL.createObjectURL(uploadFile.raw!);
};

const beforeAvatarUpload: UploadProps['beforeUpload'] = (rawFile) => {
  if (rawFile.type !== 'image/jpeg') {
    ElMessage.error('Avatar picture must be JPG format!');
    return false;
  } else if (rawFile.size / 1024 / 1024 > 2) {
    ElMessage.error('Avatar picture size can not exceed 2MB!');
    return false;
  }
  return true;
};
</script>

<template>
  <ElUpload
    class="avatar-uploader"
    :action="`${apiURL}${props.action}`"
    :headers="headers"
    :show-file-list="false"
    :on-success="handleAvatarSuccess"
    :before-upload="beforeAvatarUpload"
  >
    <ElImage v-if="imageUrl" :src="imageUrl" class="avatar" />
    <ElIcon v-else class="avatar-uploader-icon"><Plus /></ElIcon>
  </ElUpload>
</template>

<style scoped>
.avatar-uploader .avatar {
  width: 150px;
  height: 150px;
  display: block;
}
</style>

<style>
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 150px;
  height: 150px;
  text-align: center;
}
</style>
