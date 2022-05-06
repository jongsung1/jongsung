
<?
	if(!$_SESSION["s_idx"]) { 
		// id가 없을 경우 세션 시작 
		echo "
            <script type=\"text/javascript\">
                alert(\"허가되지 않은 접근\");
                history.back();
            </script>
        ";
	}
?>