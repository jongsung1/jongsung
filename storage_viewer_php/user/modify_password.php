<meta charset="utf-8" />

<?
	include  "C:/APM_Setup/htdocs/common/dbcon.php";

	$keyword = $_POST[keyword];	//userid

	$PASSWORD = hash('sha512', $keyword); // 넘어온 값 sha512 암호화
	echo $PASSWORD;

	$sql="update USER_INFO set PASSWORD='$PASSWORD',FAIL_COUNT=0 where USERID = '$keyword';";
	mysqli_query($conn, $sql);
	
	echo "
	<script type=\"text/javascript\">
		alert(\"패스워드가 초기화 되었습니다\");
		history.back();
	</script>
	";
	exit;
?>

<meta charset="utf-8" />
<!--
<script type="text/javascript">alert('삭제 되었습니다.');</script>
-->
