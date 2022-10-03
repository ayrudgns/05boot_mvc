package com.idev.boot.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.idev.boot.dao.ScheduleMapper;
import com.idev.boot.dto.Member;
import com.idev.boot.dto.Schedule;

@Controller
@RequestMapping("schedule/")
@SessionAttributes("member")
public class ScheduleController {
	private static final Logger logger = LoggerFactory.getLogger(ScheduleController.class);

	private ScheduleMapper mapper;		// dao 역할. 의존관계 주입 
	
	public ScheduleController(ScheduleMapper mapper) {
		this.mapper = mapper;
	}

	@GetMapping("/new.do")
	public String newdo(Model model,
			@SessionAttribute(required = false) Member member) {	// 현재 로그인한 사용자의 스케쥴 리스트 가져와서 출력
	// 로그인 상태가 아닐때 : 400 오류 (Missing session attribute 'member' of type Member)
	// -> @SessionAttribute에 대해 필수적인 값 false로 설정
		if(member != null) 
			model.addAttribute("list", mapper.getSchedules(member.getMno()));
		return "schedule/schedule";
	}

	@PostMapping("/save.do")
	public String save(Schedule sch, Model model, RedirectAttributes rdattr) {
		logger.info("[My] sch : " + sch);
		sch.setSdate(sch.getSdate() + " " + sch.getStime());

		if(mapper.insert(sch) == 1) {
			rdattr.addFlashAttribute("alertM", "스케쥴이 등록되었습니다.");
		}
		return "redirect:new.do";
	}
	
	@GetMapping("/delete.do")			
	// save.do와 같이 alert가 뜨게 하기 위해서는 PostMapping이 필요하다.
	// -> 삭제도 form태그 사용하는 방법으로 변경
	public void delete(int idx,
			@SessionAttribute(required = false) Member member,
			HttpServletResponse response) throws IOException {
		String message; 
		// 로그인 상태가 아닐 때 member는 null
		if(member != null && mapper.checkMno(idx) == member.getMno()) {  // mno 비교하기
			mapper.delete(idx);
			message = "삭제 완료";
		}else {
			message = "삭제 오류입니다.";
		}
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String url = "./new.do"; 
		out.print("<script>alert('" + message + "'); location.href = '" + url + "'");
		out.print("</script>");
	}
	
}
