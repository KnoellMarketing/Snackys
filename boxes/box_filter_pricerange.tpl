{if $bBoxenFilterNach && $BoxenEinstellungen.navigationsfilter.preisspannenfilter_benutzen === 'box'}
    {if $Suchergebnisse->Preisspanne|@count > 0}
        <section class="panel panel-default box box-filter-price" id="sidebox{$oBox->kBox}">
            <div class="panel-heading">
                <h5 class="panel-title">{lang key="rangeOfPrices" section="global"}</h5>
            </div>
            <div class="box-body">
                {include file='snippets/filter/pricerange.tpl'}
            </div>
        </section>
    {/if}
{/if}
