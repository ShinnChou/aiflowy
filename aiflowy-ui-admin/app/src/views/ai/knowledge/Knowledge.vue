<script setup>
import { markRaw, onMounted, ref } from 'vue';

import { Delete, Edit, Plus, View } from '@element-plus/icons-vue';

import CardPage from '#/components/cardPage/CardPage.vue';
import HeaderSearch from '#/components/headerSearch/HeaderSearch.vue';
import PageData from '#/components/page/PageData.vue';
import AddKnowledgeModal from '#/views/ai/knowledge/AddKnowledgeModal.vue';

// 操作按钮配置
const actions = ref([
  {
    name: 'edit',
    label: '编辑',
    type: 'primary',
    icon: markRaw(Edit),
  },
  {
    name: 'view',
    label: '列表',
    type: 'success',
    icon: markRaw(View),
  },
  {
    name: 'delete',
    label: '检索',
    type: 'danger',
    icon: markRaw(View),
  },
  {
    name: 'share',
    label: '删除',
    type: 'info',
    icon: markRaw(Delete),
  },
]);

// 模拟数据加载
onMounted(() => {
  // 模拟异步数据加载
  setTimeout(() => {
    userList.value = [
      {
        id: 1,
        avatar:
          'https://copyright.bdstatic.com/vcg/creative/d90a05ca26b2ca79dc1cbaa4931b18ee.jpg@wm_1,k_cGljX2JqaHdhdGVyLmpwZw==',
        title: '张三',
        description:
          '前端开发工程师，专注于Vue和React技术栈,前端开发工程师，专注于Vue和React技术栈',
      },
      {
        id: 2,
        avatar:
          'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
        title: '李四',
        description: '后端开发工程师，擅长Java和Spring框架',
      },
      {
        id: 3,
        avatar:
          'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
        title: '王五',
        description: 'UI设计师，专注于用户体验设计',
      },
      {
        id: 4,
        avatar:
          'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
        title: '赵六',
        description: '全栈开发工程师，熟悉前后端技术',
      },
      {
        id: 5,
        avatar:
          'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
        title: '钱七',
        description: '产品经理，负责产品规划和设计',
      },
      {
        id: 6,
        avatar:
          'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
        title: '孙八',
        description: '测试工程师，确保产品质量',
      },
    ];
  }, 500);
});

// 处理操作按钮点击
const handleAction = ({ action, item }) => {
  console.log('执行操作:', action.name, '数据:', item);
  // 根据不同的操作执行不同的逻辑
  switch (action.name) {
    case 'delete': {
      // 删除逻辑
      break;
    }
    case 'edit': {
      // 编辑逻辑
      break;
    }
    // 其他操作...
  }
};

const pageDataRef = ref();
const addKnowledgeRef = ref();
const headerButtons = [
  {
    key: 'add',
    text: '新增知识库',
    icon: markRaw(Plus),
    type: 'primary',
    data: { action: 'add' },
  },
];
const handleButtonClick = (event, _item) => {
  switch (event.key) {
    case 'add': {
      addKnowledgeRef.value.openDialog();
      break;
    }
  }
};
const handleSearch = (params) => {
  pageDataRef.value.setQuery({ title: params, isQueryOr: true });
};
</script>

<template>
  <div class="knowledge-container">
    <div class="knowledge-header">
      <HeaderSearch
        :buttons="headerButtons"
        search-placeholder="搜索用户"
        @search="handleSearch"
        @button-click="handleButtonClick"
      />
    </div>
    <div class="kd-content-container">
      <PageData
        ref="pageDataRef"
        page-url="/api/v1/aiKnowledge/page"
        :page-size="10"
        :init-query-params="{ status: 1 }"
      >
        <template #default="{ pageList }">
          <CardPage
            title-key="title"
            avatar-key="icon"
            description-key="description"
            :data="pageList"
            :actions="actions"
            @action-click="handleAction"
          />
        </template>
      </PageData>
    </div>
    <!--    新增知识库模态框-->
    <AddKnowledgeModal ref="addKnowledgeRef" @success="handleAddSuccess" />
  </div>
</template>

<style scoped>
.knowledge-container {
  padding: 20px;
  width: 100%;
  margin: 0 auto;
}

h1 {
  text-align: center;
  margin-bottom: 30px;
  color: #303133;
}
.kd-content-container {
  margin-top: 20px;
}
</style>
