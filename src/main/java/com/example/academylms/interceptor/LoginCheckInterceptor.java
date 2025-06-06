package com.example.academylms.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginCheckInterceptor implements HandlerInterceptor {  // 컨트롤러에 들어가기 전에 세션값이 있는지 검사

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession(false); // false 없으면 null 반환 
		Integer userId = (session != null) ?
				(Integer)session.getAttribute("loginUserId"): null;
		
		if (userId == null) {  // session 값이 없음.
			response.sendRedirect("/login");
			return false;
		}
		
		return true; // 로그인된 사용자면 통과
	}

	
}
