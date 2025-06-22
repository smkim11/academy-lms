package com.example.academylms.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.academylms.interceptor.LoginCheckInterceptor;

@Configuration  
public class WebConfig implements WebMvcConfigurer {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
	    registry.addInterceptor(new LoginCheckInterceptor())
	            .addPathPatterns("/**")
	            .excludePathPatterns(
	                "/login",          // GET /login
	                "/login/**",       // POST /login 및 하위 (예외 처리 확실하게)
	                "/logout",         // 로그아웃
	                "/css/**",
	                "/js/**",
	                "/images/**",
	                "/common/**",
	                "/findPassword",   // GET /findPassword
	                "/findPassword/**",// POST /findPassword
	                "/semi/**",
	                "/questionType/**",
	                "/api/qna/**",
	                "/statistics/**",
	                "/api/notices/**",
	                "/api/mainPage/**",
	                "/validateEmail",
	                "/api/lectureMaterial"
	            );
	}

  
	
	
}
