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
            <li class="{if !empty($li->oSub_arr) && isset($dropdownSupport)}megamenu-fw{/if}{if $li->bIsActive || ($checkLinkParents === true && isset($activeParents) && in_array($li->kLink, $activeParents))} active{/if}{if $tplscope === 'megamenu' && !empty($li->oSub_arr)} bs-hover-enabled{/if}">
                {if isset($li->cLocalizedName[$smarty.session.cISOSprache])}
                    <a href="{$li->cURLFull}"{if $li->cNoFollow === 'Y'} rel="nofollow"{/if}{if !empty($li->cTitle)} title="{$li->cTitle}"{/if} class="dropdown-toggle-mmenu" data-toggle="dropdown" data-hover="dropdown">
                        {$li->cLocalizedName|trans}
                        {if !empty($li->oSub_arr) && isset($dropdownSupport)} <span class="css-arrow css-arrow-right"></span><span class="fa-caret-down visible-xs"></span>{/if}
                    </a>
                    {if !empty($li->oSub_arr)}
                        <ul class="mm-fullscreen">
							<li>
										<a class="category-title block" href="{$li->cURLFull}"{if $li->cNoFollow === 'Y'} rel="nofollow"{/if}{if !empty($li->cTitle)} title="{$li->cTitle}"{/if}>
											{$li->cLocalizedName|trans}
										</a>
									<ul class="lg-list">
                            {foreach name='subs' from=$li->oSub_arr item='subli'}
                                {if !empty($subli->cLocalizedName)}
                                <li{if $subli->bIsActive || ($checkLinkParents === true && isset($activeParents) && in_array($subli->kLink, $activeParents))} class="active"{/if}>
                                    <a href="{$subli->cURLFull}"{if $subli->cNoFollow === 'Y'} rel="nofollow"{/if}{if !empty($subli->cTitle)} title="{$subli->cTitle}"{/if}>
                                        {$subli->cLocalizedName|trans}
                                    </a>
                                </li>
                                {/if}
                            {/foreach}
									</ul>
							</li>
                        </ul>
                    {/if}
                {/if}
            </li>
        {/foreach}
    {/if}
{/strip}
{/if}