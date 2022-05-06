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
<title> STORAGE index page </title>
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
				<td class="info_category">STORAGE INFO</td>
				<td class="info_bg"><font class="c_00"><A HREF="storage_info.php" >storage info</A></font></td>
			</tr>
			<tr>
				<td class="info_category">LUSTRE</td>
				<td class="info_bg"><font class="c_00"><a href="lustre.php" >lustre project size info</a></font></td>
			</tr>
			<tr>
				<td class="info_category">LUSTRE2</td>
				<td class="info_bg"><font class="c_00"><a href="lustre2.php" >lustre2 project size info</a></font></td>
			</tr>
			<tr>
				<td class="info_category">LUSTRE3</td>
				<td class="info_bg"><font class="c_00"><a href="lustre3.php" >lustre3 project size info</a></font></td>
			</tr>
			<tr>
				<td class="info_category">NETAPP</td>
				<td class="info_bg"><font class="c_00"><a href="netapp.php" >netapp project size info</a></font></td>
			</tr>	
		</table>

		<? echo "<br>" ?>
</body>
</html>
