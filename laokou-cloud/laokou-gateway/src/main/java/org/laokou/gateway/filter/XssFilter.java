/**
 * Copyright (c) 2022 KCloud-Platform-Alibaba Authors. All Rights Reserved.
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.laokou.gateway.filter;
import lombok.extern.slf4j.Slf4j;
import org.laokou.common.core.constant.Constant;
import org.laokou.common.i18n.utils.StringUtil;
import org.laokou.common.core.utils.XssUtil;
import org.laokou.gateway.constant.GatewayConstant;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.util.UriComponentsBuilder;
import reactor.core.publisher.Mono;
import java.net.URI;
/**
 * @author laokou
 */
@Component
@Slf4j
public class XssFilter implements GlobalFilter, Ordered {

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        ServerHttpRequest request = exchange.getRequest();
        String method = request.getMethod().name();
        // 请求带ticket，无需xss
        String xssTicket = request.getHeaders().getFirst(GatewayConstant.XSS_TICKET_HEADER);
        if (GatewayConstant.XSS_TICKET_VALUE.equals(xssTicket)) {
            return chain.filter(exchange);
        }
        switch (method) {
            case "GET" -> {
                return xssGet(request,exchange,chain);
            }
            case "POST", "PUT" -> {
                return xssPostOrPut(request,exchange,chain);
            }
            default -> {
                return chain.filter(exchange);
            }
        }
    }

    /**
     * 过滤get请求
     * @param request
     * @param exchange
     * @param chain
     * @return
     */
    private Mono<Void> xssGet(ServerHttpRequest request,ServerWebExchange exchange, GatewayFilterChain chain) {
        // 参数为空方向
        URI uri = request.getURI();
        String rawQuery = uri.getRawQuery();
        if (StringUtil.isEmpty(rawQuery)) {
            return chain.filter(exchange);
        }
        String[] query = rawQuery.split(Constant.AND);
        StringBuffer sb = new StringBuffer();
        for (String str : query) {
            sb.append(XssUtil.clean(str)).append(Constant.AND);
        }
        // 过滤后，重新构建请求体
        rawQuery = sb.toString();
        rawQuery = rawQuery.substring(0,rawQuery.length() - 1);
        URI newUri = UriComponentsBuilder.fromUri(uri)
                .replaceQuery(rawQuery)
                .build(true).toUri();
        return chain.filter(exchange.mutate().request(request.mutate().uri(newUri).build()).build());
    }

    private Mono<Void> xssPostOrPut(ServerHttpRequest request,ServerWebExchange exchange, GatewayFilterChain chain) {
        MediaType mediaType = request.getHeaders().getContentType();
        if (MediaType.APPLICATION_FORM_URLENCODED.isCompatibleWith(mediaType) || MediaType.APPLICATION_JSON.isCompatibleWith(mediaType)) {
            return chain.filter(exchange);
        } else {
            return chain.filter(exchange);
        }
    }

    @Override
    public int getOrder() {
        return Ordered.HIGHEST_PRECEDENCE + 1000;
    }

}
