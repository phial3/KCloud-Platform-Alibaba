package io.laokou.admin.infrastructure.component;

import com.ctrip.framework.apollo.model.ConfigChangeEvent;
import com.ctrip.framework.apollo.spring.annotation.ApolloConfigChangeListener;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * sso
 * @author Kou Shenhai
 * @version 1.0
 * @date 2020/9/13 0013 下午 2:34
 */
@Component
@ConfigurationProperties(prefix = "sso")
@RefreshScope
@Data
@Slf4j
public class AuthHandler {

    private List<Map<String,String>> shiro;

    @Resource
    private org.springframework.cloud.context.scope.refresh.RefreshScope refreshScope;

    @ApolloConfigChangeListener
    private void changeHandler(ConfigChangeEvent event) {
        refreshScope.refreshAll();
        log.info("apollo动态拉取配置...");
    }

}