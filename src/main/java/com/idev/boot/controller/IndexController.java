package com.idev.boot.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.idev.boot.dao.MemberMapper;
import com.idev.boot.dto.Member;

@Controller
@SessionAttributes({"member", "serverTime"})
// * 애트리뷰트 데이터가 저장되는 Model 저장소에서 
// member와 serverTime은 세션 scope으로 사용되는 값(세션 객체에 저장)이다. *

public class IndexController {
	
	private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	private MemberMapper mapper;
	
	// MemberMapper bean 자동 주입
	public IndexController(MemberMapper mapper) {
		this.mapper = mapper;
	}

	// sns 회원가입으로 이동
	@RequestMapping(value = "register")
	public String register() {
		return "member/1snsJoinForm";
	}
	
	// ajaxTest.jsp로 이동하는 메소드
	@RequestMapping(value = "ajax")
	public String ajax() {
		return "member/ajaxTest";
	}
	
	// home.jsp에서 실행할 핸들러 메소드
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate);
		
		return "home";
	}

	@GetMapping("login.do")		// 확장자를 붙이지 않으면, 메소드의 반환 타입을 void로 하고 return이 없어도 되므로 코드가 짧아질 수 있다.
//	public String login(@ModelAttribute("success") String success) {  // view로 바로 전달
	public String login(Model model) {
		return "login";		// 로그인 화면으로 이동하는데 Model 객체 가져가
	}
	
	@PostMapping("login.do")   
	public String loginProc(@RequestParam Map<String, String> map, RedirectAttributes rdattr, Model model) {
		logger.info("[My] " + map);
		Member member = mapper.login(map);  // 로그인 성공하면 null 아닌 값 반환
		String url;
		if(member != null) {
			// 성공 : 메인 화면으로 이동, session 객체에 로그인 정보를 저장함 (세션 애트리뷰트로 저장) 
			model.addAttribute("member", member);    // @SessionAttributes로 설정하기 => session scope
			rdattr.addFlashAttribute("alertM", "로그인 성공하였습니다!");		// RedirectAttributes(파라미터로 사용됨)
			url = "/";    // 로그인 성공 메시지 alert 띄우기
		} else { 
			// 실패 : 다시 로그인 하러가기. ((미션)) alert 메시지 띄우기 : "로그인 정보가 올바르지 않습니다!"
			rdattr.addFlashAttribute("alertM", "로그인 실패하였습니다! 정보 확인하세요!");
			url = "login.do";
		}
		return "redirect:" + url;
	}
	
	@GetMapping("logout.do")
	public String logout(SessionStatus status) {  // 현재 세션상태 객체
		status.setComplete();  // @SessionAttributes로 설정된 애트리뷰트 값을 clear한다.
		return "redirect:/";
	}
	
	@GetMapping("logout")
	public String logout2(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();  
		//서버가 JSESSIONID는 새로 부여해주지만 @SesstionAttributes로 설정된 값은 남아있다.
		return "redirect:/";
	}
	
	// @SessionAttributes로 설정된 것은 SessionStatus로 지운다.	
	// status.setComplete();   
	//	- JSESSIONID는 변하지 않고 @SessionAttributes로 설정된 애트리뷰트 값을 clear한다.
	//	- HttpSession의 removeAttribute() 메소드 동작과 유사하다.
		
	// jsp에서 로그아웃 : session.invalidate();   // JSESSIONID값을 새로운 값으로 한다.
	//			 	    session.removeAttribute("member");   // - JSESSIONID는 변하지 않고 값만 삭제된다.	
			
	
	
}
