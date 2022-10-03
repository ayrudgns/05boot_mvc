package com.idev.boot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.idev.boot.dto.Member;
import com.idev.boot.dto.SnsMember;

@Mapper		//  매퍼 인터페이스 : mapper xml 파일의 sql 실행을 위한 구현체를 만들 인터페이스
public interface MemberMapper {
	int getCount();
	List<Member> selectAll();
	Member selectByMno(int mno);
	Member login(Map<String, String> map);
	int changePassw(Map<String, String> map);
	int checkEmail(String email);
	int addMember(Member member);
	int updateMember(Member member);
	int delete(int mno);
	
	int register(SnsMember smember);		// 회원가입
	int idCheck(String id);			// 아이디 중복확인
	int nickCheck(String nickname);		// 닉네임 중복확인
	
}
