package com.idev.boot.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.idev.boot.dao.MemberMapper;
import com.idev.boot.dto.Member;

@Controller
@RequestMapping(value = "member/")		// sub path : context path의 하위 경로
@SessionAttributes({"member"})		// model.addAttribute로 member를 변경하면 동기화가 된다.
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	private MemberMapper dao;
	
	public MemberController(MemberMapper dao) {
		this.dao = dao;
	}
	
	@GetMapping("join.do")
	public String join() {		// 회원가입 페이지 열기
		return "member/form";
	}
	
	@PostMapping("join.do")
	public String join(Member member, RedirectAttributes rdattr) {		// 회원가입 하기
		
		logger.info("회원가입 입력 정보 : {}", member);		// printf와 비슷하게 중괄호 안에 객체의 값이 들어간다.
		
		// 테이블 insert 하기 >> 완료
		if(dao.addMember(member) == 1) {
			rdattr.addFlashAttribute("alertM", "회원가입이 완료되었습니다.");
		} else {
			rdattr.addFlashAttribute("alertM", "회원가입 정보에 문제가 있습니다.");
		}
		return "redirect:/";	// 홈으로 돌아가기
	}
	
	// 다른 jsp 파일들(list / idCheck / update) 동작하게 핸들러 메소드 만들어보기
	
	@GetMapping("list.do")
	public String list(Model model) {			// 회원목록 보러가기
		List<Member> list = dao.selectAll();	// 메소드 실행해서 담고
		model.addAttribute("list", list);		// 애트리뷰트로 전달할 준비
		return "member/list";
	}
	
	@GetMapping("update.do")				// 로그인이 반드시 필요한 url
	public String update() {				// 회원정보 수정하러 가기
			// 수정한 회원정보는 세션에서 가져다가 view로 전달한다.
		return "member/update";
	}

	@PostMapping("save.do")
	public String save(Member member, Model model, RedirectAttributes rdattr) {		// 회원정보 수정
		if(dao.updateMember(member) == 1) {		// 일단 정보수정, 이때 member는 사용자가 수정한 값을 저장한다.
	//		member = dao.selectByMno(member.getMno());	// 회원번호 골라서 
			rdattr.addFlashAttribute("alertM", "회원정보 수정이 완료되었습니다.");
		}
		model.addAttribute("member", member);		// 애트리뷰트로 전달
		return "redirect:update.do"; 
	}

	@GetMapping("idCheck.do")
	public String idCheck(String email, Model model) {		// ajax 변경해보기
		logger.info("중복 확인 이메일 : {}", email);
		
		String msg;
		if(dao.checkEmail(email) == 0) {	// 0이면 중복 아님!
			msg = "사용할 수 있는 이메일입니다.";
		} else {
			msg = "중복된 이메일입니다. 다른 이메일을 사용하세요.";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("email", email);
		
		return "member/idCheck";
	}
	
	@GetMapping("passw.do")
	public String passw() {			// 비밀번호 변경하러 가기
		return "member/passw";
	}

	@PostMapping("passw.do")		// 현재 비밀번호 검사와 새로운 변경 ajax로 해볼 예정
	public String passw(@RequestParam Map<String, String> map) {
		logger.info("비밀번호 변경 파라미터 : {}", map);		// 값을 확인하기!!
		
		// 패스워드 변경 여부는 logger.info로 출력해보기
		String msg;
		if(dao.changePassw(map) == 1) {
			msg = "비밀번호 변경 완료";
		} else {
			msg = "비밀번호 변경 실패 : 현재 비밀번호 불일치";
		}
		logger.info(msg);
		
		return "redirect:update.do";
	}
	
	
	
	
}
