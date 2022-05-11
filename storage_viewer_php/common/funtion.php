
<?
//// alert 후 이전 페이지로 이동
function go_back($blabla){
    echo "
        <script type=\"text/javascript\">
            alert(\"$blabla\");
            history.back();
        </script>
        ";
    exit;
}
//// alert 후 원하는 페이지로 이동
function go_target($blabla,$target){
    echo "
        <script type=\"text/javascript\">
            alert(\"$blabla\");
            location.href = \"../$target\";
        </script>
        ";
    exit;
}
/// alert 없이 이동
function go_no_memtion($target){
    echo "
        <script type=\"text/javascript\">
            location.href = \"$target\";
        </script>
        ";
    exit;
}

/// f12 콘솔 로그 생성 (Y/N 조절)
$CONSOLE_LOG = "N"; 
function console_log( $data ){
    global $CONSOLE_LOG;
    if($CONSOLE_LOG == "Y"){
        echo '<script>';
        echo 'console.log('. json_encode( $data ) .')';
        echo '</script>';
    }
}
?>