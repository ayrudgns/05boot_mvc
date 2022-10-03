<%@page import="javax.websocket.SendResult"%>
<%@page import="com.idev.boot.dao.EmailSend"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sell-up 회원가입</title>
<!-- http://localhost:8085/idev/에 해당하는 부분은 contextPath 프로퍼티로 가져온다. -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/snsJoin_style.css">
</head>


<body>

<div style="width: 40%; margin: auto;">
	<div style="text-align: center;">
		<h3>Sell-up 회원가입</h3>
		<h5 style="color: deeppink">** 모든 입력사항은 필수 입력입니다. **</h5>
	</div>	
		<!-- *** name 속성은 값을 위한 변수명, id 속성은 태그 구별을 위한 변수명 -->
		<form name="frmUser" method="post" action="register">
			<table style="width: 100%">
				<tr>
					<th>회원 ID (이메일 형식)<br><small id="id_val"></small></th>
					<td>
						<div style="padding-top: 15px;">
							<input type="text" name="id" id="id" placeholder="예시 : xxx@yyy.zzz" 
								oninput="check_id()" style="width: 50%;">
							<input type="button" value="이메일 인증" id="emailValid" onclick='insert_open()' style="font-size: 0.8em;">
							<br><small id="valid_id" style="font-size: 0.7em; padding-top: -10px;"></small>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center; padding: 0px;">
					<!-- 이메일 인증 버튼을 누르면 인증번호 입력챵 나오게 -->
						<input type="text" id="insertVal" style="width: 20%; display: none;">
						<input type="button" value="인증 확인" id="val_check" style="display: none; font-size: 0.8em;">
					</td>
				</tr>
				<tr>
					<th><input type="hidden" id="id2">비밀번호<br><small id="pw_val"></small></th>
					<td><input type="password" name="pw" id="pw" style="width: 40%;" oninput="pwCheck()">
						<small style="padding-left: 10px;" id="pw_checker"></small>
						<br><small style="font-size: 0.7em; color: black; letter-spacing: -1px;">
							비밀번호는 영문자 1개 이상, 숫자 1개 이상, 특수문자 1개 이상
						<br>반드시 포함되어야 하며, 8자 이상이어야 합니다.</small></td>
				</tr>
				<tr>
					<th>비밀번호 확인<br><small id="pw2_val"></small></th>
					<td><input type="password" name="pw2" id="pw2" style="width: 40%;">
						<input type="button" value="확인" id="pw_ok" onclick="pwOK()"></td>
				</tr>
				<tr>
					<th>이름<br><small id="name_val"></small></th>
					<td><input type="text" name="name" id="name" style="width: 40%;">
					</td>
				</tr>
				<tr>
					<th>닉네임<br><small id="nic_val"></small></th>
					<td><input type="text" name="nickname" id="nickname" style="width: 40%;">
					<input type="button" value="중복체크" id="check_nick" onclick="nickCheck()">
					</td>
				</tr>
				<tr>
					<th>나이<br><small id="age_val"></small></th>
					<td><input type="number" name="age" id="age" min="14" max="99"
						 style="width: 10%; text-align: right;"> 세</td>
				</tr>
				<tr>
					<th>생년월일<br><small id="birth_val"></small></th>
					<td><input type="date" name="birth" id="birth"></td>
				</tr>
				<tr>
					<th>성별<br><small id="gen_val"></small></th> 
					<td>
					<span id="optgender">
					    <input type="hidden" id="gender">
						<input type="radio" value="male" name="gender" id="male"><label for="male">남자</label> 
						<input type="radio" value="female" name="gender" id="female"><label for="female">여자</label>
						<input type="radio" value="unknown" name="gender" id="unknown"><label for="unknown">선택안함</label>
					</span>
					</td>
				</tr>
				<tr>
					<th>주소<br><small id="addr_val"></small></th> 
					<td>
						<input type="text" name="addr" id="addr" style="width: 50%;">
						<br><small style="font-size: 0.7em; color: black;">예시 : 경기도 수원시 / 서울시 강남구</small>
					</td>
				</tr>
				<tr>
					<th>프로필 사진 업로드<br><small id="up_val"></small></th> <!-- *** name 속성은 값을 위한 변수명, id 속성은 태그 구별을 위한 변수명 -->
					<td>
						<input type="file" name="profile_file" id="profile_file">
					</td>
				</tr>
				<tr style="border-bottom: 0px solid;">
					<th>sell-up 캐시</th>
					<td>
						<input type="number" name="cash" id="cash" value="0" style="width: 20%; text-align: right;" readonly> 캐시
						<div style="font-size: 0.8em; margin-top: 10px;">* 중고거래 결제 시 사용되며, 충전 페이지에서 충전이 필요합니다.</div>
					</td>
				</tr>
				<tr style="border-top: 0px solid;">
					<td colspan="2" style="text-align: center">
					<input type="button" value="가입하기" id="register" onclick='validForm()'>
					<input type="reset" value="다시쓰기"></td>
				</tr>

			</table>
		</form>
	</div>
<script src="${pageContext.request.contextPath}/resources/js/snsJoin_valid.js"></script>

<script type="text/javascript">	
	// 이메일 인증 인풋박스 열리면서 이메일 전송
	function insert_open() {
		document.getElementById('insertVal').style.display = 'inline-block';
		document.getElementById('val_check').style.display = 'inline-block';
	//	location.href = 'register?id=' + id;
	//	history.back();
		var id = document.querySelector('#id').value;
		if(id != "") {
			console.log(id);
			
			const xhr = new XMLHttpRequest();
			xhr.open('POST', 'member/auth?id=' + id);
			xhr.send();
			xhr.onload = function() {
				if(xhr.status == 200) {
					const data = JSON.parse(xhr.response);
					console.log(data.result);
					alert('인증번호 발송 완료!');	// 인증번호 발송 완료
					console.log(data.num);
					// 인증번호 일치 확인
					document.querySelector('#val_check').addEventListener('click', function() {
						const insertVal = document.getElementById('insertVal').value;
						if(insertVal == data.num) {
							alert('인증번호가 일치합니다. 인증 완료!');
							insertVal.readOnly = true;
						} else {
							alert('인증번호가 일치하지 않습니다.');
							isVal = false;
						}
					});
				} else {
					console.error('error', xhr.status, xhr.statusText);					
				}
			}
		}
	}
	
	// 인증번호 일치 확인
	function auth_Check() {
		isVal = true;
		var insertVal = document.getElementById('insertVal');
		
		if(insertVal.value == data.num) {
			alert('인증번호가 일치합니다. 인증 완료!');
			insertVal.readOnly = true;
		} else {
			alert('인증번호가 일치하지 않습니다.');
			isVal = false;
		}
		
	}
</script>
</body>
</html>


















