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
<title>NETAPP STORAGE</title>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
</head>
<body>
<div id="wrap">
<div id="container" align="center">
<? 
	  include  "C:/APM_Setup/htdocs/common/menu.php"; // 로고, 메뉴 바
?>
  <h1>NETAPP</h1>
  <div class="setup_msg" align="right">
			<?include  "C:/APM_Setup/htdocs/common/clock.html"; ?>
	</div>

    <!-- /////////////////// 용량 변경 폼 /////////////////// -->
    <form name="search_form" action="netapp.php" method="post">
    <table>
      <tr>
        <td align="center">
          <select name="search_option" size="1">
            <? 
              $option_list = array('T'=>'T(테라)', 'G'=>'G(기가)', 'M'=>'M(메가)');
                while(list($option, $value) = each($option_list)){
                  echo "<option value=\"$option\">$value</option>";
                }
            ?>
          </select>
          <input type="submit" name="search_btn" value="적용">
        </td>
      </tr>
    </table>
  </form>
  <!-- /////////////////// 용량 변경 폼 /////////////////// -->
  <?
    $UNIT=T;  // 표시 용량 : 테라
    //$UNIT=G;  // 표시 용량 : 기가
    if($UNIT==T){ 
      $DIVISOR=1024*1024;
    }elseif ($UNIT==G) {
      $DIVISOR=1024;
    }

    $search_option = $_POST[search_option];
    switch ($search_option){
      case "T":
        $UNIT="T";
        $DIVISOR=1024*1024;
        break;
      case "G":
        $UNIT="G";
        $DIVISOR=1024;
        break;
      case "M":
        $UNIT="M";
        $DIVISOR=1;
        break;
    }
  ?>

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
          $query = "select * from PROJECT_DF_NETAPP ";
          $sql = mysqli_query($conn,$query); 
          $i=1;
            while($board = $sql->fetch_array())
            {
              $no=$i;
              //title변수에 DB에서 가져온 title을 선택
              $title=$board["PROJECT_NAME"]; 
              if(strlen($title)>30)
              { 
                //title이 30을 넘어서면 ...표시
                $title=str_replace($board["PROJECT_NAME"],mb_substr($board["PROJECT_NAME"],0,30,"utf-8")."...",$board["PROJECT_NAME"]);
              }
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
    <!-- <div id="write_btn">
      <a href="/page/board/write.php"><button>글쓰기</button></a>
    </div> -->
  </div>
</body>
</html>
