{if $BoxenEinstellungen.navigationsfilter.merkmalfilter_verwenden === 'box' || $BoxenEinstellungen.navigationsfilter.merkmalfilter_verwenden === 'content'}
    {if isset($Suchergebnisse) && $Suchergebnisse->MerkmalFilter|@count > 0}
        {foreach name=merkmalfilter from=$Suchergebnisse->MerkmalFilter item=Merkmal}
            {assign var=kMerkmal value=$Merkmal->kMerkmal}
            <section class="panel panel-default box box-f-cr pr">
                {if ($Merkmal->cTyp === 'SELECTBOX') && $Merkmal->oMerkmalWerte_arr|@count > 1}
                    <div class="panel-heading dropdown">
                        <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
                            {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'T' && !empty($Merkmal->cBildpfadKlein) && $Merkmal->cBildpfadKlein !== $BILD_KEIN_MERKMALBILD_VORHANDEN && !$device->isMobile()}
								<span class="dpflex-a-center">
								<span class="img-ct icon">
									<img src="{$snackyConfig.preloadImage}" data-src="{$Merkmal->cBildpfadKlein}" alt="{$Merkmal->cName}" class="vmiddle" />
								</span>
                            {/if}
                            {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'B'}
                                {$Merkmal->cName}
                            {/if}
							{if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'T' && !empty($Merkmal->cBildpfadKlein) && $Merkmal->cBildpfadKlein !== $BILD_KEIN_MERKMALBILD_VORHANDEN && !$device->isMobile()}
								</span>
							{/if}
							{include file="snippets/careticon.tpl"}
                        </span>
                    </div>
                    <div class="box-body dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                             {lang key="selectFilter" section="global"}&nbsp; 
                        </a>
                        {include file='snippets/filter/characteristic.tpl' Merkmal=$Merkmal}
                    </div>
                {else}
                    <div class="panel-heading">
                        <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
                        {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'T' && !empty($Merkmal->cBildpfadKlein) && $Merkmal->cBildpfadKlein !== $BILD_KEIN_MERKMALBILD_VORHANDEN && !$device->isMobile()}
							<span class="dpflex-a-center">
							<span class="img-ct icon">
                           		<img src="{$snackyConfig.preloadImage}" data-src="{$Merkmal->cBildpfadKlein}" alt="{$Merkmal->cName}" class="vmiddle" />
							</span>
                        {/if}
                        {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'B'}
                            {$Merkmal->cName}
                        {/if}
						{if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'T' && !empty($Merkmal->cBildpfadKlein) && $Merkmal->cBildpfadKlein !== $BILD_KEIN_MERKMALBILD_VORHANDEN && !$device->isMobile()}
							</span>
						{/if}
						{include file="snippets/careticon.tpl"}
                        </span>
                    </div>
                    <div class="box-body">
                        {include file='snippets/filter/characteristic.tpl' Merkmal=$Merkmal}
                    </div>
                {/if}
            </section>
        {/foreach}
    {/if}
{/if}