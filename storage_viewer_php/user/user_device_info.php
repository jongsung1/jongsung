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
<title>USER DEVICE INFO</title>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
</head>
<body>
<div id="wrap">
<div id="user_info_container" align="center">
<? 
	  include  "C:/APM_Setup/htdocs/common/menu.php"; // 로고, 메뉴 바
?>
  <h1>USER DEVICE INFO</h1>
  
  <div class="setup_msg" align="right">
			<?include  "C:/APM_Setup/htdocs/common/clock.html"; ?>
	</div>
  <table cellpadding="0" cellspacing="1" border="0" width="1600" bgcolor="#d7d7d7" class="info_table">
      <thead>
          <tr>
              <th class="info_category" width="70">사번</th>
              <th class="info_category" width="70">이름</th>
              <th class="info_category" width="70">팀</th>
              <th class="info_category" width="300">CPU</th>
              <th class="info_category" width="300">DISK</th>
              <th class="info_category" width="70">memory</th>
              <th class="info_category" width="70">GPU</th>
              <th class="info_category" width="70">모니터1</th>
              <th class="info_category" width="70">모니터2</th>
              <th class="info_category" width="120">date</th>
            </tr>
        </thead>
        <?
          $query = "select 
          UDI.USERID,UI.USERNAME,UI.TEAM,
          UDI.CPU,UDI.DISK,UDI.MEM,UDI.GPU,UDI.MONITOR1,UDI.MONITOR2,UDI.DATE 
          from USER_DEVICE_INFO as UDI 
          left join USER_INFO as UI 
          on UDI.USERID = UI.USERID order by UI.TEAM desc;";
          $sql = mysqli_query($conn,$query); 
          while($board = $sql->fetch_array())
          {
            //title변수에 DB에서 가져온 title을 선택
            $CPU_title=substr($board['CPU'], 0,17); 
            if($CPU_title=="Intel(R) Core(TM)")
            { 
              //CPU 이름이 Intel(R) Core(TM) 으로 시작하면 Intel(R) Core(TM) 자르고 기입
              $board['CPU'] = substr($board['CPU'], 17);
            }
            $GPU_title=substr($board['GPU'], 0,6); 
            if($GPU_title=="NVIDIA")
            { 
              //CPU 이름이 Intel(R) Core(TM) 으로 시작하면 Intel(R) Core(TM) 자르고 기입
              $board['GPU'] = substr($board['GPU'], 6);
            }
        ?>
      <tbody>
        <tr>
          <td class="info_bg" width="70"><center><? echo $board['USERID']; ?></center></td>
          <td class="info_bg" width="120" ><center><?php echo $board['USERNAME']?></center></td>
          <td class="info_bg" width="120" ><center><?php echo $board['TEAM']?></center></td>
          <td class="info_bg" width="120" ><center><?php echo $board['CPU']?></center></td>
          <td class="info_bg" width="120" ><center><?php echo $board['DISK']?></center></td>
          <td class="info_bg" width="50" ><center><?php echo $board['MEM']?></center></td>
          <td class="info_bg" width="150" ><center><?php echo $board['GPU']?></center></td>
          <td class="info_bg" width="120" ><center><?php echo $board['MONITOR1']?></center></td>
          <td class="info_bg" width="120" ><center><?php echo $board['MONITOR2']?></center></td>
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
