package com.example.academylms.controlleradvice;

/*
 * import org.springframework.web.bind.annotation.ControllerAdvice; import
 * org.springframework.web.bind.annotation.ModelAttribute; import
 * com.example.academylms.dto.User; import
 * com.example.academylms.service.LoginService; import
 * jakarta.servlet.http.HttpSession;
 * 
 * @ControllerAdvice public class GlobalLoginUserAdvice {
 * 
 * private final LoginService loginService;
 * 
 * public GlobalLoginUserAdvice(LoginService loginService) { this.loginService =
 * loginService; }
 * 
 * @ModelAttribute("loginUser") public User loginUser(HttpSession session) {
 * Integer userId = (Integer) session.getAttribute("loginUserId"); if (userId ==
 * null ) return null;
 * 
 * // 세션에 저장된 userId로 DB 사용자 정보조회 return loginService.findById(userId); }
 * 
 * }
 */
