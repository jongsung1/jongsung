<meta charset="UTF-8">
<?
/* 세션 실행 */
session_start();
$_SESSION["s_id"]=$_POST["USERID"];
/* 이전 페이지에서 값 가져오기 */
$USERID = $_POST["USERID"];
$PASSWORD = $_POST["PASSWORD"];
//$USERIP=$_SERVER['REMOTE_ADDR'];
$TEMP = $PASSWORD; // 입력 받은 값
$PASSWORD = hash('sha512', $TEMP); // 넘어온 값 sha512 암호화

/* DB 접속 */
include  "C:/APM_Setup/htdocs/common/dbcon.php";
include  "C:/APM_Setup/htdocs/common/funtion.php";

$password_sql = "select PASSWORD from USER_INFO where USERID='$USERID';";
$result = mysqli_query($conn, $password_sql);
$array = mysqli_fetch_array($result);

if($array["PASSWORD"] == $PASSWORD){ 
    go_back("이전 패스워드와 일치합니다.");
}else{
    $sql = "update USER_INFO set PASSWORD = '$PASSWORD',FIRST_LOGIN=0,FAIL_COUNT=0 where USERID='$USERID';";
    mysqli_query($conn, $sql);
    go_target("패스워드가 변경 되었습니다.","index.php");
}

?>