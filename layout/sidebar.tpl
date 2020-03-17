{block name="footer-sidepanel-left"}
	<aside id="sp-l" class="hidden-print col-xs-12 {if ($snackyConfig.filterPos != 1 && $nSeitenTyp === 2) || $snackyConfig.sidepanelEverywhere == 'Y'} col-md-3 col-lg-3 col-xl-2{/if}{if $snackyConfig.scrollSidebox == 'Y'} scrollBoxes{/if}{if $snackyConfig.filterOpen == 1} collapse{/if}{if !isset($smarty.get.sidebar) & $device->isMobile()} lazy{/if}{if $snackyConfig.filterPos == 1 && $snackyConfig.sidepanelEverywhere == 'N'} show-above{/if}">
		{if isset($smarty.get.sidebar) || !$device->isMobile()}
			<div class="inside">
				<div class="visible-xs visible-sm">
					<span class="block h3">{lang key="filterBy" setion="global"}</span>
					<hr class="op0">
				</div>
				
				{if $nSeitenTyp == 2}
					
                    {if $Einstellungen.navigationsfilter.allgemein_kategoriefilter_benutzen === 'Y' && (!empty($Suchergebnisse->Kategorieauswahl) && $Suchergebnisse->Kategorieauswahl|@count > 1)}
						<section class="panel panel-default box box-category">
							<div class="panel-heading">
								<span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
									{lang key="allCategories" section="global"}
									{include file="snippets/careticon.tpl"}
								</span>
							</div>
							<div class="box-body">
								<ul class="nav nav-list blanklist">								
									{include file='snippets/filter/category.tpl' class="dropdown-menu"}
								</ul>
							</div>
						</section>
                    {/if}
				
					{if $Einstellungen.navigationsfilter.allgemein_herstellerfilter_benutzen === 'Y' &&
						!isset($oExtendedJTLSearchResponse) &&
						(!empty($Suchergebnisse->Herstellerauswahl) && $Suchergebnisse->Herstellerauswahl|@count > 1)}
						<section class="panel panel-default box box-manufacturers">
							<div class="panel-heading">
								<span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
									{lang key="manufacturers" section="global"}
									{include file="snippets/careticon.tpl"}
								</span>
							</div>
							<div class="box-body">
								<ul class="nav nav-list blanklist">								
									{foreach name=herstellerauswahl from=$Suchergebnisse->Herstellerauswahl item=Hersteller}
										<li>
											<a rel="nofollow" href="{$Hersteller->cURL}">
												<span class="badge pull-right">{if !isset($nMaxAnzahlArtikel) || !$nMaxAnzahlArtikel}{$Hersteller->nAnzahl}{/if}</span>
												<span class="value">
													{$Hersteller->cName|escape:'html'}
												</span>
											</a>
										</li>
									{/foreach}
								</ul>
							</div>
						</section>
					{/if}

					{if $Einstellungen.navigationsfilter.merkmalfilter_verwenden === 'content' && $Suchergebnisse->MerkmalFilter|@count > 0 && $Suchergebnisse->Artikel->elemente|@count > 0}
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
                    {if !empty($Suchergebnisse->Suchspecialauswahl)}
						<section class="panel panel-default box box-filter-special">
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
                    {if $Einstellungen.navigationsfilter.preisspannenfilter_benutzen === 'content' && (empty($NaviFilter->PreisspannenFilter) && !empty($Suchergebnisse->Preisspanne))}
						<section class="panel panel-default box box-filter-price">
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
                    {elseif isset($NaviFilter->PreisspannenFilter) && $NaviFilter->PreisspannenFilter->fBis > 0}
                        <input type="hidden" name="pf" value="{$NaviFilter->PreisspannenFilter->cWert}">
                    {/if}

                    {if $Einstellungen.navigationsfilter.bewertungsfilter_benutzen === 'content' && (empty($NaviFilter->BewertungFilter) && !empty($Suchergebnisse->Bewertung))}
					<section class="panel panel-default box box-filter-reviews">
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
                    {elseif isset($NaviFilter->BewertungFilter) && $NaviFilter->BewertungFilter->nSterne > 0}
                        <input type="hidden" name="bf" value="{$NaviFilter->BewertungFilter->nSterne}">
                    {/if}
				{/if}
				
				{block name="footer-sidepanel-left-content"}
					{$boxes.left}
				{/block}
			</div>
			<div class="visible-xs visible-sm overlay-bg"></div>
			<div class="visible-xs visible-sm close-sidebar close-btn"></div>
		{/if}
	</aside>
{/block}