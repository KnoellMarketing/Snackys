{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
	{if $step === 'news_uebersicht'}
		{include file='blog/overview.tpl'}
	{elseif $step === 'news_monatsuebersicht'}
		{include file='blog/overview.tpl'}
	{elseif $step === 'news_kategorieuebersicht'}
		{include file='blog/overview.tpl'}
	{elseif $step === 'news_detailansicht'}
		{include file='blog/details.tpl'}
	{/if}
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}