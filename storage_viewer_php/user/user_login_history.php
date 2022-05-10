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
  <!-- /////////////////// 검색 폼 /////////////////// -->
  <form name="search_form" action="user_login_history.php" method="post">
    <table>
      <tr>
        <td align="center">
          <select name="search_option" size="1">
            <? 
              $option_list = array('UI.USERID'=>'사번', 'UI.USERNAME'=>'이름', 
              'UI.TEAM'=>'TEAM','LH.USERIP'=>'IP');
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
          $query1 = "
          select
          LH.SEQ,UI.USERID,UI.USERNAME,UI.TEAM,
          LH.USERIP,from_unixtime(LH.LOGINDATE)
          from LOGIN_HISTORY as LH 
          left join USER_INFO as UI  
          on UI.USERID = LH.USERID ";
          $where = "where UI.USERID is not null ";
          $order = "order by LH.LOGINDATE desc;";
          $query = $query1.$where.$order;

          //////검색 추가
          $search_option = $_POST[search_option];
          $keyword = $_POST[keyword];

          if(strlen($keyword) > 0){
            switch ($search_option){
              case "UI.USERID":
                $where = "where UI.USERID like '%$keyword%'";
                $query = $query1.$where.$order;
                break;
              case "UI.USERNAME":
                $where = "where UI.USERID is not null and UI.USERNAME like '%$keyword%'";
                $query = $query1.$where.$order;
                break;
              case "UI.TEAM":
                $where = "where UI.USERID is not null and UI.TEAM like '%$keyword%'";
                $query = $query1.$where.$order;
                break;
              case "LH.USERIP":
                $where = "where UI.USERID is not null and LH.USERIP like '%$keyword%'";
                $query = $query1.$where.$order;
                break;
            }
          }
          //echo $query;
          $sql = mysqli_query($conn,$query); 
          $i=0;
          while($board = $sql->fetch_array())
          {
            $i=$i+1;
            $no=$i;
        ?>
      <tbody>
        <tr>
          <td class="info_bg" width="30"><center><? echo $no; ?></center></td>
          <td class="info_bg" width="70"><center><? echo $board['USERID']; ?></center></td>
          <td class="info_bg" width="120" ><center><? echo $board['USERNAME']?></center></td>
          <td class="info_bg" width="100" ><center><? echo $board['TEAM']?></center></td>
          <td class="info_bg" width="120" ><center><? echo $board['USERIP']?></center></td>
          <td class="info_bg" width="100"><center><? echo $board['from_unixtime(LH.LOGINDATE)']?></center></td>
        </tr>
      </tbody>
      <? }
      if(strlen($keyword) > 0){
        echo "검색 결과 : ".$i."개 <br>";
        echo "<br>";
      }      
      ?>
    </table>

    <? echo "<br>" ?>
  </div>
</body>
</html>
