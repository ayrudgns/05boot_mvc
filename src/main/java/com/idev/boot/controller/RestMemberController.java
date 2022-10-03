package com.idev.boot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.idev.boot.dao.SnsMemberDao;
import com.idev.boot.dao.EmailSend;
import com.idev.boot.dao.MemberMapper;
import com.idev.boot.dto.Member;
import com.idev.boot.dto.SnsMember;

@RestController		// 비동기 통신 요청을 처리할 컨트롤러
@RequestMapping("member/")	// "value=" 생략 가능
public class RestMemberController {
	
	// 의존관계 자동 주입
	private MemberMapper dao;
	public RestMemberController(MemberMapper dao) {
		this.dao = dao;
	}
	
	// 암호화에 필요
	SnsMemberDao enc = new SnsMemberDao();
	
	// 1001 작성, 인증번호 전송
	@RequestMapping(value = "auth", method = RequestMethod.POST)
	public String sendAuth(String id) throws JsonProcessingException {
		EmailSend es = new EmailSend();
		es.sendEmail(id);
		int num = es.getValid_num();
		ObjectMapper jmapper = new ObjectMapper();
		Map<String, Object> map = new HashMap<>();		
		map.put("result", id);
		map.put("num", num);
		return jmapper.writeValueAsString(map);		
	}
	
	// 0926 작성, 회원가입
	@RequestMapping(value = "registerer", method = RequestMethod.POST)
	@ResponseBody
	public String register(@RequestBody String json) 
			throws JsonMappingException, JsonProcessingException {
		ObjectMapper jmapper = new ObjectMapper();
		jmapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		SnsMember s_mem = jmapper.readValue(json, SnsMember.class);
		
		s_mem = enc.encode(s_mem);
		int result = dao.register(s_mem);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		
		return jmapper.writeValueAsString(map);	
	}
	
	// 0928 작성, 닉네임 중복확인
	@RequestMapping(value = "registerer", method = RequestMethod.GET)
	public String nickCheck(String nickname) throws JsonProcessingException {
		int result = dao.nickCheck(nickname);
		ObjectMapper jmapper = new ObjectMapper();
		Map<String, Object> map = new HashMap<>();		
		map.put("result", result);
		return jmapper.writeValueAsString(map);				
	}
	
	// 0928 작성, id 중복확인
	@RequestMapping(value = "register", method = RequestMethod.GET)
	public String idCheck(String id) throws JsonProcessingException {
		int result = dao.idCheck(id);
		ObjectMapper jmapper = new ObjectMapper();
		Map<String, Object> map = new HashMap<>();		
		map.put("result", result);
		return jmapper.writeValueAsString(map);		
	}
		
	// 0922 작성, 모든 회원 가져오기
	@RequestMapping(value = "list", method = RequestMethod.GET)
	@ResponseBody
	public String list() throws JsonProcessingException {
		// 회원 리스트 조회
		List<Member> list = dao.selectAll();
		// 회원 수 조회
		int result = dao.getCount();
		
		Map<String, Object> map = new HashMap<>();
		map.put("members", list);
		map.put("result", result);
		
		// 응답 보낼 json 만들기, 이때는 역직렬화 필요 X
		ObjectMapper jmapper = new ObjectMapper();
		
		return jmapper.writeValueAsString(map);
	}
	
	// 0922 코드 작성 - 회원 하나만 가져오기!
//	@RequestMapping(value = "getOne", method = RequestMethod.GET)
//	public String getOne(int mno) throws JsonProcessingException {
	@RequestMapping(value = "ajaxex/{mno}", method = RequestMethod.GET)
	@ResponseBody
	public String getOne(@PathVariable int mno) throws JsonProcessingException {
						// @PathVariable : URI 경로로 파라미터가 전달되는 변수를 지정한다. (경로에서 받는 값)
						// URI ajaxex/{mno}에서 {mno}는 파라미터
		Member member = dao.selectByMno(mno);
		
		Map<String, Object> map = new HashMap<>();
		map.put("member", member);
		
		ObjectMapper jmapper = new ObjectMapper();
		
		return jmapper.writeValueAsString(map);
	}
	
	
	// 회원가입
	@RequestMapping(value = "ajaxex", method = RequestMethod.POST)
	@ResponseBody		// return은 요청에 대한 응답으로 json 형식 문자열 데이터
							// 메소드 인자는 요청으로 보내는 데이터 json 형식 문자열을 받는다.
	public String post(@RequestBody String json) throws JsonMappingException, JsonProcessingException {
							// xhr.send(JSON.stringify(jsob))로 보낸 데이터를 받는다.
		// 준비과정 : JSON 형식은 Map과 형식이 유사하다. (key와 value)
		
		// 1. JSON 문자열을 자바 객체로 변환시키기 (jackson-databind 라이브러리 사용)
		ObjectMapper jmapper = new ObjectMapper();

		jmapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);		// ** 역직렬화(문자열을 객체로 변환) 설정	
		Member vo = jmapper.readValue(json, Member.class);		// ** json 문자열을 Member 객체로 변환.
		
		// vo = enc.encode(vo);
		
		// 2. 테이블 insert
		int result = dao.addMember(vo);
		
		// 3. 응답으로 요청에 대한 처리 결과 보내주기
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);		// map에 응답으로 보낼 데이터를 저장한다.
		
		return jmapper.writeValueAsString(map);		// ** 응답을 문자열로 보내기 위해 json 문자열로 변환.
	}
	
//	@RequestMapping(value = "ajaxex", method = RequestMethod.DELETE)
//	public String delete(int mno) throws JsonProcessingException {	
	@RequestMapping(value = "ajaxex/{mno}", method = RequestMethod.DELETE)
	public String delete(@PathVariable int mno) throws JsonProcessingException {
		int result = dao.delete(mno);			// 메소드 실행, result는 삭제한 행의 개수
		ObjectMapper jmapper = new ObjectMapper();		// JSON 문자열을 자바객체로 변환시키기
		Map<String, Object> map = new HashMap<>();		
		map.put("result", result);				// 처리 결과 보낼 데이터 저장
		map.put("message", "메시지");
		return jmapper.writeValueAsString(map);		// 응답을 json 문자열로 변환 후 보내기
	}
	
	@RequestMapping(value = "ajaxex", method = RequestMethod.GET)
	public String checkEmail(String email) throws JsonProcessingException {
		int result = dao.checkEmail(email);
		ObjectMapper jmapper = new ObjectMapper();
		Map<String, Object> map = new HashMap<>();		
		map.put("result", result);				// 처리 결과 보낼 데이터 저장
		return jmapper.writeValueAsString(map);		// 응답을 json 문자열로 변환 후 보내기
	}

	
	// 비밀번호 변경
	@RequestMapping(value = "changepw", method = RequestMethod.PUT)
	@ResponseBody
	public String changepw(@RequestBody String json) throws JsonMappingException, JsonProcessingException {
		ObjectMapper jmapper = new ObjectMapper();
		jmapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		// json 문자열 3개(이메일, 기존 비밀번호, 새로운 비밀번호) => map으로 매핑하기 (email, oldpass, newpass)
		@SuppressWarnings("unchecked")
		Map<String, String> param = jmapper.readValue(json, Map.class);
		
		int result = dao.changePassw(param);		// 비밀번호 변경되면 1, 기존 비밀번호 불일치 0
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);		
		
		return jmapper.writeValueAsString(map);
	}
	
	
}
