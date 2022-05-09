<meta charset="UTF-8">
<?
/* 세션 실행 */
session_start();
$_SESSION["s_id"]=$_POST["USERID"];
/* 이전 페이지에서 값 가져오기 */
$USERID = $_POST["USERID"];
$PASSWORD = $_POST["PASSWORD"];
// echo "ID : ".$u_id." / PW : ".$pwd;

/* DB 접속 */
include  "C:/APM_Setup/htdocs/common/dbcon.php";

/* 쿼리 작성 */
$sql = "select ATTR, USERNAME, USERID, PASSWORD,FAIL_COUNT from USER_INFO where USERID='$USERID';";
//echo $sql;

/* 쿼리 전송(연결 객체) */
$result = mysqli_query($conn, $sql);

/* DB에서 결과값 가져오기 */
// mysqli_fetch_row // 필드 순서
// mysqli_fetch_array // 필드명
// mysqli_num_rows // 결과행의 개수
$num = mysqli_num_rows($result);

/* 조건 처리 */
if(!$num){ // 아이디가 존재하지 않으면
    // 메세지 출력 후 이전 페이지로 이동
    echo "
        <script type=\"text/javascript\">
            alert(\"아이디 혹은 비밀번호가 일치하지 않습니다.\");
            history.back();
        </script>
    ";
    exit;
} else{ // 아이디가 존재하면
    // DB에서 사용자 정보 가져오기
    $array = mysqli_fetch_array($result);

    //// FAIL_COUNT 5 이상일때 로그인 lock
    $FAIL_LIMIT = 5;
    if($array["FAIL_COUNT"] > $FAIL_LIMIT){ 
    // 메세지 출력 후 이전 페이지로 이동
    echo "
        <script type=\"text/javascript\">
            alert(\"로그인 실패 $FAIL_LIMIT 회 초과하여 로그인할 수 없습니다.\");
            history.back();
        </script>
    ";
    exit;
    }

    // $g_idx = $array["idx"];
    // $g_u_name = $array["u_name"];
    // $g_u_id = $array["u_id"];
    $g_pwd = $array["PASSWORD"]; // DB추출한 값
    $TEMP = $PASSWORD; // 입력 받은 값
    $PASSWORD = hash('sha512', $TEMP); // 넘어온 값 sha512 암호화
    // 사용자가 입력한 비밀번호와 DB에 저장된 비밀번호가 일치하지 않는다면
    if($PASSWORD != $g_pwd){
        $FAIL_COUNT=$array["FAIL_COUNT"]+1;
        $query = "update USER_INFO set FAIL_COUNT='$FAIL_COUNT' where USERID='$USERID'; ";
        mysqli_query($conn, $query);
        echo "
            <script type=\"text/javascript\">
                alert(\"아이디 혹은 비밀번호가 일치하지 않습니다.\");
                history.back();
            </script>
        ";
    exit;
    }else{ // 비밀번호가 일치한다면
        // 세션 변수 생성
        // $_SESSION["세션변수명"] = 저장할 값;
        
        $_SESSION["s_idx"]=$array["ATTR"];        // ATTR : 사용자 권한
        $_SESSION["s_name"]=$array["USERNAME"];
        #$_SESSION["s_id"]=$array["USERID"];
        
        $timestamp=time();
        $USERIP=$_SERVER['REMOTE_ADDR'];
        $USERID=$array["USERID"];
        // 로그인 시 로그 생성
        $query = "insert into LOGIN_HISTORY (USERID, USERIP, LOGINDATE) VALUES ('$USERID','$USERIP','$timestamp')";
        mysqli_query($conn, $query);
        // 로그인 시 FAIL_COUNT 0 으로 초기화
        $query = "update USER_INFO set FAIL_COUNT=0 where USERID='$USERID'; ";
        mysqli_query($conn, $query);
        // echo "idx : ".$_SESSION["s_idx"]." / "."NAME : ".$_SESSION["s_name"]." / "."ID : ".$_SESSION["s_id"];
        /* DB 연결 종료 */
        #mysqli_close($conn);
        /* 페이지 이동 */
        echo "
            <script type=\"text/javascript\">
                location.href = \"../index_page.php\";
            </script>
        ";
    };
};
?>