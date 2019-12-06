{if isset($linkgroupIdentifier)}
{strip}
    {get_navigation linkgroupIdentifier=$linkgroupIdentifier assign='links'}
    {assign var=checkLinkParents value=false}
    {if !empty($links)}
        {if isset($Link->kLink) && (int)$Link->kLink > 0}
            {assign var='activeId' value=$Link->kLink}
        {elseif Shop::$kLink > 0}
            {assign var='activeId' value=Shop::$kLink}
            {assign var='Link' value=LinkHelper::getInstance()->getPageLink($activeId)}
        {/if}
        {if !isset($activeParents) && (isset($Link))}
            {assign var='activeParents' value=LinkHelper::getInstance()->getParentsArray($activeId)}
            {assign var=checkLinkParents value=true}
        {/if}
        {foreach $links as $li}
            <li class="{if !empty($li->oSub_arr) && isset($dropdownSupport)}mgm-fw dropdown-style{/if}{if $li->bIsActive || ($checkLinkParents === true && isset($activeParents) && in_array($li->kLink, $activeParents))} active{/if}" id="mm-dropdown{$li@iteration}">
                {if isset($li->cLocalizedName[$smarty.session.cISOSprache])}
                    <a href="{$li->cURLFull}" class="mm-mainlink"{if $li->cNoFollow === 'Y'} rel="nofollow"{/if}{if !empty($li->cTitle)} title="{$li->cTitle}"{/if}>
                        {$li->cLocalizedName|trans}
                        {if !empty($li->oSub_arr) && isset($dropdownSupport)} <span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}{/if}
                    </a>
                    {if !empty($li->oSub_arr)}
                        <ul class="{if isset($dropdownSupport)}dropdown-menu keepopen{else}submenu list-unstyled{/if}">
                            {foreach name='subs' from=$li->oSub_arr item='subli'}
                                {if !empty($subli->cLocalizedName)}
                                <li{if $subli->bIsActive || ($checkLinkParents === true && isset($activeParents) && in_array($subli->kLink, $activeParents))} class="active"{/if}>
                                    <a href="{$subli->cURLFull}" class="dropdown-link defaultlink"{if $subli->cNoFollow === 'Y'} rel="nofollow"{/if}{if !empty($subli->cTitle)} title="{$subli->cTitle}"{/if}>
                                        <span class="notextov">{$subli->cLocalizedName|trans}</span>
                                    </a>
                                </li>
                                {/if}
                            {/foreach}
                        </ul>
                    {/if}
                {/if}
            </li>
        {/foreach}
    {/if}
{/strip}
{/if}