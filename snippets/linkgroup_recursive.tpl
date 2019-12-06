{if isset($linkgroupIdentifier) && (!isset($i) || isset($limit) && $i < $limit)}
{strip}
    {if !isset($i)}
        {assign var='i' value=0}
    {/if}
    {if !isset($limit)}
        {assign var='limit' value=3}
    {/if}
    {if !isset($activeId)}
        {assign var='activeId' value='0'}
        {if isset($Link) && intval($Link->kLink) > 0}
            {assign var='activeId' value=$Link->kLink}
        {elseif Shop::$kLink > 0}
            {assign var='activeId' value=Shop::$kLink}
            {assign var='Link' value=LinkHelper::getInstance()->getPageLink($activeId)}
        {/if}
    {/if}
    {if !isset($activeParents)}
        {assign var='activeParents' value=LinkHelper::getInstance()->getParentsArray($activeId)}
    {/if}
    {if !isset($links)}
        {get_navigation linkgroupIdentifier=$linkgroupIdentifier assign='links'}
    {/if}
    {if !empty($links)}
        {foreach name='links' from=$links item='li'}
            {assign var='hasItems' value=false}
            {if isset($li->oSub_arr) && $li->oSub_arr && (($i+1) < $limit)}
                {assign var='hasItems' value=true}
            {/if}
            {if isset($activeParents) && is_array($activeParents) && isset($activeParents[$i])}
                {assign var='activeParent' value=$activeParents[$i]}
            {/if}
            <li class="{if !empty($li->oSub_arr) && isset($dropdownSupport)}dropdown dropdown-multi{/if}{if $li->bIsActive || (isset($activeParent) && $activeParent == $li->kLink)} active{/if}">
                {if isset($li->cLocalizedName[$smarty.session.cISOSprache])}
                    <a href="{$li->cURLFull}"{if $li->cNoFollow === 'Y'} rel="nofollow"{/if}{if !empty($li->cTitle)} title="{$li->cTitle}"{/if}{if !empty($li->oSub_arr) && isset($dropdownSupport)} class="nav-sub"{/if} data-ref="{$li->kLink}">
                        {$li->cLocalizedName[$smarty.session.cISOSprache]}
                        {if !empty($li->oSub_arr) && isset($dropdownSupport)}<i class="fa fa-caret-down nav-toggle pull-right"></i>{/if}
                    </a>
                    {if $hasItems}
                        <ul class="nav">
                            {if !empty($li->oSub_arr)}
                                {include file='snippets/linkgroup_recursive.tpl' i=$i+1 links=$li->oSub_arr limit=$limit activeId=$activeId activeParents=$activeParents}
                            {else}
                                {include file='snippets/linkgroup_recursive.tpl' i=$i+1 links=array($li) limit=$limit activeId=$activeId activeParents=$activeParents}
                            {/if}
                        </ul>
                    {/if}
                {/if}
            </li>
        {/foreach}
    {/if}
{/strip}
{/if}