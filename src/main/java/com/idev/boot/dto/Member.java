package com.idev.boot.dto;

public class Member {
	
		private int mno;
		private String name;
		private String password;
		private String email;      // 위에 4개는 not null
		private String gender;
		private int age;
		private String hobby;
		private String addr;
		
		// *** 기본생성자가 없으면 Model 객체로 자동 매핑할 때 오류 발생 (400 오류) ***
		public Member() {

		}

		public Member(int mno, String name, String password, String email, String gender, int age, String hobby,
				String addr) {
			this.mno = mno;
			this.name = name;
			this.password = password;
			this.email = email;
			this.gender = gender;
			this.age = age;
			this.hobby = hobby;
			this.addr = addr;
		}

		public int getMno() {
			return mno;
		}

		public void setMno(int mno) {
			this.mno = mno;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getGender() {
			return gender;
		}

		public void setGender(String gender) {
			this.gender = gender;
		}

		public int getAge() {
			return age;
		}

		public void setAge(int age) {
			this.age = age;
		}

		public String getHobby() {
			return hobby;
		}

		public void setHobby(String hobby) {
			this.hobby = hobby;
		}

		public String getAddr() {
			return addr;
		}

		public void setAddr(String addr) {
			this.addr = addr;
		}
		
		@Override
		public String toString() {
			return "Member [mno = " + mno + ", name = " + name + ", password = " + password + ", email = " + email + ", gender = "
					+ gender + ", hobby = " + hobby + ", addr = " + addr + ", age = " + age + "]";
		}
		
		
		
}
