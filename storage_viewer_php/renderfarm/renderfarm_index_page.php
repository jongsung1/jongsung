<?
	session_start();
?>
<meta charset="UTF-8">
<? 
	include  "C:/APM_Setup/htdocs/common/dbcon.php";
	include  "C:/APM_Setup/htdocs/common/style.php"; 
	include  "C:/APM_Setup/htdocs/common/go_login.php"; 
?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title> RENDERFARM index page </title>
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
				<td class="info_category">2D FARM INFO</td>
				<td class="info_bg"><font class="c_00"><A HREF="farm.php" >2D FARM info</A></font></td>
			</tr>
			<tr>
				<td class="info_category">cache</td>
				<td class="info_bg"><font class="c_00"><a href="cache.php" >cache farm info</a></font></td>
			</tr>
			<tr>
				<td class="info_category">ENV</td>
				<td class="info_bg"><font class="c_00"><a href="env.php" >env farm info</a></font></td>
			</tr>
			<tr>
				<td class="info_category">HPFX</td>
				<td class="info_bg"><font class="c_00"><a href="hpfx.php" >fx farm info</a></font></td>
			</tr>
			<tr>
				<td class="info_category">Lookdev</td>
				<td class="info_bg"><font class="c_00"><a href="hprender.php" >hprender farm info</a></font></td>
			</tr>	
			<tr>
				<td class="info_category">SCAN</td>
				<td class="info_bg"><font class="c_00"><a href="dpx.php" >scan farm info</a></font></td>
			</tr>	
		</table>

		<? echo "<br>" ?>
</body>
</html>
