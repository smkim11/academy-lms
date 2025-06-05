package com.example.academylms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
@ServletComponentScan // 필터
public class AcademyLmsApplication implements WebMvcConfigurer{

	public static void main(String[] args) {
		SpringApplication.run(AcademyLmsApplication.class, args);
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/semi/**").addResourceLocations("file:///C:/semi");
	}
}
