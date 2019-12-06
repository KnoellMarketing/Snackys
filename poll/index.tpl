{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
    {if $step === 'umfrage_uebersicht'}
        {include file='poll/overview.tpl'}
    {elseif $step === 'umfrage_durchfuehren'}
        {include file='poll/progress.tpl'}
    {elseif $step === 'umfrage_ergebnis'}
        {include file='poll/result.tpl'}
    {/if}
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}