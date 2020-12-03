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
<h2><span style="font-size:2.5em;color:pink;font-family: Georgia;">When we meet!</span></h2>
</center>
<HR>

<!-- 탈퇴폼--> 
<div class="container"> 
	<div class="col-lg-2"></div> 
	<div class="col-lg-8"> 
	<!-- 점보트론--> 
		<div class="jumbotron" style="padding-top: 40px;"> 
		<!-- 탈퇴회원 정보 숨기고 전송--> 
		<form method="post" action="delIdAction.jsp"> 
			<h3 style="text-align: left;">회원 탈퇴</h3> 
			<div class="form-group-lg"> 
				<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20"> 
			</div> 
			<div class="btn-group" role="group" aria-label="...">
  				<button type="button" class="btn btn-outline-danger"></button>
			</div>
			
			<div class="form-group-lg"> 
				<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20"> 
			</div> 
			<div class="btn-group" role="group" aria-label="...">
  				<button type="button" class="btn btn-outline-danger"></button>
			</div>
			
			<div class="form-group-lg"> 
				<input type="submit" class="btn btn-danger disabled btn-lg form-control"  value="탈퇴"> 
			</div>
			</form> 
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
