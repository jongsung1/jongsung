<meta charset="utf-8" />
<?
	include  "C:/APM_Setup/htdocs/common/dbcon.php";

	$userid = $_POST['userid'];
	$TEMP1 = $_POST['password1']; // 입력 받은 값
    $userpw1 = hash('sha512', $TEMP1); // 넘어온 값 sha512 암호화

	$TEMP2 = $_POST['password2']; // 입력 받은 값
    
	$username = $_POST['name'];
	$team = $_POST['team'];
	$USERIP=$_SERVER['REMOTE_ADDR'];

	/// 필수 입력란 체크
	if(!$TEMP1){
		echo "
		<script type=\"text/javascript\">
			alert(\"패스워드를 입력하세요\");
			history.back();
		</script>
		";
		exit;
	}elseif(!$userid){
		echo "
		<script type=\"text/javascript\">
			alert(\"아이디를 입력하세요\");
			history.back();
		</script>
		";
		exit;
	}elseif(!$username){
		echo "
		<script type=\"text/javascript\">
			alert(\"이름을 입력하세요\");
			history.back();
		</script>
		";
		exit;
	}

	// 패스워드 일치 확인
	if($TEMP1 != $TEMP2){
		// 메세지 출력 후 이전 페이지로 이동
		echo "
		<script type=\"text/javascript\">
			alert(\"패스워드가 일치하지 않습니다\");
			history.back();
		</script>
		";
		exit;
	}
	
	// userid 중복 체크
	$sql = "select USERID from USER_INFO where USERID='$userid';";
	$result = mysqli_query($conn, $sql);
	$num = mysqli_num_rows($result);
	
	if($TEMP1 != $TEMP2){
		// 메세지 출력 후 이전 페이지로 이동
		echo "
		<script type=\"text/javascript\">
			alert(\"패스워드가 일치하지 않습니다\");
			history.back();
		</script>
		";
		exit;
	}

	if(!$num){ // 아이디가 존재하지 않으면
		// $sql = mq("insert into member (id,pw,name,adress,sex,email) 
// values
// ('".$userid."','".$userpw."','".$username."','".$adress."','".$sex."','".$email."')");
		$query1 = "insert into USER_INFO ";
		$query2 = "(USERID,USERNAME,USERIP,TEAM,ATTR,PASSWORD,OS)";
		$query3 = "VALUES ('$userid','$username','$USERIP','$team',1,'$userpw1','$os')";
		$query=$query1.$query2.$query3;
		mysqli_query($conn, $query);
		echo "
            <script type=\"text/javascript\">
                location.href = \"../index_page.php\";
            </script>
        ";

	} else{ // 아이디가 존재하면
		// 메세지 출력 후 이전 페이지로 이동
		echo "
		<script type=\"text/javascript\">
			alert(\"중복된 아이디 사용\");
			history.back();
		</script>
		";
		exit;
	}


// $sql = mq("insert into member (id,pw,name,adress,sex,email) 
// values
// ('".$userid."','".$userpw."','".$username."','".$adress."','".$sex."','".$email."')");

?>
<meta charset="utf-8" />
<script type="text/javascript">alert('회원가입이 완료되었습니다.');</script>

