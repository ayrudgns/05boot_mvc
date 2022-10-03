/**
 * 
 */
let result = false;
const newp1 = document.querySelector("input[name='newpass']")
	newp1.addEventListener("input", check_newpass1);
	
const newp2 = document.querySelector("input[name='newpass2']")
	newp2.addEventListener("input", check_newpass2);
	
const oldp = document.querySelector("input[name='oldpass']")
	oldp.addEventListener("input", check_oldpass);
	
//	console.log(newp2)
	function check_oldpass(){			// 현재 비밀번호 확인
		if(oldp.value == "" || oldp.value != "" && oldp.value.length < 4) {
			document.getElementById("oldpass").innerHTML = "현재 비밀번호 4자리 이상 입력하세요.";
			document.getElementById("oldpass").style.color="red";
			result = false;
		}else{
			document.getElementById("oldpass").innerHTML = "";
			result = true;
		}
	}

	function check_newpass1(){			// 새로운 비밀번호 확인
		var exptest = (/^(?=.*[0-9]{1,20})(?=.*[A-Za-z]{1,20})[A-Za-z0-9]{4,20}$/).test(newp1.value);
		if (exptest === true){
			document.getElementById("newpass").innerHTML = "";
			document.getElementById("newpass").style.color = "";
			result = true;
		} else {
			document.getElementById("newpass").innerHTML = "영문 대소문자/숫자 사용 4자리 이상!!";
			document.getElementById("newpass").style.color = "red";
			result = false;
		}
		if (exptest === true && newp1.value == newp2.value){
			result = true;
		}else{
			result = false;
		}
	}
	
	function check_newpass2(){			// 새로운 비밀번호 일치하는지 확인
		var exptest = (/^(?=.*[0-9]{1,20})(?=.*[A-Za-z]{1,20})[A-Za-z0-9]{4,20}$/).test(newp1.value);
		if(newp2.value == "") {
			document.getElementById("newpass2").innerHTML = "비밀번호 확인 입력하세요.";
			document.getElementById("newpass2").style.color = "red";
			result = false;
		}else if(exptest == true && newp1.value == newp2.value) {
			document.getElementById("newpass").innerHTML = "OK!!";
			document.getElementById("newpass").style.color = "green";
			document.getElementById("newpass2").innerHTML = "새로운 비밀번호 확인 일치합니다.";
			document.getElementById("newpass2").style.color = "green";
			result = true;
		}else {
			document.getElementById("newpass").innerHTML = "NO!!";
			document.getElementById("newpass").style.color = "red";
			document.getElementById("newpass2").innerHTML = "새로운 비밀번호 확인 일치하지 않습니다.";
			document.getElementById("newpass2").style.color = "red";
			result = false;
		}
	}

	function validPassw() {				// 현재 비밀번호 입력 여부 확인
		if(oldp.value=="") {
			/* span 태그에 내용과 스타일 수정 */
			document.getElementById("oldpass").innerHTML="현재 비밀번호 입력 필수입니다.";
			document.getElementById("oldpass").style.color="red";
			document.getElementById("oldpass").focus();
			result=false;
			result=true;
			check_newpass1()
			check_newpass2()
		}
		console.log(result)
		return result;
	}