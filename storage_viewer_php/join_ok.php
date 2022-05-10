<meta charset="utf-8" />
<?
	include  "C:/APM_Setup/htdocs/common/dbcon.php";
	include  "C:/APM_Setup/htdocs/common/funtion.php";

	$userid = $_POST['userid'];
	$TEMP1 = $_POST['password1']; // 입력 받은 값
    $userpw1 = hash('sha512', $TEMP1); // 넘어온 값 sha512 암호화

	$TEMP2 = $_POST['password2']; // 입력 받은 값
    
	$username = $_POST['name'];
	$team = $_POST['team'];
	$USERIP=$_SERVER['REMOTE_ADDR'];

	/// 필수 입력란 체크
	if(!$TEMP1){
		go_back("패스워드를 입력하세요");
	}elseif(!$userid){
		go_back("아이디를 입력하세요");
	}elseif(!$username){
		go_back("이름을 입력하세요");
	}
	
	// 패스워드 일치 확인
	if($TEMP1 != $TEMP2){
		// 메세지 출력 후 이전 페이지로 이동
		go_back("패스워드가 일치하지 않습니다");
	}

	// userid 중복 체크
	$sql = "select USERID from USER_INFO where USERID='$userid';";
	$result = mysqli_query($conn, $sql);
	$num = mysqli_num_rows($result);
	
	if(!$num){ // 아이디가 존재하지 않으면
		$query1 = "insert into USER_INFO ";
		$query2 = "(USERID,USERNAME,USERIP,TEAM,ATTR,PASSWORD,OS) ";
		$query3 = "VALUES ('$userid','$username','$USERIP','$team',1,'$userpw1','$os') ";
		$query=$query1.$query2.$query3;
		mysqli_query($conn, $query);
		go_target("회원가입이 완료되었습니다.","index_page.php");
	} else{ // 아이디가 존재하면
		// 메세지 출력 후 이전 페이지로 이동
		go_back("중복된 아이디 사용");
	}
?>