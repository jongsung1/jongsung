<meta charset="UTF-8">
<? 
	include  "C:/APM_Setup/htdocs/common/dbcon.php";
	include  "C:/APM_Setup/htdocs/common/style.php"; 
?>

<!doctype html>
<head>
<meta charset="UTF-8">
<title>USER login history</title>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
</head>
<body>
  
<div id="wrap">
<div id="container" align="center">
<? 
	  include  "C:/APM_Setup/htdocs/common/menu.php"; // 로고, 메뉴 바
?>
<h1>USER login history</h1>
  <div class="setup_msg" align="right">
			<?include  "C:/APM_Setup/htdocs/common/clock.html"; ?>
	</div>
  <table cellpadding="0" cellspacing="1" border="0" width="650" bgcolor="#d7d7d7" class="info_table">
      <thead>
          <tr>
              <th class="info_category" width="40">번호</th>
              <th class="info_category" width="70">사번</th>
              <th class="info_category" width="70">이름</th>
              <th class="info_category" width="50">팀</th>
              <th class="info_category" width="100">IP</th>
              <th class="info_category" width="120">date</th>
            </tr>
        </thead>
        <?
          $query = "
          select
          LH.SEQ,UI.USERID,UI.USERNAME,UI.TEAM,
          LH.USERIP,from_unixtime(LH.LOGINDATE)
          from LOGIN_HISTORY as LH 
          left join USER_INFO as UI  
          on UI.USERID = LH.USERID
          where UI.USERID is not null
          order by LH.LOGINDATE desc;
          ";
          $sql = mysqli_query($conn,$query); 
          while($board = $sql->fetch_array())
          {
            
        ?>
      <tbody>
        <tr>
          <td class="info_bg" width="30"><center><? echo $board['SEQ']; ?></center></td>
          <td class="info_bg" width="70"><center><? echo $board['USERID']; ?></center></td>
          <td class="info_bg" width="120" ><center><?php echo $board['USERNAME']?></center></td>
          <td class="info_bg" width="100" ><center><?php echo $board['TEAM']?></center></td>
          <td class="info_bg" width="120" ><center><?php echo $board['USERIP']?></center></td>
          <td class="info_bg" width="100"><center><?php echo $board['from_unixtime(LH.LOGINDATE)']?></center></td>
        </tr>
      </tbody>
      <?php } ?>
    </table>

    
    <!-- <div id="write_btn">
      <a href="/page/board/write.php"><button>글쓰기</button></a>
    </div> -->
  </div>
</body>
</html>
