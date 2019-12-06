{* desktop navigation (> screen-min-sm) *}
{strip}
<div class="megamenu mw-container{if isset($Einstellungen.template.megamenu.show_category_images) && $Einstellungen.template.megamenu.show_category_images !== 'N'} has-images{/if}{if $Einstellungen.template.header.headerType == 4 || $Einstellungen.template.header.headerType == 4.5 || $Einstellungen.template.header.headerType == 6} fullscreen-menu{/if}"{if $Einstellungen.template.megamenu.megaStyle == 1 && $Einstellungen.template.header.headerType != 4 && $Einstellungen.template.header.headerType != 4.5 && $Einstellungen.template.header.headerType != 6} id="mm-dropdown"{/if}>
	{block name="category-nav-megamenu"}
	<div class="hidden-sm hidden-md hidden-lg menu-title dpflex-a-center dpflex-j-between nowrap">
		<span class="m0 notextov block h3">{lang key="menu" section="custom"}</span>
		<button class="close-btn"></button>
	</div>
		<ul class="dpflex-a-center dpflex-j-center blanklist dpflex-wrap">
			{if $Einstellungen.template.header.headerType == 4 || $Einstellungen.template.header.headerType == 4.5 || $Einstellungen.template.header.headerType == 6}
				<div class="dpflex-a-center dpflex-j-between nowrap fullscreen-title">
					<span class="m0 notextov block h3">{lang key="menu" section="custom"}</span>
					<button class="close-btn"></button>
				</div>
			{/if}
			{if $Einstellungen.template.megamenu.megaStyle == 0 || $Einstellungen.template.header.headerType == 4 || $Einstellungen.template.header.headerType == 4.5 || $Einstellungen.template.header.headerType == 6} 
				{include file='snippets/categories_mega.tpl'}
			{elseif $Einstellungen.template.megamenu.megaStyle == 1}
				{include file='snippets/categories_dropdown.tpl'}
			{/if}
		</ul>
	{/block}
</div>
{/strip}