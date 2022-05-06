<?
	include  "C:/APM_Setup/htdocs/common/dbcon.php";
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>회원가입</title>
</head>

<body>
	<form method="post" action="join_ok.php" onsubmit="return check()">
		<h1>회원가입</h1>
			<fieldset>
				<legend>입력사항</legend>
					<table>
						<tr>
							<td>아이디(사번)</td>
							<td><input type="text" size="35" name="userid" id="USERID" class="USERID" autofocus placeholder="아이디"></td>
						</tr>
						<tr>
							<td>비밀번호</td>							
							<td><input type="password" size="35" name="password1" id="PASSWORD" class="PASSWORD" placeholder="비밀번호"></td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td><input type="password" size="35" name="password2" placeholder="비밀번호"></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input type="text" size="35" name="name" placeholder="이름"></td>
						</tr>
						<tr>
							<td>TEAM</td>
							<td>
								<!-- <input type="text" name="email"> -->
									<!--<select name="emadress"> -->
									<select name="team">
										<option value="2DC">2DC</option>
										<option value="2D1">2D1</option>
										<option value="2D2">2D2</option>
										<option value="2D3">2D3</option>
										<option value="2D4">2D4</option>
										<option value="2D5">2D5</option>
										<option value="2D6">2D6</option>
										<option value="FX">FX</option>
										<option value="pipeline">pipeline</option>
										<option value="Animation">Animation</option>
										<option value="CFX">CFX</option>
										<option value="Environment">Environment</option>
										<option value="Lighting">Lighting</option>
										<option value="MatchMove">MatchMove</option>
										<option value="Modeling">Modeling</option>
										<option value="Previz">Previz</option>
										<option value="Supervisor">Supervisor</option>
										<option value="Digital_Management">Digital_Management</option>
										<option value="planning">planning</option>
										<option value="pmteam">pmteam</option>
										<option value="CEO">CEO</option>
										<option value="HR">HR</option>
									</select>
							</td>
						</tr>
						<tr>
							<td>OS</td>
							<td>
								<select name="os">
									<option value="L">Linux</option>
									<option value="W">Window</option>
								</select>
							</td>
						</tr>
					</table>
					<? echo "<br>" ?>
				<input type="submit" value="가입하기" /><input type="reset" value="다시쓰기" />
			
		</fieldset>
	</form>
</body>
</html>
