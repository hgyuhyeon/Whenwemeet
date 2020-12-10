<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<!--뷰포트--> 
<meta name ="viewport" content = "width = device-width", initial-scale="1"> 
<!-- 스타일시트--> 
<link rel="stylesheet" href="css/bootstrap.css"> 
<title>When we meet!</title> 
</head> 
<body> 

<center>
<h2><span style="font-size:2.5em;color:pink;font-family: Georgia;">When we meet?</span></h2>
</center>
<HR>

<!-- 로그인폼--> 
<div class="container"> 
	<div class="col-lg-2"></div> 
	<div class="col-lg-8"> 
	<!-- 점보트론--> 
		<div class="jumbotron" style="padding-top: 40px;"> 
		<!-- 로그인 정보 숨기고 전송--> 
		<form method="post" action="loginAction.jsp"> 
			<h3 style="text-align: left;">로그인</h3> 
			
			<div class="form-group-lg"> 
				<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20"> 
			</div> 
			<br>
			<div class="form-group-lg"> 
				<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20"> 
			</div> 
			<br>
			<div class="form-group-lg">
				<input type="submit" class="btn btn-danger disabled form-control btn-lg"  value="로그인"> 
			</div>
			</form> 
			</div> 
		<div class="btn-group" role="group" aria-label="...">
  			<button type="button" class="btn btn-outline-danger btn-lg" onclick = "location.href = 'join.jsp' ">회원가입</button>
		</div>
		</div> 
			<div class="col-lg-2"></div> 
		</div> 
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"> 
</script> 
	<script src="js/bootstrap.js"> 
</script> 
</body> 
</html>
