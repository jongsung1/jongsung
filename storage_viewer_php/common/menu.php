
<?
    $mainip = "10.0.28.13";
?>
<div class="logo"><a href="http://<?echo $mainip?>/index_page.php"><img src="./../picture/logo.PNG" alt="" border="0"></a></div>

<!-- 스토리지 매뉴 -->
<table cellpadding="0" cellspacing="1" border="0" width="650" bgcolor="#ffafaf" class="info_table">
	<thead>
		<tr>
        	<th class="info_category" width="100">
            	<A HREF="http://<?echo $mainip?>/storage/storage_info.php" >storage size</A>
            </th>
            <th class="info_category" width="70">
            	<A HREF="http://<?echo $mainip?>/storage/lustre.php" >lustre</A>
            </th>
            <th class="info_category" width="70">
            	<A HREF="http://<?echo $mainip?>/storage/lustre2.php" >lustre2</A>
            </th>
            <th class="info_category" width="70">
            	<A HREF="http://<?echo $mainip?>/storage/lustre3.php" >lustre3</A>
            </th>
            <th class="info_category" width="70">
            	<A HREF="http://<?echo $mainip?>/storage/netapp.php" >netapp</A>
            </th>
        </tr>
	</thead>
</table>
<!-- renderfarm 매뉴 -->
<table cellpadding="0" cellspacing="1" border="0" width="650" bgcolor="#ffafaf" class="info_table">
	<thead>
		<tr>
        	<th class="info_category" width="100">
            	<A HREF="http://<?echo $mainip?>/renderfarm/farm.php" >2D FARM</A>
            </th>
            <th class="info_category" width="70">
            	<A HREF="http://<?echo $mainip?>/renderfarm/cache.php" >CACHE</A>
            </th>
            <th class="info_category" width="70">
            	<A HREF="http://<?echo $mainip?>/renderfarm/env.php" >ENV</A>
            </th>
            <th class="info_category" width="70">
            	<A HREF="http://<?echo $mainip?>/renderfarm/hpfx.php" >FX</A>
            </th>
			<th class="info_category" width="70">
            	<A HREF="http://<?echo $mainip?>/renderfarm/hprender.php" >Lookdev</A>
            </th>
            <th class="info_category" width="70">
            	<A HREF="http://<?echo $mainip?>/renderfarm/dpx.php" >scan</A>
            </th>
        </tr>
	</thead>
</table>
<table cellpadding="0" cellspacing="1" border="0" width="650" bgcolor="#ffafaf" class="info_table">
	<thead>
		<tr>
            <th class="info_category" width="70">
                <A HREF="http://<?echo $mainip?>/user/user_info.php" >user info</A>
            </th>
			<th class="info_category" width="70">
                <A HREF="http://<?echo $mainip?>/user/user_device_info.php" >user device</A>
            </th>
        </tr>
	</thead>
</table>
<?
    if($_SESSION["s_idx"] == 9){
?>
<table cellpadding="0" cellspacing="1" border="0" width="650" bgcolor="#ffafaf" class="info_table">
	<thead>
		<tr>
            <th class="info_category" width="70">
                <A HREF="http://<?echo $mainip?>/user/user_info.php" >attr test</A>
            </th>
			<th class="info_category" width="70">
                <A HREF="http://<?echo $mainip?>/user/user_device_info.php" >attr  device</A>
            </th>
        </tr>
	</thead>
</table>
<?
    }
    ?>

<li>
    <A HREF="http://<?echo $mainip?>/logout.php" >logout</A>
</li>
<script>
    setTimeout(function(){location.reload();},1800000); //30분 후 새로고침 30*60(초 환산)*1000(ms 환산)
</script>