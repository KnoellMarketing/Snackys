{if $BoxenEinstellungen.navigationsfilter.merkmalfilter_verwenden === 'box' || $BoxenEinstellungen.navigationsfilter.merkmalfilter_verwenden === 'content'}
    {if isset($Suchergebnisse) && $Suchergebnisse->MerkmalFilter|@count > 0}
        {foreach name=merkmalfilter from=$Suchergebnisse->MerkmalFilter item=Merkmal}
            {assign var=kMerkmal value=$Merkmal->kMerkmal}
            <section class="panel panel-default box box-filter-characteristics preload">
                {if ($Merkmal->cTyp === 'SELECTBOX') && $Merkmal->oMerkmalWerte_arr|@count > 1}
                    <div class="panel-heading dropdown">
                        <h5 class="panel-title">
                            {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'T' && !empty($Merkmal->cBildpfadKlein) && $Merkmal->cBildpfadKlein !== $BILD_KEIN_MERKMALBILD_VORHANDEN}
								<span class="image-content icon">
									<img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$Merkmal->cBildpfadKlein}" alt="" class="vmiddle" />
								</span>
                            {/if}
                            {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'B'}
                                {$Merkmal->cName}
                            {/if}
                        </h5>
                    </div>
                    <div class="box-body dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                             {lang key="selectFilter" section="global"}&nbsp; 
                        </a>
                        {include file='snippets/filter/characteristic.tpl' Merkmal=$Merkmal}
                    </div>
                {else}
                    <div class="panel-heading">
                        <h5 class="panel-title">
                        {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'T' && !empty($Merkmal->cBildpfadKlein) && $Merkmal->cBildpfadKlein !== $BILD_KEIN_MERKMALBILD_VORHANDEN}
							<span class="image-content icon">
                           		<img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$Merkmal->cBildpfadKlein}" alt="" class="vmiddle" />
							</span>
                        {/if}
                        {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'B'}
                            {$Merkmal->cName}
                        {/if}
                        </h5>
                    </div>
                    <div class="box-body">
                        {include file='snippets/filter/characteristic.tpl' Merkmal=$Merkmal}
                    </div>
                {/if}
            </section>
        {/foreach}
    {/if}
{/if}