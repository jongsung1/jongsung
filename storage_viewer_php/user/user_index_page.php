<?
  session_start();
  include  "C:/APM_Setup/htdocs/common/go_login.php"; 
?>
<meta charset="UTF-8">
<? 
	include  "C:/APM_Setup/htdocs/common/dbcon.php";
	include  "C:/APM_Setup/htdocs/common/style.php"; 
?>

<?
	#print_r($_SESSION);
	
	#echo "----1------";
	#echo $_SESSION["s_idx"];
	#echo "-----2-----";
	#echo $_SESSION["s_name"];
	#echo "------3----";
	#echo $_SESSION["s_id"];
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title> USER index page </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>

<body>
<div id="wrap">


	<div id="container" align="center">
	<? 
	  include  "C:/APM_Setup/htdocs/common/menu.php"; // 로고, 메뉴 바
	?>
		
		<div class="setup_msg" align="right">
			<?include  "C:/APM_Setup/htdocs/common/clock.html"; ?>
		</div>
		<div class="info_msg">
			
		</div>

		<table cellpadding="0" cellspacing="1" border="0" width="580" bgcolor="#d7d7d7" class="info_table">
		
			<tr>
				<td class="info_category">user info</td>
				<td class="info_bg"><font class="c_00"><A HREF="user_info.php" >user info</A></font></td>
			</tr>
			<tr>
				<td class="info_category">user device info</td>
				<td class="info_bg"><font class="c_00"><A HREF="user_device_info.php" >user device info</A></font></td>
			</tr>
			<?
				if($_SESSION["s_idx"] == 9){ 
			?>
			<tr>
				<td class="info_category">login history</td>
				<td class="info_bg"><font class="c_00"><a href="user_login_history.php" >login history</a></font></td>
			</tr>
			<?}?>
			
		</table>

		<? echo "<br>" ?>
</body>
</html>
