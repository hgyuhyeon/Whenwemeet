<%@ page language="java" contentType="text/html; 
charset=UTF-8" pageEncoding="UTF-8"%> 
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
	<h2><span style="font-size:2.5em;color:pink;font-family: Georgia;">When we meet!</span></h2></center>
	<HR>
	
	<!-- 로그인폼--> 
	<div class="container"> 
		<div class="col-lg-2"></div> 
		<div class="col-lg-8"> 
	<!-- 점보트론--> 
		<div class="jumbotron" style="padding-top: 20px;"> 
		<!-- 로그인 정보 숨기고 전송--> 
		<form method="post" action="joinAction.jsp"> 
			<h3 style="text-align: left;">회원가입</h3>
			<div class="btn-group" role="group" aria-label="...">
  				<button type="button" class="btn btn-outline-danger"></button>
			</div> 
			
			<div class="form-group-lg"> 
				<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20"> 
			</div> 
			<br>
			
			<div class="form-group-lg"> 
				<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20"> 
			</div> 
			<br>			
			
			<div class="form-group-lg"> 
				<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20"> 
			</div>			
			<br>
					
			<div class="form-group-lg" style="text-align: center;"> 
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-danger active"> <input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
					</label> <label class="btn btn-danger"> <input type="radio" name="userGender" autocomplete="off" value="여자" >여자
							</label>
				</div>
			</div> 
			<br>
			
			<div class="form-group-lg"> 
				<input type="text" class="form-control" placeholder="이메일" name="userEmail" maxlength="50"> 
			</div> 
			<br>			
			<div class="form-group-lg">
				<input type="submit" class="btn btn-danger disabled form-control" value="회원가입"> 
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

