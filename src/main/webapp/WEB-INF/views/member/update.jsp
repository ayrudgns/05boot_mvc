<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberV3 회원정보 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mytable.css">
</head>
<body>    <!-- 웹문서가 생성될때 자바스크립트 함수 set_hobby() 실행한다.  -->
<jsp:include page="../common/sessionCheck.jsp" />
<script type="text/javascript">
	var alertM = '<c:out value="${ alertM }" />';
	if (alertM != "") {
		alert(alertM);
	}
</script>
	<p>접속 시간 : ${ serverTime }</p>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>		<!-- 변수에 저장 -->
<!-- pageContext : 현재 .jsp 페이지 범위를 나타내는 내장 객체
     pageContext.request : 현재 페이지의 요청 객체 
     contextPath : request.getContextPath() 메소드. 즉, contextPath 프로퍼티 값 -->
<%-- <jsp:include page="${contextPath}/sessionCheck.jsp"/>  --%>  
<!-- 동적 : 실행후에 빌드된 .class로 제어 이동해서 실행. 여기서는 2개의 jsp의 pageContext 객체가 달라서 오류 발생. -->
<div style="width: 70%; margin: auto;">
		<h3>내 정보 수정</h3>
		<!-- onsubmit 은 입력값 유효성 검증을 위한 것이며, submit 전에 실행된다. -->
		<form name="frmUser"  
			method="post" action="save.do">
		<input type="hidden" value="${member.hobby}" name="temp">  
		<!-- hobby 값 체크 설정하기 위해 임시로 사용한다. -->	
		<input type="hidden" value="${member.mno}" name="mno">
		<input type="hidden" value="${member.name}" name="name">
			<table style="width: 100%">
				<tr>
					<th>이름</th>   <!-- session 애트리뷰트 "member" 에 객체 저장값을 불러오기 -->
					<td><input type="text" name="name" value="${member.name}"
							disabled="disabled"></td>  <!-- disabled는 파라미터값 null -->
				</tr>
				<tr>
					<th>패스워드</th>
					<td>
					<!-- <input type="password" name="pwd" disabled="disabled"> -->
					<a href="javascript:passw()">패스워드 변경</a>&nbsp;&nbsp;
					<a href="javascript:deleteOk('${member.mno}', '${member.name}')">회원탈퇴</a>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email" value="${member.email}"></td>
				</tr>
				<tr>
					<th>나이</th>
					<td><input type="number" name="age" min="10" max="99"
						value="${member.age}"></td>
				</tr>
				<tr>
					<th>거주지</th>
					<td><select name="addr">
							<!-- value 속성은 서버에 전달시킬 값 -->
							<option value="서울" 
									<c:if test="${member.addr == '서울'}">
									selected
									</c:if>>서울</option>
							<option value="인천" 
									<c:if test="${member.addr=='인천'}">
									selected
									</c:if>>인천</option>
							<option value="대전"
								<c:if test="${member.addr=='대전'}">
									selected
								</c:if>>대전</option>
							<option value="광주"
								<c:if test="${member.addr=='광주'}">
									selected
								</c:if>>광주</option>
							<option value="부산"
								<c:if test="${member.addr=='부산'}">
									selected
								</c:if>>부산</option>
					</select></td>
				</tr>
				<tr>
					<th>성별</th>  									<!-- 주의 : LoginServlet 에서 실행 시작!! -->
					<td>
					<input type="radio" value="male" name="gender" 
							<c:if test="${member.gender=='male'}">
							checked='checked'
							</c:if>
							id="male">
						<label for="male">남자</label> 
						<!-- 
							label 태그의 for는 어떤 input과 연결인지 표시
						    태그의 구별은 id속성 값으로 한다. 
						-->
						<input type="radio" value="female" name="gender" 
							<c:if test="${member.gender=='female'}">
							checked='checked'
							</c:if> 
							id="female">
						<label for="female">여자</label>
					</td>
				</tr>
				<tr>
					<th>취미</th> <!-- *** name 속성은 값을 위한 변수명, id 속성은 태그 구별을 위한 변수명 -->
					<td>
						<!-- 복수 선택이 가능 --> 
						<input type="checkbox" name="hobby" value="축구" id="hobby1">
						<label for="hobby1">축구</label>
						<input type="checkbox" name="hobby" value="농구" id="hobby2">
						<label for="hobby2">농구</label> 
						<input type="checkbox" name="hobby" value="스키" id="hobby3">
						<label for="hobby3">스키</label>
						<input type="checkbox" name="hobby" value="달리기" id="hobby4">
						<label for="hobby4">달리기</label>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center">
						<input type="submit" value="수정하기"> 
						<input type="reset" value="다시쓰기">
						<input type="button" value="홈" onclick="location.href='../';">
						<!-- onclick 에 실행될 자바스크립트 명령문 작성. -->
					</td>
				</tr>

			</table>
		</form>
	</div>
	<script type="text/javascript">
	function validForm(){
		// 유효성 검사 추가 필요!
		var frm = document.frmUser;
		var i;
		
		if(frm.age.value < 20 || frm.age.value > 70) {
			alert("나이는 20세 이상 70세 미만으로만 가능합니다.");
			frm.age.focus();
			return false;
		}
		
	}
	
	// 패스워드 변경 창 열기
	function passw() {
		var url = "passw.do";
		window.open(url, "패스워드 변경", "width = 600, height = 150, left = 900, top = 400");
	}
	
	function set_hobby(){  /* 64, 70번 라인 코딩 확인하기 */
		var t= document.frmUser.temp.value;   // 취미 문자열 : 예시 [축구, 달리기]
		var obj = document.frmUser.hobby;		
		if(t.includes('축구') == true) obj[0].checked='checked';   // 문자열 메소드 => 문자열1.includes(문자열2) : 문자열1에 문자열2가 포함되어 있는가?
		if(t.includes('농구') == true) obj[1].checked='checked';
		if(t.includes('스키') == true) obj[2].checked='checked';
		if(t.includes('달리기') == true) obj[3].checked='checked';
	}
	
	function deleteOk(mno,name){   // 회원 탈퇴 확인을 위한 자바스크립트 함수 : 84번 라인 코딩.
		// form 태그 없이 파라미터를 전달하고 요청을 처리하는 방법 
		var yn = confirm('등록된 회원에서 탈퇴하시겠습니까?');
		if(yn) {  // 확인 선택하면 true
			alert('회원 [' + name + "]님 탈퇴합니다.");
			location.href = './delete?mno=' + mno;   // delete url 요청시 mno를 파라미터로 전달한다.
		} else {
				alert('회원 탈퇴 취소 합니다.');
		}
	}
	set_hobby();
</script>
</body>
</html>


















