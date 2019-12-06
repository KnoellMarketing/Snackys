{if isset($nFullscreenTemplate) && $nFullscreenTemplate == 1}
    {include file=$cPluginTemplate}
{else}
    {block name="header"}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/header.tpl'}
        {else}
            {include file='layout/modal_header.tpl'}
        {/if}
    {/block}

	{if !isset($smarty.get.sidebar)}
		{block name="content"}
			{if !empty($Link->Sprache->cTitle)}
				<h1>{$Link->Sprache->cTitle}</h1>
			{elseif isset($bAjaxRequest) && $bAjaxRequest}
				<h1>{if !empty($Link->Sprache->cMetaTitle)}{$Link->Sprache->cMetaTitle}{else}{$Link->Sprache->cName}{/if}</h1>
			{/if}

			{if !empty($Link->Sprache->cContent) && $Link->nLinkart != $smarty.const.LINKTYP_STARTSEITE}
				{if $snackyConfig.optimize_content == "Y"}{$Link->Sprache->cContent|optimize}{else}{$Link->Sprache->cContent}{/if}
			{/if}

			{if $Link->nLinkart == $smarty.const.LINKTYP_AGB}
				<div id="tos" class="well well-sm">
					{if $AGB->cAGBContentHtml}
						{$AGB->cAGBContentHtml}
					{elseif $AGB->cAGBContentText}
						{$AGB->cAGBContentText|nl2br}
					{/if}
				</div>
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_WRB}
				<div id="revocation-instruction" class="well well-sm">
					{if $WRB->cWRBContentHtml}
						{$WRB->cWRBContentHtml}
					{elseif $WRB->cWRBContentText}
						{$WRB->cWRBContentText|nl2br}
					{/if}
				</div>
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_STARTSEITE}
				{include file='page/index.tpl'}
				{if !empty($Link->Sprache->cContent)}
					<div class="custom-content">{if $snackyConfig.optimize_content == "Y"}{$Link->Sprache->cContent|optimize}{else}{$Link->Sprache->cContent}{/if}</div>
				{/if}
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_VERSAND}
				{include file='page/shipping.tpl'}
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_TAGGING}
				{include file='page/tagging.tpl'}
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_LIVESUCHE}
				{include file='page/livesearch.tpl'}
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_HERSTELLER}
				{include file='page/manufacturers.tpl'}
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_NEWSLETTERARCHIV}
				{include file='page/newsletter_archive.tpl'}
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_SITEMAP}
				{include file='page/sitemap.tpl'}
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_GRATISGESCHENK}
				{include file='page/free_gift.tpl'}
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_PLUGIN && empty($nFullscreenTemplate)}
				{include file="$cPluginTemplate"}
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_AUSWAHLASSISTENT}
				{include file='productwizard/index.tpl'}
			{elseif $Link->nLinkart == $smarty.const.LINKTYP_404}
				{include file='page/404.tpl'}
			{/if}
		{/block}
    {/if}
	
    {block name="footer"}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/footer.tpl'}
        {else}
            {include file='layout/modal_footer.tpl'}
        {/if}
    {/block}
{/if}