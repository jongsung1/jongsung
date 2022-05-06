<?
	session_start();
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
<title> MAIN </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>

<body>
<div id="wrap">


	<div id="container" align="center">
		<div class="logo"><img src="./picture/logo.PNG" alt="" border="0"></div>
		
		
		<div class="setup_msg" align="right">
			<?include  "C:/APM_Setup/htdocs/common/clock.html"; ?>
		</div>
		<div class="info_msg">
			
		</div>

		<table cellpadding="0" cellspacing="1" border="0" width="580" bgcolor="#d7d7d7" class="info_table">
		
			<tr>
				<td class="info_category">storage index page</td>
				<td class="info_bg"><font class="c_00"><A HREF="./storage/storage_index_page.php" >storage index</A></font></td>
			</tr>
			<tr>
				<td class="info_category">renderfarm index page</td>
				<td class="info_bg"><font class="c_00"><A HREF="./renderfarm/renderfarm_index_page.php" >renderfarm index</A></font></td>
			</tr>
			<tr>
				<td class="info_category">user index page</td>
				<td class="info_bg"><font class="c_00"><A HREF="./user/user_index_page.php" >user index</A></font></td>
			</tr>
			
		</table>

		<? echo "<br>" ?>
</body>
</html>
