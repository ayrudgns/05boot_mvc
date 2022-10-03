package com.idev.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SnsMember {
	
	private String id;
	private String pw;
	private String name;
	private int age;
	private String nickname;
	private String birth;
	private String addr;
	private String gender;
	private String profile_file;
	private int cash;
}
