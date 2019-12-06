{if $bBoxenFilterNach && $BoxenEinstellungen.navigationsfilter.preisspannenfilter_benutzen === 'box'}
    {if $Suchergebnisse->Preisspanne|@count > 0}
        <section class="panel panel-default box box-filter-price" id="sidebox{$oBox->kBox}">
            <div class="panel-heading">
                <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
					{lang key="rangeOfPrices" section="global"}
					{include file="snippets/careticon.tpl"}
				</span>
            </div>
            <div class="box-body">
                {include file='snippets/filter/pricerange.tpl'}
            </div>
        </section>
    {/if}
{/if}
