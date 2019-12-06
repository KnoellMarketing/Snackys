{if $bBoxenFilterNach}
    {if !empty($Suchergebnisse->Tags)}
        <section class="panel panel-default box box-filter-tag" id="sidebox{$oBox->kBox}">
            <div class="panel-heading">
                <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
					{lang key="tagFilter" section="global"}
					{include file="snippets/careticon.tpl"}
				</span>
			</div>
            <div class="box-body">
                <ul class="nav nav-list blanklist">
                 {foreach name=tagfilter from=$Suchergebnisse->Tags item=oTag}
                     {if isset($NaviFilter->TagFilter[0]->kTag) && $NaviFilter->TagFilter[0]->kTag == $oTag->kTag}
                         <li>
                             <a rel="nofollow" href="{$NaviFilter->URL->cAlleTags}" class="active">
                                 <span class="value">
                                     {$oTag->cName}
                                     <span class="badge pull-right">{$oTag->nAnzahl}</span>
                                 </span>
                             </a>
                         </li>
                     {else}
                         <li>
                             <a rel="nofollow" href="{$oTag->cURL}" >
                                 <span class="value">
                                     {$oTag->cName}
                                     <span class="badge pull-right">{$oTag->nAnzahl}</span>
                                 </span>
                             </a>
                         </li>
                     {/if}
                 {/foreach}
                </ul>
            </div>
        </section>
    {/if}
{/if}