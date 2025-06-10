package com.example.academylms.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.academylms.interceptor.LoginCheckInterceptor;

// @Configuration 완료후에 뺴야함. 
public class WebConfig implements WebMvcConfigurer {

	@Override
	public void addInterceptors(InterceptorRegistry registry) { // Interceptor 범위 설정 
		registry.addInterceptor(new LoginCheckInterceptor())
				.addPathPatterns("/**") // 모든 요청 검사
				.excludePathPatterns("/login", "loginForm", "/logout",
						  "/css/**", "/js/**" , "/images/**" 
						); //  로그인 및 정적 리소스는 Interceptor 에서 제외한다.
				
		
	}
  
	
	
}
