package tech.aiflowy.system.service.impl;

import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import tech.aiflowy.system.entity.SysApiKey;
import tech.aiflowy.system.mapper.SysApiKeyMapper;
import tech.aiflowy.system.service.SysApiKeyService;

/**
 *  服务层实现。
 *
 * @author Administrator
 * @since 2025-04-18
 */
@Service
public class SysApiKeyServiceImpl extends ServiceImpl<SysApiKeyMapper, SysApiKey>  implements SysApiKeyService {

}
