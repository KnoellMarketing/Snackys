{if $bBoxenFilterNach}
    {if $NaviFilter->SuchFilter|@count > 0 && !$NaviFilter->Suche->kSuchanfrage}
        <section class="panel panel-default box box-filter-price" id="sidebox{$oBox->kBox}">
            <div class="panel-heading">
                <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
					{lang key="searchFilter" section="global"}
					{include file="snippets/careticon.tpl"}
				</span>
            </div>
            <div class="box-body">
                {include file='snippets/filter/search.tpl'}
            </div>
        </section>
    {/if}
{/if}