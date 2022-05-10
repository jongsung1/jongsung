<meta charset="utf-8" />

<?
	include  "C:/APM_Setup/htdocs/common/dbcon.php";
	include  "C:/APM_Setup/htdocs/common/funtion.php";

	$keyword = $_POST[keyword];	//userid

	$PASSWORD = hash('sha512', $keyword); // 넘어온 값 sha512 암호화
	echo $PASSWORD;

	$sql="update USER_INFO set PASSWORD='$PASSWORD',FAIL_COUNT=0 where USERID = '$keyword';";
	mysqli_query($conn, $sql);
	go_back("패스워드가 초기화 되었습니다");
?>
