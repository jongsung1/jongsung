<?
	session_start();
?>
<? 
  include  "C:/APM_Setup/htdocs/common/go_login.php"; 
	include  "C:/APM_Setup/htdocs/common/dbcon.php";
	include  "C:/APM_Setup/htdocs/common/style.php"; 
?>
<!doctype html>
<head>
<meta charset="UTF-8">
<title>ENV FARM</title>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
</head>
<body>
<div id="wrap">
<div id="container" align="center">
<? 
	  include  "C:/APM_Setup/htdocs/common/menu.php"; // 메뉴 바
?>
<h1>ENV FARM</h1>
  <div class="setup_msg" align="right">
			<?include  "C:/APM_Setup/htdocs/common/clock.html"; ?>
	</div>
  <table cellpadding="0" cellspacing="1" border="0" width="700" bgcolor="#d7d7d7" class="info_table">
      <thead>
          <tr>
              <th class="info_category" width="120">HOSTNAME</th>
              <th class="info_category" width="70">IP</th>
              <th class="info_category" width="120">STATUS</th>
              <th class="info_category" width="120">mount STATUS</th>
              <th class="info_category" width="120">date</th>
            </tr>
        </thead>
        <?php
          $query = "select * from ENV 
          order by FLAG asc, MOUNT_FLAG asc , SEQ asc";
          $sql = mysqli_query($conn,$query); 
            while($board = $sql->fetch_array())
            {
        ?>
      <tbody>
        <tr>
          <td class="info_bg" width="70"><center><?php echo $board['HOSTNAME']; ?></center></td>
          <td class="info_bg" width="120" ><center><?php echo $board['FARMIP']; ?></center></td>
          
          <?if($board["FLAG"]==0){ ?>
          <td class="info_bg" width="120" style="color:red"><center><? echo "DOWN";?></center></td>
          <?}else{?>
          <td class="info_bg" width="120" ><center><? echo "UP";?></center></td>
          <?}?>

          <?if($board["MOUNT_FLAG"]==0){ ?>
          <td class="info_bg" width="100" style="color:red"><center><? echo  "DOWN";?></center></td>
          <?}else{?>
          <td class="info_bg" width="100" ><center><? echo  "UP";?></center></td>
          <?}?>

          <td class="info_bg" width="100"><center><?php echo date("Y-m-d H:i", $board['DATE'])?></center></td>
        </tr>
      </tbody>
      <?php } ?>
    </table>

    <? echo "<br>" ?>
    <!-- <div id="write_btn">
      <a href="/page/board/write.php"><button>글쓰기</button></a>
    </div> -->
  </div>
</body>
</html>
