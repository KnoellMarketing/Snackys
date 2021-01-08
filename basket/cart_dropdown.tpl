{if empty($parentTemplateDir)}
	{* Workaround for IO Request *}
	{assign var="parentTemplateDir" value="templates/snackys/"}
{/if}
<span class="text-center h3 block mb-spacer mb-small">{lang key="basket" section="global"}</span>

{if !empty($hinweis)}
    {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}

    {if isset($zuletztInWarenkorbGelegterArtikel)}
        {assign var=pushedArtikel value=$zuletztInWarenkorbGelegterArtikel}
    {else}
        {assign var=pushedArtikel value=$Artikel}
    {/if}
        <div class="alert alert-success">{$pushedArtikel->cName} {lang key="productAddedToCart" section="global"}</div>
    {/if}
{/if}
    {if $smarty.session.Warenkorb->PositionenArr|@count > 0}
			<form id="cart-form-xs" method="post" action="{get_static_route id='warenkorb.php'}">
			{$jtl_token}
			<input type="hidden" name="wka" value="1" />
            {foreach name="positionen" from=$smarty.session.Warenkorb->PositionenArr item=oPosition}
                {if !$oPosition->istKonfigKind()}
                    {if $oPosition->nPosTyp == C_WARENKORBPOS_TYP_ARTIKEL}
            			<div class="sc-item dropdown">
							<div class="dpflex-a-center">
                            <div class="cols-img">
								<span class="img-ct">
								{if $oPosition->Artikel->Bilder[0]->cPfadNormal !== $BILD_KEIN_ARTIKELBILD_VORHANDEN}
									<img src="{$snackyConfig.preloadImage}" data-src="{$oPosition->Artikel->Bilder[0]->cPfadMini}" alt="{$oPosition->cName|trans|escape:"htmlall"}">
								{else}
									<img src="{$snackyConfig.preloadImage}" data-src="gfx/keinBild.gif" alt="{$oPosition->cName|trans|escape:"htmlall"}"> 
								{/if}
								</span>
                            </div>
                            <div class="cols-name">
                                {$oPosition->nAnzahl|replace_delim}&times;
                                <a href="{$oPosition->Artikel->cURL}" title="{$oPosition->cName|trans|escape:"html"}">
                                    {$oPosition->cName|trans}
                                </a>
                            </div>
                            <div class="cols-price">
                                {if $oPosition->istKonfigVater()}
                                    <strong>{$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
                                {else}
                                    <strong>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
                                {/if}
                            </div>
                            {if $snackyConfig.editSidebasket == 2}
							<button class="editpos" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<span class="img-ct icon icon">
									<svg>
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-edit"></use>
									</svg
								</span>
							</button>
                            {/if}
							</div>
                            {if $snackyConfig.editSidebasket == 2}
							<div class="edit-item">
								{if $oPosition->istKonfigVater()}
									<div class="qty-wrapper modify">
										<a class="btn btn-default configurepos btn-xs"
											href="index.php?a={$oPosition->kArtikel}&ek={$smarty.foreach.positionen.index}">
											<span class="visible-xs visible-sm"></span>
											<span class="hidden-xs hidden-sm">{lang key="configure" section="global"}</span>
										</a>
									</div>
								{else}
									<div class="form-inline dpflex-j-end">
										<div class="input-group" role="group" id="quantity-grp{$smarty.foreach.positionen.index}">
											<input name="anzahl[{$smarty.foreach.positionen.index}]" id="quantity{$smarty.foreach.positionen.index}" class="btn-group form-control quantity text-right" size="3" value="{$oPosition->nAnzahl}" />
											{* if $oPosition->Artikel->cEinheit}
												<span class="btn-group unit input-group-addon hidden-xs">{$oPosition->Artikel->cEinheit}</span>
											{/if *}
												<button type="submit" class="btn btn-default btn-xs" title="{lang key='refresh' section='checkout'}">
													<span class="img-ct icon">
														<svg>
														  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-refresh"></use>
														</svg>
																</span>
												</button>
										</div>
									</div>
								{/if}
								<button type="submit" class="droppos btn btn-xs dpflex-a-center btn-flex btn-danger" name="dropPos" value="{$smarty.foreach.positionen.index}" title="{lang key="delete" section="global"}">
									<span class="img-ct icon op1">
										<svg class="icon-darkmode">
											<use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
										</svg
									</span>
                            	</button>
							</div>
                            {/if}
						</div>
                    {else}
            			<div class="dpflex-a-center sc-item">
							<div class="cols-img">
								<span class="img-ct">
									{if $oPosition->Artikel->Bilder[0]->cPfadNormal !== $BILD_KEIN_ARTIKELBILD_VORHANDEN && isset($oPosition->Artikel->Bilder[0]->cPfadNormal)}
										<img src="{$snackyConfig.preloadImage}" data-src="{$oPosition->Artikel->Bilder[0]->cPfadMini}" alt="{$oPosition->cName|trans|escape:"htmlall"}">
									{else}
										<img src="{$snackyConfig.preloadImage}" data-src="gfx/keinBild.gif" alt="{$oPosition->cName|trans|escape:"htmlall"}"> 
									{/if}
								</span>
							</div>
                            <div class="cols-name" colspan="2">
                                {$oPosition->nAnzahl|replace_delim}&times;&nbsp;{$oPosition->cName|trans|escape:"htmlall"}
                            </div>
                            <div class="cols-price">
                                <strong>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
                            </div>
                        </div>
                    {/if}
                {/if}
            {/foreach}
			</form>
			<div class="sc-sum">
				{if $NettoPreise}
					<div class="text-muted total total-net dpflex-j-between cols-sums">
						<div colspan="3">{lang key="totalSum"} ({lang key="net" section="global"}):</div>
						<div class="text-nowrap text-right"><span>{$WarensummeLocalized[$NettoPreise]}</span></div>
					</div>
				{/if}
				{if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && isset($Steuerpositionen) && $Steuerpositionen|@count > 0}
					{foreach name=steuerpositionen from=$Steuerpositionen item=Steuerposition}
						<div class="text-muted tax dpflex-j-between cols-sums">
							<div colspan="3">{$Steuerposition->cName}</div>
							<div class="text-nowrap text-right">{$Steuerposition->cPreisLocalized}</div>
						</div>
					{/foreach}
				{/if}
				<div class="total dpflex-j-between sum-tt cols-sums">
					<div colspan="3">{lang key="totalSum"}:</div>
					<div class="text-nowrap text-right total"><strong>{$WarensummeLocalized[0]}</strong></div>
				</div>
			</div>
        {if !empty($WarenkorbVersandkostenfreiHinweis)}
            <p class="small text-muted">{$WarenkorbVersandkostenfreiHinweis|truncate:120:"..."}
                <a class="popup" href="{if !empty($oSpezialseiten_arr) && isset($oSpezialseiten_arr[6])}{$oSpezialseiten_arr[6]->cURL}{else}#{/if}" data-toggle="tooltip"  data-placement="bottom" title="{lang section="login" key="shippingInfo"}">
                    <i class="fa fa-info-circle"></i>
                </a>
            </p>
        {/if}
    {else}
        <div class="alert alert-info text-center">{lang section='checkout' key='emptybasket'}</div>
    {/if}
