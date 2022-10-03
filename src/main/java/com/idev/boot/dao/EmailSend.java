package com.idev.boot.dao;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import lombok.Data;

@Data
public class EmailSend {
	
		private int valid_num;
		
	public int sendEmail(String id) {
		String host = "smtp.naver.com";
		String guest = "l859581@naver.com"; // 발신자 메일
		String password = "risiei12";        // 발신자 패스워드
		Properties props = new Properties();

		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
	    props.put("mail.smtp.starttls.enable", "true"); 
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", "smtp.naver.com");
		props.put("mail.smtp.socketFactory.fallback", "true");

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(guest, password);
				}
			}
		);

		// 인증번호 난수 6자리 설정
		valid_num = (int)(Math.random() * (99999 - 10000 + 1)) + 10000;
		
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(guest));

			// 메일 대상
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(id));

			// 메일 제목
			message.setSubject("Sell-up 회원가입 인증번호");

			// 메일 내용
			message.setText("이메일 인증번호 : " + valid_num + "\n인증번호를 입력하여 인증을 완료해주세요.");

			// send the message
			Transport.send(message);
			System.out.println("Success Message Send");

		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return valid_num;
	}
	
}
