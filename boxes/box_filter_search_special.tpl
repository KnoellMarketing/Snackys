{* if $bBoxenFilterNach && $Einstellungen.navigationsfilter.allgemein_suchspecialfilter_benutzen === 'Y'}
    {if !empty($Suchergebnisse->Suchspecialauswahl) || !empty($NaviFilter->SuchspecialFilter)}
        <section class="panel panel-default box box-filter-special" id="sidebox{$oBox->kBox}">
            <div class="panel-heading">
                <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
					{lang key="specificProducts" section="global"}
					{include file="snippets/careticon.tpl"}
				</span>
            </div>
            <div class="box-body">
                {include file='snippets/filter/special.tpl'}
                {if !empty($NaviFilter->SuchspecialFilter->cName)}
                    <ul class="{if isset($class)}{$class}{else}nav nav-list{/if} blanklist">
                        <li>
                            <a href="{$NaviFilter->URL->cAlleSuchspecials}" rel="nofollow" class="active">
                                <span class="value">
                                    {$NaviFilter->SuchspecialFilter->cName}
                                </span>
                            </a>
                        </li>
                    </ul>
                {/if}
            </div>
        </section>
    {/if}
{/if *}