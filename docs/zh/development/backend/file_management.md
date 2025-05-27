# 文件管理

## 前言
文件存储指的是 AIFlowy 用于接收、存储和管理前端上传的文件。
FileStorageService
在 AIFlowy 中，内置了一个名为 FileStorageService的接口，以及默认的实现类 LocalFileStorageServiceImpl。
LocalFileStorageServiceImpl 主要是用于把上传文件存储在目录 /attachement/年/月-日/ 目录下，同时提供了文件存储目录配置 AIFlowy.storage.local.root的配置。
例如：

```yml
aiflowy:
  storage:
    type: local
    local:
      # 文件存储的根目录，默认在 target目录下，生产环境部署请修改！
      root: /rootPath
spring:
  web:
    resources:
      # 修改完上述配置后同步修改这里
      static-locations: file:/rootPath
```
> <span style="color: red;font-weight: bold;">注意：不建议使用默认存储方式，默认方式仅用于测试。生产环境建议使用 s3 方式来存储文件。</span>

**如果使用默认存储方式来部署，前端页面需要转发 `/attachment/` 路径才能正常访问文件。nginx 配置如下：**
```
  location /attachment {
	proxy_pass http://127.0.0.1:8080/static/attachment ;
  }
```

以上配置，指的是使用 LocalFileStorageServiceImpl这个实现类来进行文件存储，同时存储的目录为：/rootPath。
自定义存储类型
在 AIFlowy 中，扩展自己的自定义存储类型非常简单。我们只需要编写一个类，实现 FileStorageService接口，并通过 @Component注解为当前的实现类型取个名字，如下代码所示：

```Java
@Component("myStorage")
public class MyFileStorageServiceImpl implements FileStorageService {

    @Override
    public String save(MultipartFile file) {
        // 在这里，去实现你的文件存储逻辑
    }
}
```

最后，我们修改一下配置内容的 aiflowy.storage.type 为 @component定义的名称 myStorage，如下代码所示：

```yml
adflowy:
  storage:
    type: myStorage
```