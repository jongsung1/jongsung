<meta charset="utf-8" />

<?
	include  "C:/APM_Setup/htdocs/common/dbcon.php";

	$keyword = $_POST[keyword];
//	echo $keyword;
	
	if($keyword != "d10690"){
		$sql = "delete from USER_INFO where USERID='$keyword';";
		mysqli_query($conn, $sql);
		$sql = "delete from USER_DEVICE_INFO where USERID='$keyword';";
		mysqli_query($conn, $sql);
		echo "
		<script type=\"text/javascript\">
			alert(\"삭제 되었습니다\");
			history.back();
		</script>
		";
		exit;
	}else{
		echo "
		<script type=\"text/javascript\">
			alert(\"삭제 실패\");
			history.back();
		</script>
		";
		exit;
	}

?>

<meta charset="utf-8" />
<!--
<script type="text/javascript">alert('삭제 되었습니다.');</script>
-->
