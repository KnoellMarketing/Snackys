{assign var="tDir" value=$currentTemplateDir}
{if isset($parentTemplateDir)}
	{if !file_exists('{$currentTemplateDir}/layout/footer.tpl')}
		{assign var="tDir" value=$parentTemplateDir}
	{/if}
{/if}
{extends file="{$tDir}/layout/footer.tpl"}

{block name="footer-sidepanel-left"}
{/block}

{block name="footer-boxes"}
   
{/block}

{block name="footer-additional"}
{/block}{* /footer-additional *}

{block name="main-wrapper-closingtag"}
</div> {* /mainwrapper *}{/block}

{block name="footer-language"}
{/block}

{block name="aside"}{/block}
            
{block name="footer-currency"}{/block}


{block name="footer-copyright"}
{/block}