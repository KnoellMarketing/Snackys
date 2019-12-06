{if $bBoxenFilterNach && ($BoxenEinstellungen.navigationsfilter.bewertungsfilter_benutzen === 'box' || $BoxenEinstellungen.navigationsfilter.bewertungsfilter_benutzen === 'content')}
    {if $Suchergebnisse->Bewertung|@count > 0}
        <section class="panel panel-default box box-filter-reviews" id="sidebox{$oBox->kBox}">
            <div class="panel-heading">
                <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
					{lang key="Votes" section="global"}
					{include file="snippets/careticon.tpl"}
				</span>
            </div>
            <div class="box-body">
                {include file='snippets/filter/review.tpl' class="nav nav-list"}
            </div>
        </section>
    {/if}
{/if}