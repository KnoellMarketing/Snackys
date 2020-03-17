{if $smarty.session.Kundengruppe->darfPreiseSehen}
    <div class="price_wrapper">
    {block name="price-wrapper"}
    {* --- Preis auf Anfrage? --- *}
    {if $Artikel->Preise->fVKNetto == 0 && $Artikel->bHasKonfig}
        <span class="price_label price_as_configured small">{lang key="priceAsConfigured" section="productDetails"}</span>
    {elseif $Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
        <span class="price_label price_on_application small">{lang key="priceOnApplication" section="global"}</span>
    {else}
		<div class="price-row">
        {if ($Artikel->nVariationsAufpreisVorhanden == 1 || $Artikel->bHasKonfig) && $Artikel->kVaterArtikel == 0}
            <span class="price_label pricestarting small">{lang key="priceStarting" section="global"} </span>
        {elseif $Artikel->Preise->rabatt>0}
			{if $snackyConfig.oldPricePlace === '0'}
            	<span class="price_label nowonly small">{lang key="nowOnly" section="global"} </span>
			{elseif $snackyConfig.oldPricePlace === '1' && ($Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 1 || $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 2)}
            	<span class="price_label nowonly small">{lang key="nowOnly" section="global"} </span>
			{/if}
        {else}
            {*<span class="price_label only small">{lang key="only" section="global"} </span>*}
        {/if}
        {if !empty($price_image)}
            <span class="price_img">{$price_image}</span>
        {else}
            <strong class="price text-nowrap{if isset($Artikel->Preise->Sonderpreis_aktiv) && $Artikel->Preise->Sonderpreis_aktiv} special-price{/if}">
				{if $tplscope === 'detail' && $snackyConfig.oldPricePlace === '1'}
					{if $Artikel->Preise->Sonderpreis_aktiv && $Einstellungen.artikeldetails.artikeldetails_sonderpreisanzeige == 2}
						<span class="instead-of old-price">
							<del class="value">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
						</span>
					{elseif !$Artikel->Preise->Sonderpreis_aktiv && $Artikel->Preise->rabatt > 0}
						{if $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 3 || $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 4}
							<span class="instead-of old-price">
								<del class="value text-nowrap">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
							</span>
						{/if}
					{/if}
					{* if $Einstellungen.artikeldetails.artikeldetails_uvp_anzeigen === 'Y' && $Artikel->fUVP > 0}
						<span class="instead-of old-price">
							<del class="value text-nowrap">{$Artikel->cUVPLocalized}</del>
						</span>
					{/if *}
				{/if}
				{if $tplscope !== 'detail' && $snackyConfig.oldPricePlace === '1'}
					{if $Artikel->Preise->Sonderpreis_aktiv && isset($Einstellungen.artikeluebersicht) && $Einstellungen.artikeluebersicht.artikeluebersicht_sonderpreisanzeige == 2}
						<span class="instead-of old-price">
							<del class="value">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
						</span>
					{elseif !$Artikel->Preise->Sonderpreis_aktiv && $Artikel->Preise->rabatt > 0 && isset($Einstellungen.artikeluebersicht)}
						{if $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 3 || $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 4}
							<span class="instead-of old-price"> 
								<del class="value text-nowrap">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
							</span>
						{/if}
					{/if}
				{/if}
                <span>{$Artikel->Preise->cVKLocalized[$NettoPreise]}</span>{if $tplscope !== 'detail'} <span class="footnote-reference">*</span>{/if}
            </strong>
        {/if}
		</div>
        {if $tplscope === 'detail'}
            {block name="price-snippets"}
                <meta itemprop="price" content="{if $NettoPreise==1}{$Artikel->Preise->fVKNetto}{else}{$Artikel->Preise->fVKBrutto}{/if}">
                <meta itemprop="priceCurrency" content="{$smarty.session.Waehrung->cName}">
            {/block}
            <div class="price-note">
                {if $Artikel->cEinheit && ($Artikel->fMindestbestellmenge > 1 || $Artikel->fAbnahmeintervall > 1)}
                    <span class="price_label per_unit"> {lang key="vpePer" section="global"} 1 {$Artikel->cEinheit}</span>
                {/if}
                
                {* Grundpreis *}
                {if !empty($Artikel->cLocalizedVPE)}
                    {block name="detail-base-price"}
                        <div class="base-price text-nowrap">
                            <span class="value">{$Artikel->cLocalizedVPE[$NettoPreise]}</span>
                        </div>
                    {/block}
                {/if}
                
                {block name="detail-vat-info"}
                    <p class="vat_info text-muted top5">
                        {include file='snippets/shipping_tax_info.tpl' taxdata=$Artikel->taxData}
                    </p>
                {/block}

                {if $Artikel->oPreisradar}
                    <div class="priceradar">
                        {lang key="youSave" section="productDetails"} 
                        <span class="value">{$Artikel->oPreisradar->fDiffLocalized[$NettoPreise]}
                            ({$Artikel->oPreisradar->fProzentDiff} %)
                        </span>
                    </div>
                {/if}
                
                {if $Artikel->Preise->Sonderpreis_aktiv && $Einstellungen.artikeldetails.artikeldetails_sonderpreisanzeige == 2 && $snackyConfig.oldPricePlace !== '1'}
                    <div class="instead_of old_price">{lang key="oldPrice" section="global"}:
                        <del class="value">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                    </div>
                {elseif !$Artikel->Preise->Sonderpreis_aktiv && $Artikel->Preise->rabatt > 0}
                    {if ($Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 3 || $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 4) && $snackyConfig.oldPricePlace !== '1'}
                        <div class="old_price">{lang key="oldPrice" section="global"}:
                            <del class="value text-nowrap">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                        </div>
                    {/if}
                    {if $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 2 || $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 4}
                        <div class="discount">{lang key="discount" section="global"}:
                            <span class="value text-nowrap">{$Artikel->Preise->rabatt}%</span>
                        </div>
                    {/if}
                {/if}

                {if $Einstellungen.artikeldetails.artikeldetails_uvp_anzeigen === 'Y' && $Artikel->fUVP > 0}
					{* if $snackyConfig.oldPricePlace !== '1' *}
						<div class="suggested-price">
							<abbr title="{lang key="suggestedPriceExpl" section="productDetails"}">{lang key="suggestedPrice" section="productDetails"}</abbr>:
							<span class="value text-nowrap">{$Artikel->cUVPLocalized}</span>
						</div>
					{* /if *}
                    {* Preisersparnis zur UVP anzeigen? *}
                    {if isset($Artikel->SieSparenX) && $Artikel->SieSparenX->anzeigen == 1 && $Artikel->SieSparenX->nProzent > 0 && !$NettoPreise && $Artikel->taxData['tax'] > 0}
                        <div class="yousave">({lang key="youSave" section="productDetails"}
                            <span class="percent">{$Artikel->SieSparenX->nProzent}%</span>, {lang key="thatIs" section="productDetails"}
                            <span class="value text-nowrap">{$Artikel->SieSparenX->cLocalizedSparbetrag}</span>)
                        </div>
                    {/if}
                {/if}
                
                {* --- Staffelpreise? --- *}
                {if !empty($Artikel->staffelPreis_arr)}
                    <div class="bulk-price">
                        {block name="detail-bulk-price"}
                        <table class="table table-condensed table-hover">
                            <thead>
                                <tr>
                                    <th class="text-right">{lang key="fromDifferential" section="productOverview"}{if $Artikel->cEinheit} {$Artikel->cEinheit}{/if}</th>
                                    <th class="text-right">{lang key="pricePerUnit" section="productDetails"}</th>
                                    {if !empty($Artikel->cLocalizedVPE)}<th></th>{/if}
                                </tr>
                            </thead>
                            <tbody>
                                {foreach $Artikel->staffelPreis_arr as $bulkPrice}
                                    {if $bulkPrice.nAnzahl > 0}
                                        <tr class="bulk-price-{$bulkPrice.nAnzahl}">
                                            <td class="text-right">{$bulkPrice.nAnzahl}</td>
                                            <td class="text-right bulk-price">{$bulkPrice.cPreisLocalized[$NettoPreise]}</td>
                                            {if !empty($bulkPrice.cBasePriceLocalized)}<td class="text-muted bulk-base-price">{$bulkPrice.cBasePriceLocalized[$NettoPreise]}</td>{/if}
                                        </tr>
                                    {/if}
                                {/foreach}
                            </tbody>
                        </table>
                        {/block}
                    </div>{* /bulk-price *}
                {/if}
            </div>{* /price-note *}
        {else}{* scope productlist *}
            <div class="price-note">
                {* Grundpreis *}
                {if !empty($Artikel->cLocalizedVPE)}
                {block name="list-base-price"}
                    <div class="base_price text-nowrap">
                        <span class="value">{$Artikel->cLocalizedVPE[$NettoPreise]}</span>
                    </div>
                {/block}
                {/if}
                
                {if $Artikel->Preise->Sonderpreis_aktiv && isset($Einstellungen.artikeluebersicht) && $Einstellungen.artikeluebersicht.artikeluebersicht_sonderpreisanzeige == 2}
					{if $snackyConfig.oldPricePlace !== '1'}
                    <div class="instead-of old-price">
                        <small class="text-muted">
                            {lang key="oldPrice" section="global"}: 
                            <del class="value">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                        </small>
                    </div>
					{/if}
                {elseif !$Artikel->Preise->Sonderpreis_aktiv && $Artikel->Preise->rabatt > 0 && isset($Einstellungen.artikeluebersicht)}
                    {if ($Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 3 || $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 4) && $snackyConfig.oldPricePlace !== '1'}
                        <div class="old-price">
                            <small class="text-muted">
                                {lang key="oldPrice" section="global"}: 
                                <del class="value text-nowrap">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                            </small>
                        </div>
                    {/if}
                    {if $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 2 || isset($Einstellungen.artikeluebersicht) && $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 4}
                        <div class="discount">
                            <small class="text-muted">
                                {lang key="discount" section="global"}: 
                                <span class="value text-nowrap">{$Artikel->Preise->rabatt}%</span>
                            </small>
                        </div>
                    {/if}
                {/if}
            </div>{* /price-note *}
        {/if}
    {/if}
    {/block}
    </div>{* /price_wrapper *}
{else}
    {block name="price-invisible"}
        <span class="price_label price_invisible">{lang key="priceHidden" section="global"}</span>
    {/block}
{/if}