package tech.aiflowy.common.ai.util;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.http.*;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;

import java.util.*;

public class PluginHttpClient {

    private static final int TIMEOUT = 10_000;

    public static JSONObject sendRequest(String url, String method,
                                         Map<String, Object> headers,
                                         List<PluginParam> pluginParams) {
        // 1. 处理路径参数
        String processedUrl = replacePathVariables(url, pluginParams);

        // 2. 初始化请求
        Method httpMethod = Method.valueOf(method.toUpperCase());
        HttpRequest request = HttpRequest.of(processedUrl)
                .method(httpMethod)
                .timeout(TIMEOUT);

        // 3. 处理请求头（合并默认头和参数头）
        processHeaders(request, headers, pluginParams);

        // 4. 处理查询参数和请求体
        processQueryAndBodyParams(request, httpMethod, pluginParams);

        // 5. 执行请求
        HttpResponse response = request.execute();
        return JSONUtil.parseObj(response.body());
    }

    /**
     * 处理请求头（合并默认头和参数头）
     */
    private static void processHeaders(HttpRequest request,
                                       Map<String, Object> defaultHeaders,
                                       List<PluginParam> params) {
        // 添加默认头
        if (ObjectUtil.isNotEmpty(defaultHeaders)) {
            defaultHeaders.forEach((k, v) -> request.header(k, v.toString()));
        }

        // 添加参数中指定的头
        params.stream()
                .filter(p -> "header".equalsIgnoreCase(p.getMethod()) && p.isEnabled())
                .forEach(p -> request.header(p.getName(), p.getDefaultValue().toString()));
    }

    /**
     * 处理查询参数和请求体
     */
    private static void processQueryAndBodyParams(HttpRequest request,
                                                  Method httpMethod,
                                                  List<PluginParam> params) {
        Map<String, Object> queryParams = new HashMap<>();
        Map<String, Object> bodyParams = new HashMap<>();

        // 分类参数
        params.stream()
                .filter(PluginParam::isEnabled)
                .forEach(p -> {
                    String methodType = p.getMethod().toLowerCase();
                    switch (methodType) {
                        case "query":
                            queryParams.put(p.getName(), p.getDefaultValue());
                            break;
                        case "body":
                            bodyParams.put(p.getName(), p.getDefaultValue());
                            break;
                    }
                });

        // 设置查询参数
        if (!queryParams.isEmpty()) {
            request.form(queryParams);
        }

        // 设置请求体（仅POST/PUT）
        if (!bodyParams.isEmpty() && (httpMethod == Method.POST || httpMethod == Method.PUT)) {
            request.body(JSONUtil.toJsonStr(bodyParams))
                    .header(Header.CONTENT_TYPE, ContentType.JSON.getValue());
        }
    }

    /**
     * 替换URL中的路径变量 {xxx}
     */
    private static String replacePathVariables(String url, List<PluginParam> params) {
        String result = url;

        // 收集路径参数
        Map<String, Object> pathParams = new HashMap<>();
        params.stream()
                .filter(p -> "path".equalsIgnoreCase(p.getMethod()) && p.isEnabled())
                .forEach(p -> pathParams.put(p.getName(), p.getDefaultValue()));

        // 替换变量
        for (Map.Entry<String, Object> entry : pathParams.entrySet()) {
            result = result.replaceAll("\\{" + entry.getKey() + "\\}",
                    entry.getValue().toString());
        }

        return result;
    }
}
