import { api } from '#/api/request.js';

// 获取LLM品牌列表
export async function getLlmBrandList() {
  return api.get('/api/v1/aiLlmBrand/list?asTree=true');
}

// 保存LLM
export async function saveLlm(data: string) {
  return api.post('/api/v1/aiLlm/save', data);
}
