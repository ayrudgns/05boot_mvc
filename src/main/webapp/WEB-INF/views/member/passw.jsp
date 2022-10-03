<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>패스워드 변경</title>

</head>
<body>
<jsp:include page="../common/sessionCheck.jsp" />
<c:set var="contextPath" value="${ pageContext.request.contextPath }"/>
<form action="${contextPath}/member/passw.do" method="post" name="frmPass">
<input type="hidden" name="email" value="${member.email}">  <!-- session 애트리뷰트에 저장된 이메일 파라미터로 전달 -->
<div>
<input type="password" name="oldpass" placeholder="현재 비밀번호">		
<span id="oldpass"></span>  <!-- 유효성 검사 오류시 출력할 내용 표시 -->
</div>

<div>
<input type="password" name="newpass" placeholder="새로운 비밀번호">	<!-- oninput="check_newpass1()"는 자바스크립트로 처리 -->
<span id="newpass">새로운 비밀번호는 4글자 이상입니다.</span>  <!-- 유효성 검사 오류시 출력할 내용 표시 -->
</div>

<div>
<input type="password" name="newpass2" placeholder="새로운 비밀번호 확인">
<span id="newpass2">새로운 비밀번호 확인 입력입니다.</span>  <!-- 유효성 검사 오류시 출력할 내용 표시 -->
</div>
<div>
<input type="button" value="패스워드 변경" onclick="validPassw()"><input type="button" value="취소" onclick="history.back();">
</div>
</form>
<script type="text/javascript">
	let result = false;
	const newp1 = document.querySelector("input[name='newpass']")
	newp1.addEventListener("input", check_newpass1);		// 입력할 때 발생하는 이벤트 input
	
	const newp2 = document.querySelector("input[name='newpass2']")
	newp2.addEventListener("input", check_newpass2);
//	console.log(newp2)
	function check_newpass1(){
		if(newp1.value != "" && newp1.value.length < 4) {
			document.getElementById("newpass").innerHTML = "새로운 비밀번호는 4글자 이상입니다.";
			document.getElementById("newpass").style.color = "red";
			result = false;
		}else{
			document.getElementById("newpass").innerHTML = "OK!!";
			document.getElementById("newpass").style.color = "green";
			result = true;
		}
	}
	
	function check_newpass2(){
		var new1 = newp1.value;
		var new2 = newp2.value;
		if(new1 == new2) {
			document.getElementById("newpass2").innerHTML = "새로운 비밀번호 확인 일치합니다.";
			document.getElementById("newpass2").style.color = "green";
			result = true;
		}else {
			document.getElementById("newpass2").innerHTML = "새로운 비밀번호 확인 일치하지 않습니다.";
			document.getElementById("newpass2").style.color = "red";
			result = false;
		}
	}

	function validPassw() {
		var new1=document.frmPass.newpass.value;
		var new2=document.frmPass.newpass2.value;
		var old=document.frmPass.oldpass.value;
	
		
		if(old == "") {
			/* span 태그에 내용과 스타일 수정 */
			document.getElementById("oldpass").innerHTML = "현재 비밀번호 입력 필수입니다.";
			document.getElementById("oldpass").style.color = "red";
			document.frmPass.oldpass.focus();
			result = false;
		}else{
			result = true;
		}
		
		if(result == true){
			document.frmPass.submit();
			setTimeout("self.close()", 1);		// 첫번째 인자는 함수 이름 또는 자바스크립트 명령 ("" 안에 작성)
//			self.close();		// 현재 화면의 윈도우 닫기 (거의 동시에 처리하게 되어 submit이 씹혀버린다.)
		}
	}
	
</script>
</body>
</html>