{block name="header"}
    {include file='layout/header-maintainance.tpl'}
{/block}

{assign var="tDir" value=$currentTemplateDir}
{if isset($parentTemplateDir)}
	{if !file_exists('{$currentTemplateDir}/layout/header.tpl')}
		{assign var="tDir" value=$parentTemplateDir}
	{/if}
{/if}

{block name="content"}
    <div id="maintenance-notice" class="panel panel-info">
		<span class="topbar dpflex-a-center dpflex-j-center">{lang key="maintainance" section="global"}</span>
		<div class="row dpflex-a-center">
			<div class="col-xs-3 col-sm-5 hidden-xs">
				<div class="icon-container">
					<span class="img-ct icon icon-xl">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
						  <use xlink:href="{$tDir}img/icons/icons.svg#icon-maintenance"></use>
						</svg>
					</span>
				</div>
			</div>
			<div class="col-xs-12 col-sm-7 text-col">
				<div id="logo-wrapper">
					<div id="logo">
						{include file="layout/shoplogo.tpl"}
					</div>
				</div>
				<h1 class="h3">{lang key="beBackSoon" section="custom"}</h1>
				<p>{lang key="maintenanceModeActive" section="global"}</p>
			</div>	
		</div>
    </div>
{/block}

{block name="footer"}
    {include file='layout/footer-maintainance.tpl'}
{/block}