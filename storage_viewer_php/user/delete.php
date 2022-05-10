<meta charset="utf-8" />
<?
	include  "C:/APM_Setup/htdocs/common/dbcon.php";
	include  "C:/APM_Setup/htdocs/common/funtion.php";

	$keyword = $_POST[keyword];
	
	if($keyword == "d10690"){
		go_back("삭제 실패");
	}else{
		$sql = "delete from USER_INFO where USERID='$keyword';";
		mysqli_query($conn, $sql);
		$sql = "delete from USER_DEVICE_INFO where USERID='$keyword';";
		mysqli_query($conn, $sql);
		go_back("삭제 되었습니다");
	}

?>
