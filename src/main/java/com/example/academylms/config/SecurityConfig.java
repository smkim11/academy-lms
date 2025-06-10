package com.example.academylms.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class SecurityConfig {

	@Bean
	public PasswordEncoder passwordEncoder() {  // 비밀번호 암호화 BCrypt 알고리즘 Bean 등록
		return new BCryptPasswordEncoder();  
	}
	
}
