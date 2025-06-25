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
		
		if(session == null ||  session.getAttribute("userRole") == null ) {
			response.sendRedirect("/login");
			return false;
		}
		
		String role = (String) session.getAttribute("userRole");
		String uri = request.getRequestURI().substring(request.getContextPath().length());
		
		
		if (uri.equals("/login") || uri.equals("/logout") 
			    || uri.startsWith("/css") || uri.startsWith("/js") 
			    || uri.startsWith("/images") || uri.startsWith("/common") 
			    || uri.equals("/findPw") ) 
			{
			    return true;
			}

		
		if("admin".equals(role)) {
			if (uri.startsWith("/admin") || uri.equals("/mainPage") ||uri.equals("/admin/myPage")  ||uri.equals("/lectureMaterialList") || uri.equals("/lectureMaterialOne")
					|| uri.equals("/lectureMaterialWeekList") || uri.equals("/updateLectureMaterial") || uri.equals("/addLectureMaterial") || uri.equals("/deleteLectureMaterial")
					|| uri.equals("/qna") ||uri.equals("/qnaOne") || uri.equals("/deleteQna") || uri.equals("/addAnswer") || uri.equals("/deleteAnswer") || uri.equals("/quizList")
					|| uri.equals("/quizResult") || uri.equals("/privacy")) {
				return true;
			}
			response.sendRedirect("/login");
			return false;
		} else if("instructor".equals(role)) {
			if (uri.startsWith("/instructor") || uri.equals("/mainPage") || uri.equals("/lectureMaterialList") || uri.equals("/lectureMaterialOne")
					 || uri.equals("/addLectureMaterial") || uri.equals("/lectureMaterialWeekList") || uri.equals("/updateLectureMaterial") || uri.equals("/deleteLectureMaterial")
					 || uri.equals("/qna") || uri.equals("/qnaOne") || uri.equals("/addAnswer") || uri.equals("/deleteAnswer") || uri.equals("/quizList")
					 || uri.equals("/addQuiz") || uri.equals("/updateQuiz") || uri.equals("/quizResult") ||  uri.equals("/deleteQuiz") || uri.equals("/deleteQuizOne")) 
			 {
				return true;
			 }
			response.sendRedirect("/login");
			return false;
		} else if("student".equals(role)) {
			if (uri.startsWith("/student") || uri.equals("/mainPage") || uri.equals("/lectureMaterialList") || uri.equals("/lectureMaterialOne")
			    || uri.equals("/lectureMaterialWeekList") || uri.equals("/qna") ||uri.equals("/qnaOne") || uri.equals("/addQna")
		        || uri.equals("/updateQna") || uri.equals("/deleteQna") || uri.equals("/myQna") || uri.equals("/quizList") || uri.equals("/quizOne") || uri.equals("/addAnswer")) 
			{
				return true;
			}
			
			response.sendRedirect("/login");
			return false;
		}
		
		
		return true; // 로그인된 사용자면 통과
	}

	
}
