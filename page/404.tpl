<div id="page-not-found" class="dpflex-a-center dpflex-j-center text-center" 
	 style="background: url('{if !empty($snackyConfig.error404BG)}{$snackyConfig.error404BG}{else}/templates/snackys/img/background/background-404.jpg{/if}')no-repeat center center/cover">
    {if $bSeiteNichtGefunden}
		<div class="background-image"></div>
	<div class="content">
	<h1>404</h1>
        <h2>
            {lang key="pagenotfound" section="breadcrumb"}
        </h2>
		<a href="index.php" class="btn btn-primary btn-lg">{lang key="goToStartpage" section="checkout"}</a>
	
	</div>
    {/if}
</div>