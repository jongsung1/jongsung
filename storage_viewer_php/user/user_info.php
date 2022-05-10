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
  <!-- /////////////////// 검색 폼 /////////////////// -->
  <form name="search_form" action="user_info.php" method="post">
    <table align="center">
      <tr>
        <td align="center">
          <select name="search_option" size="1">
            <? 
              $option_list = array('USERID'=>'사번', 'USERNAME'=>'이름', 'USERIP'=>'IP', 'TEAM'=>'TEAM',
              'FLAG'=>'STATUS','MOUNT_FLAG'=>'mount_STATUS');
                while(list($option, $value) = each($option_list)){
                  echo "<option value=\"$option\">$value</option>";
                }
            ?>
          </select>
          <input type="text" name="keyword" value="<? echo $keyword ?>"><input type="submit" name="search_btn" value="검색">
        </td>
      </tr>
    </table>
  </form>
  <!-- /////////////////// 검색 폼 /////////////////// -->
<?
    if($_SESSION["s_idx"] == 9){
?>
    <!-- /////////////////// 삭제 폼 /////////////////// -->
    <form name="delete_form" action="delete.php" method="post">
    <table align="center">
      <tr>
        <td align="center">
          <select name="delete_option" size="1">
            <? 
              $option_list = array('USERID'=>'사번');
                while(list($option, $value) = each($option_list)){
                  echo "<option value=\"$option\">$value</option>";
                }
            ?>
          </select>
          <input type="text" name="keyword" value="<? echo $keyword ?>"><input type="submit" name="delete_btn" value="삭제">
        </td>
      </tr>
    </table>
  </form>
  <!-- /////////////////// 검색 폼 /////////////////// -->
<?
    }
?>
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
        $query1 = "select USERID,USERNAME,USERIP,TEAM,FLAG,MOUNT_FLAG,DATE from USER_INFO ";
        $where = "where OS='L'";
        $order = "order by FLAG asc, MOUNT_FLAG asc , TEAM asc,SEQ asc;";
        $query = $query1.$where.$order;
        //////검색 추가
        $search_option = $_POST[search_option];
        $keyword = $_POST[keyword];
    
        if(strlen($keyword) > 0){
          switch ($search_option){
            case "USERID":
              $where = "where OS='L' and USERID like '%$keyword%'";
              $query = $query1.$where.$order;
              break;
            case "USERNAME":
              $where = "where OS='L' and USERNAME like '%$keyword%'";
              $query = $query1.$where.$order;
              break;
            case "USERIP":
              $where = "where OS='L' and USERIP like '%$keyword%'";
              $query = $query1.$where.$order;
              break;
            case "TEAM":
              $where = "where OS='L' and TEAM like '%$keyword%'";
              $query = $query1.$where.$order;
              break;
            case "FLAG":
              $where = "where OS='L' and FLAG like '%$keyword%'";
              $query = $query1.$where.$order;
              break;
            case "MOUNT_FLAG":
              $where = "where OS='L' and MOUNT_FLAG like '%$keyword%'";
              $query = $query1.$where.$order;
              break;
          }
        }
        
          $sql = mysqli_query($conn,$query); 
          $i=0;
          while($board = $sql->fetch_array())
          {
            $i=$i+1;
            $no=$i;
        ?>
      <tbody>
        <tr>
          <td class="info_bg" width="50"><center><? echo $no; ?></center></td>
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
      <?} 
            if(strlen($keyword) > 0){
              echo "검색 결과 : ".$i."개 <br>";
              echo "<br>";
            }
      ?>
    </table>

   
    <? echo "<br>" ?>
    
    <!-- <div id="write_btn">
      <a href="/page/board/write.php"><button>글쓰기</button></a>
    </div> -->
  </div>
</body>
</html>
