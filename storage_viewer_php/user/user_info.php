<?
  session_start();
  include  "C:/APM_Setup/htdocs/common/go_login.php"; 
?>
<meta charset="UTF-8">
<? 
	include  "C:/APM_Setup/htdocs/common/dbcon.php";
	include  "C:/APM_Setup/htdocs/common/style.php"; 
?>

<!doctype html>
<head>
<meta charset="UTF-8">
<title>USER INFO</title>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
</head>
<body>
<div id="wrap">
<div id="container" align="center">
<? 
	  include  "C:/APM_Setup/htdocs/common/menu.php"; // 로고, 메뉴 바
?>
  <h1>USER INFO</h1>
  
  <div class="setup_msg" align="right">
			<?include  "C:/APM_Setup/htdocs/common/clock.html"; ?>
	</div>
  <table cellpadding="0" cellspacing="1" border="0" width="800" bgcolor="#d7d7d7" class="info_table">
      <thead>
          <tr>
              <th class="info_category" width="50">No</th>
              <th class="info_category" width="50">사번</th>
              <th class="info_category" width="70">이름</th>
              <th class="info_category" width="70">IP</th>
              <th class="info_category" width="70">TEAM</th>
              <th class="info_category" width="70">STATUS</th>
              <th class="info_category" width="100">mount STATUS</th>
              <th class="info_category" width="100">date</th>
            </tr>
        </thead>
        <?
          $query = "select USERID,USERNAME,USERIP,TEAM,FLAG,MOUNT_FLAG,DATE 
          from USER_INFO 
          where OS='L'
          order by FLAG asc, MOUNT_FLAG asc , TEAM asc,SEQ asc;";
          $sql = mysqli_query($conn,$query); 
          $i=1;
          while($board = $sql->fetch_array())
          {
            $no=$i;
        ?>
      <tbody>
        <tr>
          <td class="info_bg" width="50"><center><? echo $no; $i=$i+1;?></center></td>
          <td class="info_bg" width="50"><center><? echo $board['USERID']; ?></center></td>
          <td class="info_bg" width="70" ><center><? echo $board['USERNAME']?></center></td>
          <td class="info_bg" width="70" ><center><? echo $board['USERIP']?></center></td>
          <td class="info_bg" width="70" ><center><? echo $board['TEAM']?></center></td>
          
          <?if($board["FLAG"]==0){ ?>
          <td class="info_bg" width="70" style="color:red"><center><? echo "DOWN";?></center></td>
          <?}else{?>
          <td class="info_bg" width="70" ><center><? echo "UP";?></center></td>
          <?}?>
          
          <?if($board["MOUNT_FLAG"]==0){ ?>
          <td class="info_bg" width="100" style="color:red"><center><? echo "DOWN";?></center></td>
          <?}else{?>
          <td class="info_bg" width="100" ><center><? echo "UP";?></center></td>
          <?}?>

          <td class="info_bg" width="100"><center><?php echo date("Y-m-d", $board['DATE'])?></center></td>
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
