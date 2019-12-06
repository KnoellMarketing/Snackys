{* desktop navigation (> screen-min-sm) *}
{strip}
<div id="fullscreen-nav">
	{block name="category-nav-megamenu"}
	<div class="inside">
		<strong class="h3 mm-title hidden-xs">{lang key="menu" section="custom"}</strong>
		<ul class="nav navbar-nav force-float">
			{include file='snippets/categories_mega.tpl'}
		</ul>
		{if $Einstellungen.template.header.headerSocial == 0}
			{include file="snippets/socialprofiles.tpl"}
		{/if}
	</div>
	{/block}
</div>
{/strip}