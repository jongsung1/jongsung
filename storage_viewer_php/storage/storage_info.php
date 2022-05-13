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
        <script> // 애니메이션 효과 변수를 위한 변수 배열 할당
          var data_size = new Array;
          var data_labels = new Array;
        </script>
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
          <td class="info_bg" width="120" style="color:red"><center><? echo $board['USED_PER']."%"?></center></td>
          <?}else{?>
          <td class="info_bg" width="120" ><center><? echo $board['USED_PER']."%"?></center></td>
          <?}?>

	        <script>
            data_labels.push("<? echo $board['STORAGE_NAME']; ?>");
            data_size.push("<? echo $board['USED_PER']; ?>");
            console_log(data_size[$i]);
          </script>
          
          <td class="info_bg" width="100"><center><? echo date("Y-m-d H:i", $board['DATE'])?></center></td>
        </tr>
      </tbody>
      <? } ?>
    </table>
		<? echo "<br>" ?>
<!--차트가 그려질 부분 시작-->
<div style="width: 900px; height: 600px;">
	<canvas id="myChart"></canvas>
</div>
  <script src="http://10.0.28.13/common/chart.js"></script>
  <script type="text/javascript">
            var context = document
                .getElementById('myChart')
                .getContext('2d');
            var myChart = new Chart(context, {
                type: 'bar', // 차트의 형태
                data: { // 차트에 들어갈 데이터
                    labels: [
                        //x 축
                          data_labels[0],data_labels[1],data_labels[2],data_labels[3],data_labels[4],data_labels[5],
                          data_labels[6],data_labels[7],data_labels[8],data_labels[9],data_labels[10],data_labels[11],
                          data_labels[12],data_labels[13],data_labels[14],data_labels[15],data_labels[16],data_labels[17]
                    ],
                    datasets: [
                        { //데이터
                            label: '스토리지 사용률', //차트 제목
                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                            data: [
                              data_size[0],data_size[1],data_size[2],data_size[3],data_size[4],data_size[5],
                              data_size[6],data_size[7],data_size[8],data_size[9],data_size[10],data_size[11],
                              data_size[12],data_size[13],data_size[14],data_size[15],data_size[16],data_size[17] //x축 label에 대응되는 데이터 값
                            ],
                            backgroundColor: [
                                //색상
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(153, 112, 255, 0.2)',
                                'rgba(153, 122, 255, 0.2)',
                                'rgba(85, 112, 255, 0.2)',
                                'rgba(255, 206, 96, 0.2)',
                                'rgba(255, 100, 132, 0.2)',
                                'rgba(54, 162, 245, 0.2)',
                                'rgba(64, 162, 235, 0.2)',
                                'rgba(154, 162, 235, 0.2)',
                                'rgba(24, 162, 235, 0.2)',
                                'rgba(125, 99, 132, 0.2)',
                                'rgba(5, 162, 235, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            borderColor: [
                                //경계선 색상
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 2 //경계선 굵기
                        }/* ,
                        {
                            label: 'test2',
                            fill: false,
                            data: [
                                8, 34, 12, 24
                            ],
                            backgroundColor: 'rgb(157, 109, 12)',
                            borderColor: 'rgb(157, 109, 12)'
                        } */
                    ]
                },
                options: {
                    scales: {
                        yAxes: [
                            {
                                ticks: {
                                    beginAtZero: true
                                }
                            }
                        ]
                    }
                }
            });
        </script>
<!--차트가 그려질 부분 끝-->
    
  </div>
</body>
</html>