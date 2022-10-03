<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberV3</title>
<style type="text/css">
div{
	width:200px;height: 200px;
	border: 1px solid gray;
	padding:50px;
	margin: 100px auto;
}
</style>
</head>
<body>
	<script type="text/javascript">
		var alertM = '<c:out value="${ alertM }" />';
		if (alertM != "") {
			alert(alertM);
		}
	</script>

<div>
<!-- 객체가 null 인지 비교 : 같다(==)는 eq, 같지 않다(!=) ne -->
<!-- member 애트리뷰트는 로그인 성공하면 session에 저장 -->
	<p>접속 시간 : ${ serverTime }</p>
<c:choose>    
	<c:when test="${member == null}">  
	<!-- 로그인 안했을 때 메뉴 -->
		<a href="login.do">로그인</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="${pageContext.request.contextPath}/member/join.do">회원가입</a><br>
		<a href="./member/list.do">회원목록</a>
	</c:when>
	<c:otherwise>  
	<!-- 로그인했을 때 메뉴 -->
		<h5 style="color:orange;">${member.email}&nbsp;님 환영합니다.</h5>
		<a href="./member/update.do">내 정보 수정</a>
		<a href="./schedule/new.do">스케쥴</a>
		<a href="logout.do">로그아웃</a>		<!-- JSESSION ID가 살아있고 로그아웃 -->
		<a href="logout">로그아웃2</a>		<!-- JSESSION ID가 재생성되고 로그아웃 X -->
	</c:otherwise>
</c:choose>
<p><a href="ajax">비동기 통신 AJAX 테스트</a></p>
<p><a href="register">sns회원가입</a></p>
</div>

<div style="margin:auto;">
<img src="./resources/image/jam1.jpg" width="200px" height="200px">
</div>

</body>
</html>








