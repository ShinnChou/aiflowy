SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_ai_bot
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_bot`;
CREATE TABLE `tb_ai_bot`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键ID',
  `dept_id` bigint(0) UNSIGNED NOT NULL COMMENT '部门ID',
  `tenant_id` bigint(0) UNSIGNED NOT NULL COMMENT '租户ID',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `icon` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标',
  `llm_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT 'LLM ID',
  `llm_options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'LLM选项',
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '选项',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `created_by` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '创建者ID',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `modified_by` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '修改者ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_bot
-- ----------------------------
INSERT INTO `tb_ai_bot` VALUES (274724831961026560, 1, 1000000, '天气查询', '天气查询', NULL, 273418062806761472, '{\"systemPrompt\":\"你是天气查询助手\"}', NULL, '2025-04-29 15:19:24', 1, '2025-04-29 15:19:24', 1);

-- ----------------------------
-- Table structure for tb_ai_bot_conversation_message
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_bot_conversation_message`;
CREATE TABLE `tb_ai_bot_conversation_message`  (
  `session_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会话id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '会话标题',
  `bot_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT 'botid',
  `account_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `created` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`session_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_bot_conversation_message
-- ----------------------------

-- ----------------------------
-- Table structure for tb_ai_bot_knowledge
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_bot_knowledge`;
CREATE TABLE `tb_ai_bot_knowledge`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bot_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `knowledge_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_bot_knowledge
-- ----------------------------
INSERT INTO `tb_ai_bot_knowledge` VALUES (6, 267746165268017152, 267751447398232064, NULL);
INSERT INTO `tb_ai_bot_knowledge` VALUES (10, 269226938047168512, 273274084509630464, NULL);
INSERT INTO `tb_ai_bot_knowledge` VALUES (11, 267778325987205120, 273416394929192960, NULL);

-- ----------------------------
-- Table structure for tb_ai_bot_llm
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_bot_llm`;
CREATE TABLE `tb_ai_bot_llm`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `bot_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `llm_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_bot_llm
-- ----------------------------

-- ----------------------------
-- Table structure for tb_ai_bot_message
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_bot_message`;
CREATE TABLE `tb_ai_bot_message`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `bot_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT 'Bot ID',
  `account_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '关联的账户ID',
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会话ID',
  `role` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `image` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `prompt_tokens` int(0) NULL DEFAULT NULL,
  `completion_tokens` int(0) NULL DEFAULT NULL,
  `total_tokens` int(0) NULL DEFAULT NULL,
  `functions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '方法定义',
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created` datetime(0) NULL DEFAULT NULL,
  `modified` datetime(0) NULL DEFAULT NULL,
  `is_external_msg` int(0) NULL DEFAULT NULL COMMENT '1是external 消息，0: bot页面消息',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bot_id`(`bot_id`) USING BTREE,
  INDEX `account_id`(`account_id`) USING BTREE,
  INDEX `session_id`(`session_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Bot 消息记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_bot_message
-- ----------------------------

-- ----------------------------
-- Table structure for tb_ai_bot_plugins
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_bot_plugins`;
CREATE TABLE `tb_ai_bot_plugins`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `bot_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `plugin_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_bot_plugins
-- ----------------------------
INSERT INTO `tb_ai_bot_plugins` VALUES (267770208130498560, 267769906283216896, 267769494146711552, NULL);
INSERT INTO `tb_ai_bot_plugins` VALUES (274649868264542208, 269226938047168512, 267769494146711552, NULL);
INSERT INTO `tb_ai_bot_plugins` VALUES (274727326384918528, 274724831961026560, 273726420990324736, NULL);
INSERT INTO `tb_ai_bot_plugins` VALUES (274728813039194112, 267848016181075968, 267769494146711552, NULL);

-- ----------------------------
-- Table structure for tb_ai_bot_workflow
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_bot_workflow`;
CREATE TABLE `tb_ai_bot_workflow`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `bot_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `workflow_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_bot_workflow
-- ----------------------------

-- ----------------------------
-- Table structure for tb_ai_chat_message
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_chat_message`;
CREATE TABLE `tb_ai_chat_message`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `topic_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `role` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `image` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `prompt_tokens` int(0) NULL DEFAULT NULL,
  `completion_tokens` int(0) NULL DEFAULT NULL,
  `total_tokens` int(0) NULL DEFAULT NULL,
  `tools` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created` datetime(0) NULL DEFAULT NULL,
  `modified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `topic_id`(`topic_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI 消息记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_chat_message
-- ----------------------------

-- ----------------------------
-- Table structure for tb_ai_chat_topic
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_chat_topic`;
CREATE TABLE `tb_ai_chat_topic`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `account_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created` datetime(0) NULL DEFAULT NULL,
  `modified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `account_id`(`account_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI 话题表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_chat_topic
-- ----------------------------
INSERT INTO `tb_ai_chat_topic` VALUES (269265123934486528, 1, '未命名', '2025-04-14 13:44:28', NULL);

-- ----------------------------
-- Table structure for tb_ai_document
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_document`;
CREATE TABLE `tb_ai_document`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `knowledge_id` bigint(0) UNSIGNED NOT NULL COMMENT '知识库ID',
  `document_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文档类型 pdf/word/aieditor 等',
  `document_path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文档路径',
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `content_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容类型',
  `slug` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'URL 别名',
  `order_no` int(0) NULL DEFAULT NULL COMMENT '排序序号',
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '其他配置项',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `created_by` bigint(0) NULL DEFAULT NULL COMMENT '创建人ID',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '最后的修改时间',
  `modified_by` bigint(0) NULL DEFAULT NULL COMMENT '最后的修改人的ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `knowledge_id`(`knowledge_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文档' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_document
-- ----------------------------

-- ----------------------------
-- Table structure for tb_ai_document_chunk
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_document_chunk`;
CREATE TABLE `tb_ai_document_chunk`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `document_id` bigint(0) UNSIGNED NOT NULL COMMENT '文档ID',
  `knowledge_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '知识库ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '分块内容',
  `sorting` int(0) UNSIGNED NULL DEFAULT NULL COMMENT '分割顺序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_document_chunk
-- ----------------------------

-- ----------------------------
-- Table structure for tb_ai_document_history
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_document_history`;
CREATE TABLE `tb_ai_document_history`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `document_id` bigint(0) NULL DEFAULT NULL COMMENT '修改的文档ID',
  `old_title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '旧标题',
  `new_title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '新标题',
  `old_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '旧内容',
  `new_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '新内容',
  `old_document_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '旧的文档类型',
  `new_document_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '新的额文档类型',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `created_by` bigint(0) NULL DEFAULT NULL COMMENT '创建人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_document_history
-- ----------------------------

-- ----------------------------
-- Table structure for tb_ai_knowledge
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_knowledge`;
CREATE TABLE `tb_ai_knowledge`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `dept_id` bigint(0) UNSIGNED NOT NULL COMMENT '部门ID',
  `tenant_id` bigint(0) UNSIGNED NOT NULL COMMENT '租户ID',
  `icon` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ICON',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `slug` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'URL 别名',
  `vector_store_enable` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用向量存储',
  `vector_store_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '向量数据库类型',
  `vector_store_collection` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '向量数据库集合',
  `vector_store_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '向量数据库配置',
  `vector_embed_llm_id` bigint(0) NULL DEFAULT NULL COMMENT 'Embedding 模型ID',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `created_by` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '创建用户ID',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '最后一次修改时间',
  `modified_by` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '最后一次修改用户ID',
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '其他配置',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '知识库' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_knowledge
-- ----------------------------

-- ----------------------------
-- Table structure for tb_ai_llm
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_llm`;
CREATE TABLE `tb_ai_llm`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `dept_id` bigint(0) UNSIGNED NOT NULL COMMENT '部门ID',
  `tenant_id` bigint(0) UNSIGNED NOT NULL COMMENT '租户ID',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题或名称',
  `brand` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '品牌',
  `icon` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ICON',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `support_chat` tinyint(1) NULL DEFAULT NULL COMMENT '是否支持对话',
  `support_function_calling` tinyint(1) NULL DEFAULT NULL COMMENT '是否支持方法调用',
  `support_embed` tinyint(1) NULL DEFAULT NULL COMMENT '是否支持向量化',
  `support_reranker` tinyint(1) NULL DEFAULT NULL COMMENT '是否支持重排',
  `support_text_to_image` tinyint(1) NULL DEFAULT NULL COMMENT '是否支持文字生成图片',
  `support_image_to_image` tinyint(1) NULL DEFAULT NULL COMMENT '是否支持图片生成图片',
  `support_text_to_audio` tinyint(1) NULL DEFAULT NULL COMMENT '是否支持文字生成语音',
  `support_audio_to_audio` tinyint(1) NULL DEFAULT NULL COMMENT '是否支持语音生成语音',
  `support_text_to_video` tinyint(1) NULL DEFAULT NULL COMMENT '是否支持文字生成视频',
  `support_image_to_video` tinyint(1) NULL DEFAULT NULL COMMENT '是否支持图片生成视频',
  `llm_endpoint` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '大模型请求地址',
  `llm_model` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '大模型名称',
  `llm_api_key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '大模型 API KEY',
  `llm_extra_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '大模型其他属性配置',
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '其他配置内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_llm
-- ----------------------------
INSERT INTO `tb_ai_llm` VALUES (273418062806761472, 1, 1000000, '星火大模型', 'spark', NULL, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'wss://spark-api.xf-yun.com/v3.5/chat', 'wss://spark-api.xf-yun.com/v3.5/chat', '', '', NULL);

-- ----------------------------
-- Table structure for tb_ai_plugin
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_plugin`;
CREATE TABLE `tb_ai_plugin`  (
  `id` bigint(0) NOT NULL COMMENT '插件id',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `type` int(0) NULL DEFAULT NULL COMMENT '类型',
  `base_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '基础URL',
  `auth_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '认证方式  【apiKey/none】',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标地址',
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '认证参数位置 【headers, query】',
  `headers` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求头',
  `token_key` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'token键',
  `token_value` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'token值',
  `dept_id` bigint(0) NULL DEFAULT NULL COMMENT '部门id',
  `tenant_id` bigint(0) NULL DEFAULT NULL COMMENT '租户id',
  `created_by` bigint(0) NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_plugin
-- ----------------------------
INSERT INTO `tb_ai_plugin` VALUES (273726420990324736, '和风天气', '每日天气预报API，提供全球城市未来3-30天天气预报，包括：日出日落、月升月落、最高最低温度、天气白天和夜间状况、风力、风速、风向、相对湿度、大气压强、降水量、露点温度、紫外线强度、能见度等。', NULL, 'https://jw54e3j6ha.re.qweatherapi.com', 'apiKey', '2025-04-26 21:12:04', '/attachment/2025/04-26/cfa688d9-9bc5-4d3f-a50c-2501604e8bed.jpg', 'query', '[{\"label\":\"X-QW-Api-Key\",\"value\":\"2ad5de1c5dddd44e589bece44fdad4258\"}]', 'q', '', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for tb_ai_plugin_tool
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_plugin_tool`;
CREATE TABLE `tb_ai_plugin_tool`  (
  `id` bigint(0) NOT NULL COMMENT '插件工具id',
  `plugin_id` bigint(0) NOT NULL COMMENT '插件id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `base_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '基础路径',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `status` int(0) NULL DEFAULT NULL COMMENT '是否启用',
  `input_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '输入参数',
  `output_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '输出参数',
  `request_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求方式【Post, Get, Put, Delete】',
  `service_status` int(0) NULL DEFAULT NULL COMMENT '服务状态[0 下线 1 上线]',
  `debug_status` int(0) NULL DEFAULT NULL COMMENT '调试状态【0失败 1成功】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_plugin_tool
-- ----------------------------
INSERT INTO `tb_ai_plugin_tool` VALUES (273931608955039744, 273726420990324736, 'get_weather', '查询某个城市地方未来三天的天气', '/v7/weather/3d', '2025-04-27 10:47:25', NULL, '[{\"name\":\"location\",\"description\":\"城市 LocationID（如 101010100 代表北京），可通过城市列表查询，当用户问及例如北京的天气的时候，大模型需要查询北京转换为对应的城市id\",\"type\":\"String\",\"method\":\"Query\",\"required\":true,\"defaultValue\":\"101010100\",\"enabled\":true,\"key\":\"1745905802390\"}]', NULL, 'Get', 0, 0);
INSERT INTO `tb_ai_plugin_tool` VALUES (275035209345548290, 273726420990324736, 'get_cityId', '城市搜索API提供全球地理位位置、全球城市搜索服务，支持经纬度坐标反查、多语言、模糊搜索等功能。', '/geo/v2/city/lookup', '2025-04-30 11:52:44', NULL, '[{\"name\":\"location\",\"description\":\"需要查询地区的名称，支持文字、以英文逗号分隔的经度,纬度坐标（十进制，最多支持小数点后两位）、LocationID或Adcode（仅限中国城市）。例如 location=北京 或 location=116.41,39.92\",\"type\":\"String\",\"method\":\"Query\",\"required\":true,\"defaultValue\":\"\",\"enabled\":true,\"key\":\"1745985221077\"}]', NULL, 'Get', 0, 0);

-- ----------------------------
-- Table structure for tb_ai_plugins
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_plugins`;
CREATE TABLE `tb_ai_plugins`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键',
  `dept_id` bigint(0) UNSIGNED NOT NULL COMMENT '部门ID',
  `tenant_id` bigint(0) UNSIGNED NOT NULL COMMENT '租户ID',
  `plugin_type` tinyint(0) NOT NULL DEFAULT 1 COMMENT '插件类型',
  `plugin_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '插件名称',
  `plugin_desc` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '插件描述',
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '插件配置',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '数据状态',
  `created` datetime(0) NOT NULL COMMENT '创建时间',
  `created_by` bigint(0) UNSIGNED NOT NULL COMMENT '创建者',
  `modified` datetime(0) NOT NULL COMMENT '修改时间',
  `modified_by` bigint(0) UNSIGNED NOT NULL COMMENT '修改者',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '删除标识',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '插件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_plugins
-- ----------------------------
INSERT INTO `tb_ai_plugins` VALUES (267769494146711552, 1, 1000000, 1, 'get_ip_info', '根据ip获取区域信息', '{\"method\":\"GET\",\"url\":\"https://qifu-api.baidubce.com/ip/geo/v1/district\",\"headers\":[],\"params\":[{\"key\":\"ip\",\"value\":\"\",\"desc\":\"IP地址\"}],\"body\":{}}', 1, '2025-04-10 10:41:22', 1, '2025-04-29 10:21:07', 1, '', 0, NULL);
INSERT INTO `tb_ai_plugins` VALUES (269229432299077632, 1, 1000000, 1, 'test', 'test', NULL, 1, '2025-04-14 11:22:39', 1, '2025-04-14 11:22:39', 1, '', 0, '/attachment/2025/04-14/e2f3e5a5-a4fa-4abe-8fe6-49d10c3d8dbe.jpeg');

-- ----------------------------
-- Table structure for tb_ai_workflow
-- ----------------------------
DROP TABLE IF EXISTS `tb_ai_workflow`;
CREATE TABLE `tb_ai_workflow`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT 'ID 主键',
  `dept_id` bigint(0) UNSIGNED NOT NULL COMMENT '部门ID',
  `tenant_id` bigint(0) UNSIGNED NOT NULL COMMENT '租户ID',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `icon` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ICON',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '工作流设计的 JSON 内容',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `created_by` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '创建人',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '最后修改时间',
  `modified_by` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '最后修改的人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ai_workflow
-- ----------------------------

-- ----------------------------
-- Table structure for tb_sys_account
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_account`;
CREATE TABLE `tb_sys_account`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键',
  `dept_id` bigint(0) UNSIGNED NOT NULL COMMENT '部门ID',
  `tenant_id` bigint(0) UNSIGNED NOT NULL COMMENT '租户ID',
  `login_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录账号',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `account_type` tinyint(0) NOT NULL DEFAULT 0 COMMENT '账户类型',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '昵称',
  `mobile` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机电话',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '邮件',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '账户头像',
  `data_scope` int(0) NULL DEFAULT 1 COMMENT '数据权限类型',
  `dept_id_list` json NULL COMMENT '自定义部门权限',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '数据状态',
  `created` datetime(0) NOT NULL COMMENT '创建时间',
  `created_by` bigint(0) UNSIGNED NOT NULL COMMENT '创建者',
  `modified` datetime(0) NOT NULL COMMENT '修改时间',
  `modified_by` bigint(0) UNSIGNED NOT NULL COMMENT '修改者',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_login_name`(`login_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_account
-- ----------------------------
INSERT INTO `tb_sys_account` VALUES (1, 1, 1000000, 'admin', '$2a$10$S8HVnrS8m7iygQBS7r1dYuOstEUl5q/W1yhgFcS1uyL6o2/23yUYO', 99, '超级管理员', '15555555555', 'aaa@qq.com', '/attachment/2025/04-10/59866709-5bc5-4e9f-9445-ecb603ff2d82.jpg', 1, NULL, 1, '2025-04-10 16:33:48', 1, '2025-04-10 17:56:17', 1, '', 0);

-- ----------------------------
-- Table structure for tb_sys_account_position
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_account_position`;
CREATE TABLE `tb_sys_account_position`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键',
  `account_id` bigint(0) UNSIGNED NOT NULL COMMENT '用户ID',
  `position_id` bigint(0) UNSIGNED NOT NULL COMMENT '职位ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户-职位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_account_position
-- ----------------------------
INSERT INTO `tb_sys_account_position` VALUES (267858187553452032, 1, 259067270360543232);

-- ----------------------------
-- Table structure for tb_sys_account_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_account_role`;
CREATE TABLE `tb_sys_account_role`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键',
  `account_id` bigint(0) UNSIGNED NOT NULL COMMENT '用户ID',
  `role_id` bigint(0) UNSIGNED NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户-角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_account_role
-- ----------------------------
INSERT INTO `tb_sys_account_role` VALUES (267858187456983040, 1, 1);

-- ----------------------------
-- Table structure for tb_sys_api_key
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_api_key`;
CREATE TABLE `tb_sys_api_key`  (
  `id` bigint(0) NOT NULL COMMENT 'id',
  `api_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'apiKey',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '状态1启用 2失效',
  `dept_id` bigint(0) NULL DEFAULT NULL COMMENT '部门id',
  `tenant_id` bigint(0) NULL DEFAULT NULL COMMENT '租户id',
  `expired_at` datetime(0) NULL DEFAULT NULL COMMENT '失效时间',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_api_key
-- ----------------------------
INSERT INTO `tb_sys_api_key` VALUES (275081657634275328, '8e8ca1ff71d1430d9ad2a074f5901ed8', '2025-04-30 14:57:18', 1, 1, 1000000, '2025-05-30 00:00:00', 1);

-- ----------------------------
-- Table structure for tb_sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_dept`;
CREATE TABLE `tb_sys_dept`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键',
  `tenant_id` bigint(0) UNSIGNED NOT NULL COMMENT '租户ID',
  `parent_id` bigint(0) UNSIGNED NOT NULL COMMENT '父级ID',
  `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '父级部门ID集合',
  `dept_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
  `dept_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门编码',
  `sort_no` int(0) NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '数据状态',
  `created` datetime(0) NOT NULL COMMENT '创建时间',
  `created_by` bigint(0) UNSIGNED NOT NULL COMMENT '创建者',
  `modified` datetime(0) NOT NULL COMMENT '修改时间',
  `modified_by` bigint(0) UNSIGNED NOT NULL COMMENT '修改者',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_dept
-- ----------------------------
INSERT INTO `tb_sys_dept` VALUES (1, 1000000, 0, '0', '总公司', 'root_dept', 0, 1, '2025-03-17 09:09:57', 1, '2025-03-17 09:10:00', 1, '', 0);

-- ----------------------------
-- Table structure for tb_sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_dict`;
CREATE TABLE `tb_sys_dict`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '数据字典名称',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '字典编码',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典描述或备注',
  `dict_type` tinyint(0) NULL DEFAULT NULL COMMENT '字典类型 1 自定义字典、2 数据表字典、 3 枚举类字典、 4 系统字典（自定义 DictLoader）',
  `sort_no` int(0) NULL DEFAULT NULL COMMENT '排序编号',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '是否启用',
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '扩展字典  存放 json',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `key`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_dict
-- ----------------------------
INSERT INTO `tb_sys_dict` VALUES (268213400717598720, 'test', 'test', 'test', 1, NULL, NULL, '{}', '2025-04-11 16:05:18', '2025-04-11 16:05:18');

-- ----------------------------
-- Table structure for tb_sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_dict_item`;
CREATE TABLE `tb_sys_dict_item`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键',
  `dict_id` bigint(0) UNSIGNED NOT NULL COMMENT '归属哪个字典',
  `text` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '名称或内容',
  `value` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '值',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `sort_no` int(0) NOT NULL DEFAULT 0 COMMENT '排序',
  `css_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'css样式内容',
  `css_class` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'css样式类名',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `status` tinyint(0) NULL DEFAULT 0 COMMENT '状态',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '数据字典内容' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_dict_item
-- ----------------------------

-- ----------------------------
-- Table structure for tb_sys_log
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_log`;
CREATE TABLE `tb_sys_log`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `account_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '操作人',
  `action_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作名称',
  `action_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作的类型',
  `action_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作涉及的类',
  `action_method` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作涉及的方法',
  `action_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作涉及的 URL 地址',
  `action_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作涉及的用户 IP 地址',
  `action_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '操作请求参数',
  `action_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '操作请求body',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '操作状态 1 成功 9 失败',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for tb_sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_menu`;
CREATE TABLE `tb_sys_menu`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键',
  `parent_id` bigint(0) UNSIGNED NOT NULL COMMENT '父菜单id',
  `menu_type` int(0) NOT NULL COMMENT '菜单类型',
  `menu_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单标题',
  `menu_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单url',
  `component` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '组件路径',
  `menu_icon` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '图标/图片地址',
  `is_show` int(0) NOT NULL DEFAULT 1 COMMENT '是否显示',
  `permission_tag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '权限标识',
  `sort_no` int(0) NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '数据状态',
  `created` datetime(0) NOT NULL COMMENT '创建时间',
  `created_by` bigint(0) UNSIGNED NOT NULL COMMENT '创建者',
  `modified` datetime(0) NOT NULL COMMENT '修改时间',
  `modified_by` bigint(0) UNSIGNED NOT NULL COMMENT '修改者',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_menu
-- ----------------------------
INSERT INTO `tb_sys_menu` VALUES (258052082618335232, 0, 0, '系统管理', '', '', 'ControlOutlined', 1, '', 999, 0, '2025-03-14 15:07:51', 1, '2025-04-08 11:12:00', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (258052774330368000, 258052082618335232, 0, '用户管理', '/sys/sysAccount', '', 'UserOutlined', 1, '', 0, 0, '2025-03-14 15:10:36', 1, '2025-03-14 15:10:36', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (258075705244676096, 258052082618335232, 0, '角色管理', '/sys/sysRole', '', 'FrownOutlined', 1, '', 11, 0, '2025-03-14 16:41:43', 1, '2025-03-14 16:41:43', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (258075850434703360, 258052082618335232, 0, '菜单管理', '/sys/sysMenu', '', 'ApartmentOutlined', 1, '', 21, 0, '2025-03-14 16:42:18', 1, '2025-03-14 16:42:18', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (258077347000119296, 258052774330368000, 1, '用户查询', '', '', NULL, 0, 'sysUser:list', 1, 0, '2025-03-14 16:48:14', 1, '2025-03-14 16:48:14', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (258079445137780736, 258052774330368000, 1, '用户保存', '', '', NULL, 1, 'sysUser:save', 2, 0, '2025-03-14 16:56:35', 1, '2025-03-14 16:56:35', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259048038847483904, 258052082618335232, 0, '部门管理', '/sys/sysDept', '', 'BankOutlined', 1, '', 31, 0, '2025-03-17 09:05:25', 1, '2025-03-17 09:05:25', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259065916854448128, 258052082618335232, 0, '岗位管理', '/sys/sysPosition', '', 'AuditOutlined', 1, '', 32, 0, '2025-03-17 10:16:28', 1, '2025-03-17 10:16:28', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259166589327630336, 0, 0, '欢迎回来', '/index', '', 'BorderlessTableOutlined', 1, '', 0, 0, '2025-03-17 16:56:30', 1, '2025-03-17 16:56:30', 1, '', 1);
INSERT INTO `tb_sys_menu` VALUES (259168688849412096, 0, 0, '系统配置', '', '', NULL, 1, '', 99999, 0, '2025-03-17 17:04:51', 1, '2025-03-17 17:04:51', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259168810450673664, 259168688849412096, 0, 'AI大模型', '/config/model', '', 'DeploymentUnitOutlined', 1, '', 0, 0, '2025-03-17 17:05:20', 1, '2025-03-17 17:05:20', 1, '', 1);
INSERT INTO `tb_sys_menu` VALUES (259168916721754112, 259168688849412096, 0, '系统设置', 'sys/settings', '', 'SettingOutlined', 1, '', 12, 0, '2025-03-17 17:05:45', 1, '2025-04-17 15:54:39', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259169177682960384, 258052082618335232, 0, '数据字典', '/sys/dicts', '', 'AppstoreOutlined', 1, '', 51, 0, '2025-03-17 17:06:47', 1, '2025-04-14 13:35:41', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259169318720626688, 258052082618335232, 0, '日志管理', '/sys/logs', '', 'ExclamationCircleOutlined', 1, '', 61, 0, '2025-03-17 17:07:21', 1, '2025-04-14 13:35:34', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259169540360232960, 0, 0, 'AI能力', '', '', NULL, 1, '', 21, 0, '2025-03-17 17:08:14', 1, '2025-03-17 17:08:14', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259169689438380032, 259169540360232960, 0, '大模型商店', '/ai/ollama', '', 'SlackSquareFilled', 1, '', 1111, 0, '2025-03-17 17:08:49', 1, '2025-04-08 12:24:03', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259169837824466944, 259169540360232960, 0, 'Bots', '/ai/bots', '', 'TwitchOutlined', 1, '', 11, 0, '2025-03-17 17:09:24', 1, '2025-03-17 17:09:24', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259169982154661888, 259169540360232960, 0, '插件', '/ai/plugin', '', 'RobotOutlined', 1, '', 21, 0, '2025-03-17 17:09:59', 1, '2025-04-25 11:23:15', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259170117110587392, 259169540360232960, 0, '工作流', '/ai/workflow', '', 'BranchesOutlined', 1, '', 31, 0, '2025-03-17 17:10:31', 1, '2025-03-17 17:10:31', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259170422338478080, 259169540360232960, 0, '知识库', '/ai/knowledge', '', 'ReadOutlined', 1, '', 51, 0, '2025-03-17 17:11:44', 1, '2025-03-17 17:11:44', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (259170538264846336, 259169540360232960, 0, '大模型', '/ai/llms', '', 'SlidersOutlined', 1, '', 61, 0, '2025-03-17 17:12:11', 1, '2025-04-14 10:49:05', 1, '', 0);
INSERT INTO `tb_sys_menu` VALUES (269220820365377536, 259170422338478080, 0, '知识库', '/ai/knowledge/document', '', 'ZhihuSquareFilled', 1, '', 1, 0, '2025-04-14 10:48:25', 1, '2025-04-14 10:50:19', 1, '', 1);
INSERT INTO `tb_sys_menu` VALUES (269221948243083264, 259170422338478080, 1, '知识库', '/ai/knowledge/Document', '', 'BookFilled', 1, '', 1, 0, '2025-04-14 10:52:54', 1, '2025-04-14 10:52:54', 1, '', 1);
INSERT INTO `tb_sys_menu` VALUES (270761213536096256, 258052082618335232, 0, 'apiKey', '/sys/sysApiKey', '', 'PoundOutlined', 1, '', 22, 0, '2025-04-18 16:49:24', 1, '2025-04-30 14:55:15', 1, '', 0);

-- ----------------------------
-- Table structure for tb_sys_option
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_option`;
CREATE TABLE `tb_sys_option`  (
  `tenant_id` bigint(0) UNSIGNED NOT NULL COMMENT '租户ID',
  `key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置KEY',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '配置内容',
  INDEX `uni_key`(`tenant_id`, `key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统配置信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_option
-- ----------------------------

-- ----------------------------
-- Table structure for tb_sys_position
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_position`;
CREATE TABLE `tb_sys_position`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键',
  `tenant_id` bigint(0) UNSIGNED NOT NULL COMMENT '租户ID',
  `dept_id` bigint(0) UNSIGNED NOT NULL COMMENT '部门ID',
  `position_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `position_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '岗位编码',
  `sort_no` int(0) NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '数据状态',
  `created` datetime(0) NOT NULL COMMENT '创建时间',
  `created_by` bigint(0) UNSIGNED NOT NULL COMMENT '创建者',
  `modified` datetime(0) NOT NULL COMMENT '修改时间',
  `modified_by` bigint(0) UNSIGNED NOT NULL COMMENT '修改者',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '职位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_position
-- ----------------------------
INSERT INTO `tb_sys_position` VALUES (259067270360543232, 1000000, 1, '总部CTO', '', 0, 1, '2025-03-17 10:21:50', 1, '2025-03-17 10:21:50', 1, '', 0);

-- ----------------------------
-- Table structure for tb_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_role`;
CREATE TABLE `tb_sys_role`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键',
  `tenant_id` bigint(0) UNSIGNED NOT NULL COMMENT '租户ID',
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色标识',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '数据状态',
  `created` datetime(0) NOT NULL COMMENT '创建时间',
  `created_by` bigint(0) UNSIGNED NOT NULL COMMENT '创建者',
  `modified` datetime(0) NOT NULL COMMENT '修改时间',
  `modified_by` bigint(0) UNSIGNED NOT NULL COMMENT '修改者',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_tenant_role`(`tenant_id`, `role_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_role
-- ----------------------------
INSERT INTO `tb_sys_role` VALUES (1, 1000000, '超级管理员', 'super_admin', 1, '2025-03-14 14:52:37', 1, '2025-03-14 14:52:37', 1, '', 0);

-- ----------------------------
-- Table structure for tb_sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_role_menu`;
CREATE TABLE `tb_sys_role_menu`  (
  `id` bigint(0) UNSIGNED NOT NULL COMMENT '主键',
  `role_id` bigint(0) UNSIGNED NOT NULL COMMENT '角色ID',
  `menu_id` bigint(0) UNSIGNED NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色-菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sys_role_menu
-- ----------------------------
INSERT INTO `tb_sys_role_menu` VALUES (259111372649250817, 1, 258052774330368000);
INSERT INTO `tb_sys_role_menu` VALUES (259111372649250818, 1, 258075705244676096);
INSERT INTO `tb_sys_role_menu` VALUES (259111372649250819, 1, 258075850434703360);
INSERT INTO `tb_sys_role_menu` VALUES (259111372649250820, 1, 258077347000119296);
INSERT INTO `tb_sys_role_menu` VALUES (259111372649250821, 1, 258079445137780736);
INSERT INTO `tb_sys_role_menu` VALUES (259111372649250822, 1, 259048038847483904);
INSERT INTO `tb_sys_role_menu` VALUES (259111372649250824, 1, 259065916854448128);
INSERT INTO `tb_sys_role_menu` VALUES (259111372649250825, 1, 258052082618335232);
INSERT INTO `tb_sys_role_menu` VALUES (259168688966852608, 1, 259168688849412096);
INSERT INTO `tb_sys_role_menu` VALUES (259168916826611712, 1, 259168916721754112);
INSERT INTO `tb_sys_role_menu` VALUES (259169177817178112, 1, 259169177682960384);
INSERT INTO `tb_sys_role_menu` VALUES (259169318829678592, 1, 259169318720626688);
INSERT INTO `tb_sys_role_menu` VALUES (259169540477673472, 1, 259169540360232960);
INSERT INTO `tb_sys_role_menu` VALUES (259169689576792064, 1, 259169689438380032);
INSERT INTO `tb_sys_role_menu` VALUES (259169837941907456, 1, 259169837824466944);
INSERT INTO `tb_sys_role_menu` VALUES (259169982280491008, 1, 259169982154661888);
INSERT INTO `tb_sys_role_menu` VALUES (259170117223833600, 1, 259170117110587392);
INSERT INTO `tb_sys_role_menu` VALUES (259170422447529984, 1, 259170422338478080);
INSERT INTO `tb_sys_role_menu` VALUES (259170538378092544, 1, 259170538264846336);
INSERT INTO `tb_sys_role_menu` VALUES (270761213603205120, 1, 270761213536096256);

SET FOREIGN_KEY_CHECKS = 1;
