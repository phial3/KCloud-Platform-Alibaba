package io.laokou.admin.infrastructure.common.oauth2;

import com.google.gson.Gson;
import io.laokou.common.constant.Constant;
import io.laokou.common.exception.ErrorCode;
import io.laokou.common.utils.HttpContextUtil;
import io.laokou.common.utils.HttpResultUtil;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpStatus;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.web.filter.authc.AuthenticatingFilter;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * oauth2过滤器
 * @author Kou Shenhai
 */
@Slf4j
public class Oauth2Filter extends AuthenticatingFilter {

    @Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response){
        //获取请求token
        String Authorization = getAuthorization((HttpServletRequest) request);
        if(StringUtils.isBlank(Authorization)){
            return null;
        }
        return new Oauth2Token(Authorization);
    }

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        if(((HttpServletRequest) request).getMethod().equals(RequestMethod.OPTIONS.name())){
            return true;
        }
        String pathWithinApplication = getPathWithinApplication(request);
        log.info(pathWithinApplication);
        return false;
    }

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        //获取请求token，如果token为空，直接返回401
        String Authorization = getAuthorization((HttpServletRequest) request);
        log.info("Authorization:{}",Authorization);
        if(StringUtils.isBlank(Authorization)){
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            httpResponse.setContentType("application/json;charset=utf-8");
            httpResponse.setHeader("Access-Control-Allow-Credentials", "true");
            httpResponse.setHeader("Access-Control-Allow-Origin", HttpContextUtil.getOrigin());
            int unauthorized = ErrorCode.UNAUTHORIZED;
            HttpResultUtil<String> result = new HttpResultUtil().error(unauthorized);
            String json = new Gson().toJson(result);
            httpResponse.getWriter().print(json);
            return false;
        }
        return executeLogin(request, response);
    }

    @SneakyThrows
    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        httpResponse.setContentType("application/json;charset=utf-8");
        httpResponse.setHeader("Access-Control-Allow-Credentials", "true");
        httpResponse.setHeader("Access-Control-Allow-Origin", HttpContextUtil.getOrigin());
        //处理登录失败的异常
        Throwable throwable = e.getCause() == null ? e : e.getCause();
        HttpResultUtil result = new HttpResultUtil().error(HttpStatus.SC_UNAUTHORIZED, throwable.getMessage());
        String json = new Gson().toJson(result);
        httpResponse.getWriter().print(json);
        return false;
    }

    /**
     * 对跨域提供支持
     */
    @Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;
        httpServletResponse.setHeader("Access-control-Allow-Origin", HttpContextUtil.getOrigin());
        httpServletResponse.setHeader("Access-Control-Allow-Methods", "GET,POST,OPTIONS,PUT,DELETE");
        httpServletResponse.setHeader("Access-Control-Allow-Headers", httpServletRequest.getHeader("Access-Control-Request-Headers"));
        // 跨域时会首先发送一个option请求，这里我们给option请求直接返回正常状态
        if (httpServletRequest.getMethod().equals(RequestMethod.OPTIONS.name())) {
            httpServletResponse.setStatus(HttpStatus.SC_OK);
            return false;
        }
        return super.preHandle(request, response);
    }

    /**
     * 获取请求的token
     */
    private String getAuthorization(HttpServletRequest httpRequest){
        //从header中获取token
        String Authorization = httpRequest.getHeader(Constant.AUTHORIZATION_HEADER);

        //如果header中不存在Authorization，则从参数中获取Authorization
        if(StringUtils.isBlank(Authorization)){
            Authorization = httpRequest.getParameter(Constant.AUTHORIZATION_HEADER);
        }

        return Authorization;
    }

}