<?
  session_start();
  include  "C:/APM_Setup/htdocs/common/go_login.php"; 
	include  "C:/APM_Setup/htdocs/common/dbcon.php";
	include  "C:/APM_Setup/htdocs/common/style.php"; 
?>
<!doctype html>
<head>
<meta charset="UTF-8">
<title>STORAGE INFO</title>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
</head>
<body>
<div id="wrap">
<div id="storage_info_container" align="center">
<? 
	  include  "C:/APM_Setup/htdocs/common/menu.php"; // 로고, 메뉴 바
?>
  <h1>STORAGE size</h1>
  
  <div class="setup_msg" align="right">
			<?include  "C:/APM_Setup/htdocs/common/clock.html"; ?>
	</div>
      <!-- /////////////////// 검색 폼 /////////////////// -->
      <form name="search1_form" action="<? echo $_SERVER['PHP_SELF']; ?>" method="post">
      <table align="center">
        <tr>
          <td align="center">
            <select name="search1_option" size="1">
              <? 
                $option_list = array('STORAGE_NAME'=>'STORAGE_NAME');
                  while(list($option, $value) = each($option_list)){
                    echo "<option value=\"$option\">$value</option>";
                  }
              ?>
            </select>
            <input type="text" name="keyword1" value="<? echo $keyword1 ?>"> <input type="submit" name="search_btn" value="검색">
          </td>
        </tr>
      </table>
    </form>
    <!-- /////////////////// 검색 폼 /////////////////// -->
    <!-- /////////////////// 용량 변경 폼 /////////////////// -->
    <form name="search_form" action="storage_info.php" method="post">
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
    $DIVISOR=1024*1024;
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
  <table cellpadding="0" cellspacing="1" border="0" width="800" bgcolor="#d7d7d7" class="info_table">
      <thead>
          <tr>
              <th class="info_category" width="70">No</th>
              <th class="info_category" width="150">STORAGE_NAME</th>
              <th class="info_category" width="70">SIZE<? echo "(".$UNIT.")";?></th>
              <th class="info_category" width="70">USED<? echo "(".$UNIT.")";?></th>
              <th class="info_category" width="70">AVAIL<? echo "(".$UNIT.")";?></th>
              <th class="info_category" width="70">USED_PER(%)</th>
              <th class="info_category" width="150">날짜</th>
            </tr>
        </thead>
        <?
          $query1 = "select * from STORAGE_INFO ";
          $where = "where 1=1 ";
          $order = "order by USED_PER desc, USED desc , SIZE desc ;";
          $query = $query1.$where.$order;
          //////검색 추가
          $search1_option = $_POST[search1_option];
          $keyword1 = $_POST[keyword1];
          if(strlen($keyword1) > 0){
            switch ($search1_option){
              case "STORAGE_NAME":
                $where = "where STORAGE_NAME like '%$keyword1%'";
                $query = $query1.$where.$order;
                break;
            }
          }
          //////검색 추가 부분 끝
          $sql = mysqli_query($conn,$query); 
          $i=1;
            while($board = $sql->fetch_array())
            {
              $no=$i;
              //title변수에 DB에서 가져온 title을 선택
              $title=$board["STORAGE_NAME"]; 
              if(strlen($title)>30)
              { 
                //title이 30을 넘어서면 ...표시
                $title=str_replace($board["STORAGE_NAME"],mb_substr($board["STORAGE_NAME"],0,30,"utf-8")."...",$board["STORAGE_NAME"]);
              }
        ?>
      <tbody>
        <tr>
          <td class="info_bg" width="70"><center><? echo $no; $i=$i+1;?></center></td>
          <td class="info_bg" width="70"><center><? echo $board['STORAGE_NAME']; ?></center></td>
          <td class="info_bg" width="120" ><center><? echo $board['SIZE']=round($board['SIZE'] /$DIVISOR,2)?></center></td>
          <td class="info_bg" width="120" ><center><? echo $board['USED']=round($board['USED']/$DIVISOR,2)?></center></td>
          <td class="info_bg" width="120" ><center><? echo $board['AVAIL']=round($board['AVAIL']/$DIVISOR,2)?></center></td>
          
          <?if($board['USED_PER']>"80%"){ ?>
          <td class="info_bg" width="120" style="color:red"><center><? echo $board['USED_PER']?></center></td>
          <?}else{?>
          <td class="info_bg" width="120" ><center><? echo $board['USED_PER']?></center></td>
          <?}?>
          
          <td class="info_bg" width="100"><center><? echo date("Y-m-d H:i", $board['DATE'])?></center></td>
        </tr>
      </tbody>
      <? } ?>
    </table>

    
    <? echo "<br>" ?>
    <!-- <div id="write_btn">
      <a href="/page/board/write.php"><button>글쓰기</button></a>
    </div> -->
  </div>
  
</body>
</html>