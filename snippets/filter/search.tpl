<ul class="filter_state nav nav-list blanklist">
    {foreach name=suchfilter from=$NaviFilter->SuchFilter item=oSuchFilter}
        {assign var=kSuchanfrage value=$oSuchFilter->kSuchanfrage}
        <li>
            <a rel="nofollow" href="{$NaviFilter->URL->cAlleSuchFilter[$kSuchanfrage]}" class="active">
                <span class="badge">{$oSuchFilter->nAnzahl}</span>
                <span class="value">
                    {$oSuchFilter->cSuche}
                </span>
            </a>
        </li>
    {/foreach}
</ul>