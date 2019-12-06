{if $bBoxenFilterNach && ($BoxenEinstellungen.navigationsfilter.bewertungsfilter_benutzen === 'box' || $BoxenEinstellungen.navigationsfilter.bewertungsfilter_benutzen === 'content')}
    {if $Suchergebnisse->Bewertung|@count > 0}
        <section class="panel panel-default box box-filter-reviews" id="sidebox{$oBox->kBox}">
            <div class="panel-heading">
                <h5 class="panel-title">{lang key="Votes" section="global"}</h5>
            </div>
            <div class="box-body">
                {include file='snippets/filter/review.tpl' class="nav nav-list"}
            </div>
        </section>
    {/if}
{/if}