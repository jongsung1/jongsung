<?
  session_start();
  include  "C:/APM_Setup/htdocs/common/go_login.php"; 
	include  "C:/APM_Setup/htdocs/common/dbcon.php";
	include  "C:/APM_Setup/htdocs/common/style.php"; 
?>

<? 
  //$UNIT=T;  // 표시 용량 : 테라
  $UNIT=G;  // 표시 용량 : 기가
  if($UNIT==T){ 
    $DIVISOR=1024*1024;
  }elseif ($UNIT==G) {
    $DIVISOR=1024;
  }
?>
<!doctype html>
<head>
<meta charset="UTF-8">
<title>LUSTRE3 STORAGE</title>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
</head>
<body>
<div id="wrap">
<div id="container" align="center">
<? 
	  include  "C:/APM_Setup/htdocs/common/menu.php"; // 로고, 메뉴 바
?>
  <h1>LUSTRE3</h1>
  
  <div class="setup_msg" align="right">
			<?include  "C:/APM_Setup/htdocs/common/clock.html"; ?>
	</div>
  <table cellpadding="0" cellspacing="1" border="0" width="580" bgcolor="#d7d7d7" class="info_table">
      <thead>
          <tr>
              <th class="info_category" width="70">No</th>
              <th class="info_category" width="120">PROJECT</th>
              <th class="info_category" width="70">SIZE<? echo "(".$UNIT.")";?></th>
              <th class="info_category" width="120">날짜</th>
            </tr>
        </thead>
        <?php
          $query = "select * from PROJECT_DF_LUSTRE3 ";
          $sql = mysqli_query($conn,$query); 
          $i=1;
          $SUM=0;
            while($board = $sql->fetch_array())
            {
              $no=$i;
              $SUM=$SUM+$board['SIZE'];
        ?>
      <tbody>
        <tr>
          <td class="info_bg" width="70"><center><? echo $no; $i=$i+1;?></center></td>
          <td class="info_bg" width="70"><center><?php echo $board['PROJECT_NAME']; ?></center></td>
          <td class="info_bg" width="120" ><center><?php echo $board['SIZE']=round($board['SIZE']/$DIVISOR,2)?></center></td>
          <td class="info_bg" width="100"><center><?php echo date("Y-m-d", $board['DATE'])?></center></td>
        </tr>
      </tbody>
      <?php } ?>
    </table>
    <? echo "<br>" ?>

    <table cellpadding="0" cellspacing="1" border="0" width="580" bgcolor="#d7d7d7" class="info_table">
        <thead>
          <tr>
            <th class="info_category" width="70">총 합<? echo "(".$UNIT.")";?></th>
          </tr>
        </thead>
      <tbody>
        <tr>
          <td class="info_bg" width="120" ><center><?  echo $SUM=round($SUM/$DIVISOR,2); ?></center></td>
        </tr>
      </tbody>
    </table>  
    <? echo "<br>" ?> 
  </div>
</body>
</html>
