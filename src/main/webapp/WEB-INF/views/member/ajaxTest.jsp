<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX 테스트</title>
<style>
	td, th{
	    border-top: 1px solid gray;
	    border-bottom: 1px solid gray;
	    padding: 5px 10px;
	}
	
	th {
	    background-color: teal;
	    color: white;
	    text-align: left;
	}
	
/*	tr:hover{
	    background-color: darkseagreen;
	    color: white;
	    cursor: pointer;
	} */
	
	tr > td:nth-child(1){
	    width : 10%;
	}
	tr > td:nth-child(2){
	    width : 15%;
	}
	tr > td:nth-child(3){
	    width : 10%;
	}
	tr > td:nth-child(4){
	    width : 25%;
	}
	tr > td:nth-child(5){
	    width : 10%;
	}
	tr > td:nth-child(6){
	    width : 10%;
	}
	tr > td:nth-child(7){
	    width : 25%;
	}
</style>
<link rel="stylesheet" href="resources/css/modal.css">
<!-- 코딩할 때는 계속 modal 상자가 보이는 상태로 코딩하는 것이 작업하기 편하다. -->
</head>

<body>
	<!-- 통신 동작을 메소드로 구분한다. -->
	<!-- get은 조회, post는 저장, put과 patch는 수정, delete는 삭제 -->
	<h3>AJAX - 비동기 통신 메소드 테스트</h3>
		<button id="getAll">GET</button>
		<button id="getOne">GET ONE</button>
		<button id="post">POST</button>
		<button id="put">PUT</button>
		<button id="patch">PATCH</button>
		<button id="delete">DELETE</button>
	<br>
	
	<!-- Member 클래스와 매핑되는 요소들 -->
	<input type="text" id="mno" placeholder="mno를 입력하세요.">	
    <input type="text" id="name" placeholder="name를 입력하세요.">
    <input type="password" id="password" placeholder="password를 입력하세요."><br>
    <input type="text" id="age" placeholder="age를 입력하세요.">
    <input type="text" id="email" placeholder="email를 입력하세요." oninput="checkEmail()"><br>
    <small id="validEmail"></small>
    <button onclick="checkEmail()">중복체크</button><br>
    <!-- 이메일 입력 후 버튼을 클릭했을 때 중복체크 해보기 -->
    
    <small>지역을 입력하세요. : </small> 
    <select name="addr" id="addr">
          <!-- value 값이 서버로 전달된다. -->
          <option value="서울">서울</option>
          <option value="인천">인천</option>
          <option value="대전">대전</option>
          <option value="광주">광주</option>
          <option value="부산">부산</option>
          <option value="기타">기타</option>
    </select>
    
	<span id="optgender">
       <input type="hidden" id="gender">
       <input type="radio"  name="gender" value="male" id="lblmale"> <label for="lblmale" class="mpt">남성</label>
       <input type="radio" name="gender" value="female" id="lblfemale"><label for="lblfemale" class="mpt">여성</label>
       <input type="radio" name="gender" value="unknown" id="lblno"> <label for="lblno" class="mpt">비공개</label>
    </span>
    
	<div id='chkhobby'>
	    <input type="text" id="hobby" placeholder="취미를 입력하세요.(,로 구분)">
        <input type="checkbox" class="hobby" value="축구" id="football"><label for="football">축구</label>
        <input type="checkbox" class="hobby" value="달리기" id="running"><label for="running">달리기</label>
        <input type="checkbox" class="hobby" value="농구" id="basketball"><label for="basketball">농구</label>
        <input type="checkbox" class="hobby" value="스키" id="ski"><label for="ski">스키</label>
        <input type="checkbox" class="hobby" value="수영" id="swim"><label for="swim">수영</label>
    </div>
    <button onclick="document.getElementById('myModal').style.display='block'">패스워드 변경</button>
    <hr>
    <table id="list" style="width: 80%; border-collapse: collapse;">
    	<tr>
    		<th>번호</th>
    		<th>이름</th>
    		<th>나이</th>
    		<th>이메일</th>
    		<th>성별</th>
    		<th>지역</th>
    		<th>취미</th>
    	</tr>
    	<tr>
			<td colspan="7" id="test">테스트용</td>    	
    	</tr>
    	<tbody>
    	</tbody>
    </table>
    

<%@ include file="../common/modal.jsp" %>
<script type="text/javascript">

	// 비밀번호 변경 js 작성하기
	function changePassw() {
	//	const oldpass = document.querySelector('#oldp').value;		// id값 임의로 주고 값 가져오기
		const oldpass = document.querySelector("input[name='oldpass']").value;	// 통째로 가져오기
		const email = document.querySelector('#email').value;	// 이메일 값
	//	const newpass = document.querySelector('#newp').value;
		const newpass = document.querySelector("input[name='newpass']").value;
		console.log(oldpass);		// 콘솔로그 찍어보기
		console.log(newpass);
		
		if(email == "") {		// 패스워드 변경할 이메일
			alert('이메일을 입력하세요.');
			return ;
		}
		
		// 패스워드 유효성 검사 : validPassw() 함수 결과가 false이면 아래 통신 안함.
		if(validPassw() == false) {		// validPassword_t.js 파일에 있는 함수!
			alert('패스워드 검증 실패!');
			return ;
		} 
		
		const xhr = new XMLHttpRequest();
		xhr.open('PUT', 'member/changepw');		// 메소드, url
		xhr.setRequestHeader('content-type', 'application/json;charset=UTF-8');		// 보낼 데이터 형식; 인코딩
		
		var jsob = {"oldpass":oldpass, "email":email, "newpass":newpass};
		xhr.send(JSON.stringify(jsob));			// 통신 요청, 데이터 전송
		xhr.onload = function() {
			if(xhr.status == 200) {		// 제대로 전달이 됐으면
				console.log(xhr.response);
				const data = JSON.parse(xhr.response);		// 파싱 해주고
				if(data.result == 1) {		// 변경 됐으면
					document.getElementById('myModal').style.display='none';
					setTimeout("alert('비밀번호 변경 완료!');", 200);
				} else {		// 안됐으면
					document.getElementById("oldpass").innerHTML="현재 비밀번호 불일치";
					document.getElementById("oldpass").style.color='red';					
				}
			} else {	// 제대로 전달이 안됐으면
				console.error('error', xhr.status, xhr.statusText);						
			}
		}		
	}

	// 성별 선택하면 value 가져오기
	document.querySelector('#optgender').addEventListener('click', function () {
		let gender;
		document.querySelectorAll('input[name="gender"]').forEach(item => {		// item은 인자!
	        if (item.checked) {		// checked 속성이 true이면 value를 가져와라. (value는 male, female, unknown)
	        	gender = item.value;
	        }
	    });
	    document.querySelector('#gender').value = gender;
	});
	
	// 체크박스 클릭하면 체크된 문자열 연결
	document.querySelector('#chkhobby').addEventListener('click', function () {
	    let hobbies = "";
	    document.querySelectorAll('.hobby').forEach(item => {		// class나 id는 여러개일 수 있으므로 All
	        if (item.checked) {										// item은 보통 한개이므로 not All
	        	hobbies = hobbies.concat(item.value, ",");
	        }
	    });
	    document.querySelector('#hobby').value = hobbies.substr(0, hobbies.length - 1);
	});
	
	// 회원 하나만 가져오기
	document.querySelector('#getOne').addEventListener('click', function() {
		const mno = document.querySelector('#mno').value;
		if(mno == '') {
			alert('mno 값을 입력하세요.');
			return ;
		}
		
		const xhr = new XMLHttpRequest();
//		xhr.open('GET', 'member/getOne?mno=' + mno);
		xhr.open('GET', 'member/ajaxex/' + mno);		// 파라미터를 URI의 경로 형식으로 전달한다.
		xhr.send();
		xhr.onload = function() {
			if(xhr.status == 200) {
				const data = JSON.parse(xhr.response);		
				console.log(xhr.response);
				console.log(data);
				const ele = data.member;
				if (ele != null) {
					document.querySelector('#mno').value = ele.mno;
					document.querySelector('#name').value = ele.name;
					document.querySelector('#age').value = ele.age;
					document.querySelector('#email').value = ele.email;
					document.querySelector('#addr').value = ele.addr;
					document.querySelector('#hobby').value = ele.hobby;
					
					document.querySelectorAll('.hobby').forEach(item => {
                        // ele.hobby에 있는 텍스트가 체크박스 요소의 value 를 포함하고 있는지 각각 비교함.
              			if (ele.hobby.includes(item.value)) {
        		           item.checked = true;
              			} else {
		                   item.checked = false;    
              			}
              		});
					
					document.querySelectorAll('input[name="gender"]').forEach(item => {
              			// ele.gender에 있는 텍스트가 라디오 요소의 value 를 포함하고 있는지 각각 비교함.
	             		if (item.value == ele.gender) {
							item.checked = true;
	             	 	} else {
	                 		item.checked = false;    
	             	 	}
					});	
				} else {
					alert('존재하지 않는 회원번호입니다.');
					document.querySelector('#mno').value = "";
				}
			} else {
				console.error('error', xhr.status, xhr.statusTest);
			}
		}
	
	});
	
	// delete 실행
	document.querySelector('#delete').addEventListener('click', function() {
		const mno = document.querySelector('#mno').value;
		
		if(mno == "") {		// mno가 없으면
			alert('삭제할 mno를 입력하세요.');
			return ;	// 종료
		}
		
		const xhr = new XMLHttpRequest();
//		xhr.open('DELETE', 'member/ajaxex?mno=' + mno);		
		xhr.open('DELETE', 'member/ajaxex/' + mno);		
		xhr.send();		// 삭제 보내기
		xhr.onload = function() {
			if(xhr.status == 200) {		// 제대로 보내졌으면
				// xhr.response는 문자열이므로 object 변환 필요
				const data = JSON.parse(xhr.response);
				// console.log(xhr.response.result);		// undefined
				// console.log(xhr.response.message);		// undefined
				console.log(data.result);
				console.log(data.message);
				if(data.result == 1) {
					alert('삭제 완료');
				} else {
					alert('삭제할 데이터가 없습니다.');
				}
			} else {		// 제대로 보내지지 않았으면
				console.error('error', xhr.status, xhr.statusText);
			}
		}
	});
	
	// 모든 회원 가져오기
	document.querySelector('#getAll').addEventListener('click', function() {
		const xhr = new XMLHttpRequest();			// 순서를 잘 기억해야 한다!!
		xhr.open('GET', 'member/list');
		xhr.send();
		xhr.onload = function() {
			if(xhr.status == 200) {
				const data = JSON.parse(xhr.response);		// 응답 JSON 문자열 -> js object로 변환
				document.querySelector('#test').innerHTML = xhr.response;
				const list = data.members;
				document.querySelector('table > tbody:nth-child(2)').innerHTML="";		// 비우기
				list.forEach(function(ele) {    // 배열에서 하나 가져온 member
	                const $tr = document.createElement("tr");	// tr요소 생성
	                const $temp = // tr 태그 안의 td를 문자열로
	                	`<td>\${ele.mno}</td>			
	                    <td>\${ele.name}</td>
	                    <td>\${ele.age}</td>
	                    <td>\${ele.email}</td>
	                    <td>\${ele.gender}</td>
	                    <td>\${ele.addr}</td>
	                    <td>\${ele.hobby}</td>
	                	`;
					$tr.innerHTML = $temp;
		//			console.log($tr);
		//			console.log(document.querySelector('tbody'));
					document.querySelector('table > tbody:nth-child(2)').appendChild($tr);			// 생성된 tr요소를 마지막에 추가하기
				});
			} else {
				console.error('error', xhr.status, xhr.statusTest);
			}
		}
		
	});

	// 회원가입 실행
	document.querySelector('#post').addEventListener('click', function() {
		const name = document.querySelector('#name').value;
		const password = document.querySelector('#password').value;
		const age = document.querySelector('#age').value;
		const email = document.querySelector('#email').value;
		const addr = document.querySelector('#addr').value;
		const gender = document.querySelector('#gender').value;
		const hobby = document.querySelector('#hobby').value;
		
/* 		console.log(isEmail)	// 이메일 중복검사 실패하면 back
		if(isEmail == false) {
			alert('이메일 중복검사 실패!');
			return ;			// insert 불가능!
		} */
		
		const xhr = new XMLHttpRequest();
		xhr.open('POST', 'member/ajaxex');		// 메소드, url (POST 메소드는 데이터를 insert)
		xhr.setRequestHeader('content-type', 'application/json;charset=UTF-8');
												// 보낼 데이터 형식은 json, 인코딩은 UTF-8
		// 자바스크립트 객체, {속성이름:값}										
		var jsob = {"name":name, "age":age, "password":password, "email":email, "addr":addr, "gender":gender, "hobby":hobby};
		
		xhr.send(JSON.stringify(jsob));		// jsob를 JSON 문자열로 변환시켜서 보내기 (통신요청 and 데이터 전송)

		xhr.onload = function() {	// 201 : created
			if(xhr.status === 200) {
				console.log(xhr.response);		// 비동기 통신 응답 xhr.response
			} else {
				console.error('error', xhr.status, xhr.statusText);		
				// xhr.status => 에러코드 출력 : status, statusText, response는 xhr 객체의 프로퍼티이다.
			}
		}			
	});
	
	// 이메일 중복체크
	let isEmail = false;		// 회원 등록에서 unique 확인을 위한 변수
	function checkEmail() {
		var email = document.getElementById('email').value;
		// 정규식 검사
		const regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;

		if(email == "" || regEmail.test(email) === false) {	// email 유효성 검사
			document.querySelector('#validEmail').innerHTML = '이메일 형식이 아닙니다.';
			document.querySelector('#validEmail').style.color = 'red';
			document.querySelector('#validEmail').focus();
			return ;
		}
		
		// email 중복 검사
		const xhr = new XMLHttpRequest();
		xhr.open('GET', 'member/ajaxex?email=' + email);
		xhr.send();
		xhr.onload = function() {
			if(xhr.status == 200) {
				const data = JSON.parse(xhr.response);		
				console.log(data.result);
				if(data.result == 1) {
					document.querySelector('#validEmail').innerHTML = '존재하는 이메일입니다. 다른 이메일을 입력하세요.';
					document.querySelector('#validEmail').style.color = 'red';	
					isEmail = false;
				} else {
					document.querySelector('#validEmail').innerHTML = '사용할 수 있는 이메일입니다.';
					document.querySelector('#validEmail').style.color = 'green';
				}
			} else {
				console.error('error', xhr.status, xhr.statusText);				
			}
		}
	}
	
</script>	

</body>
</html>