{strip}
{if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1 || isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1 || $Einstellungen.template.header.headerSocial == 0}
    {block name="top-bar-user-settings"}
    <ul class="list-inline">
        {block name="top-bar-user-settings-currency"}
        {if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1}
            <li class="dropdown">
                <a href="#" class="dropdown-toggle dpflex-a-center" data-toggle="dropdown" title="{lang key='selectCurrency'}">
					{$smarty.session.Waehrung->cName} <span class="caret"></span>
				</a>
                <ul class="dropdown-menu">
                {foreach from=$smarty.session.Waehrungen item=oWaehrung}
                    <li>
                        <a href="{$oWaehrung->cURL}" rel="nofollow">{$oWaehrung->cName}</a>
                    </li>
                {/foreach}
                </ul>
            </li>
        {/if}
        {/block}
        {block name="top-bar-user-settings-language"}
        {if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
			<li class="dropdown">
				<a href="#" class="dropdown-toggle dpflex-a-center" data-toggle="dropdown" itemprop="inLanguage" itemscope itemtype="http://schema.org/Language" title="{lang key='selectLang'}">
					{foreach from=$smarty.session.Sprachen item=Sprache}
						{if $Sprache->kSprache == $smarty.session.kSprache}
							<span class="lang-{$lang}" itemprop="name">{if $lang === 'ger'}{$Sprache->cNameDeutsch}{else}{$Sprache->cNameEnglisch}{/if}</span>
						{/if}
					{/foreach}
					<span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
				{foreach from=$smarty.session.Sprachen item=oSprache}
					{if $oSprache->kSprache != $smarty.session.kSprache}
						<li>
							<a href="{if isset($oSprache->cURLFull)}{$oSprache->cURLFull}{else}{$oSprache->cURL}{/if}" rel="nofollow">
								<span>{if $lang === 'ger'}{$oSprache->cNameDeutsch}{else}{$oSprache->cNameEnglisch}{/if}</span>
							</a>
						</li>
					{/if}
					{/foreach}
				</ul>
			</li>
        {* /language-dropdown *}
        {/if}
        {/block}
		{if $Einstellungen.template.header.headerSocial == 0 && $Einstellungen.template.header.headerType != 2  && $Einstellungen.template.header.headerType != 3}
		<li>
			{include file="snippets/socialprofiles.tpl"}
		</li>
		{/if}
    </ul>{* user-settings *}
    {/block}
{/if}
{if isset($linkgroups->Kopf) && $linkgroups->Kopf}
<ul class="list-inline">
    {block name="top-bar-cms-pages"}
        {foreach name=headlinks from=$linkgroups->Kopf->Links item=Link}
            {if $Link->cLocalizedName|has_trans}
                <li{if isset($Link->aktiv) && $Link->aktiv == 1} class="active"{/if}>
                    <a class="defaultlink" href="{$Link->URL}"{if $Link->cNoFollow == 'Y'} rel="nofollow"{/if} title="{$Link->cLocalizedName|trans}">{$Link->cLocalizedName|trans}</a>
                </li>
            {/if}
        {/foreach}
    {/block}
</ul>
{/if}
{/strip}