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