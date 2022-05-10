
<?
function go_back($blabla){
    echo "
        <script type=\"text/javascript\">
            alert(\"$blabla\");
            history.back();
        </script>
        ";
    exit;
}

function go_target($blabla,$target){
    echo "
        <script type=\"text/javascript\">
            alert(\"$blabla\");
            location.href = \"../$target\";
        </script>
        ";
    exit;
}

?>