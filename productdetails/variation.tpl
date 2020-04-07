{if isset($smarty.get.quickView) && $smarty.get.quickView == 1}
    {assign var="modal" value=true}
{else}
    {assign var="modal" value=false}
{/if}
{if isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0 && !$showMatrix}
    {assign var="VariationsSource" value="Variationen"}
    {if isset($ohneFreifeld) && $ohneFreifeld}
        {assign var="VariationsSource" value="VariationenOhneFreifeld"}
    {/if}
    {assign var="oVariationKombi_arr" value=$Artikel->getChildVariations()}
    <div class="row">
        <div class="updatingStockInfo col-xs-12 text-center"></div>
    </div>
    <div class="variations {if $simple}simple{else}switch{/if}-variations top15 row">
        <div class="col-xs-12">
            <dl>
            {foreach name=Variationen from=$Artikel->$VariationsSource key=i item=Variation}
            {strip}
                {if !isset($smallView) || !$smallView}
                <dt><span{if $Variation->cTyp === 'PFLICHT-FREIFELD'} class="required"{/if}>{$Variation->cName}</span>{if $Variation->cTyp === 'IMGSWATCHES'} <span class="swatches-selected text-muted" data-id="{$Variation->kEigenschaft}"></span>{/if}</dt>
                {/if}
                <dd class="form-group{if $Variation->cTyp !== 'FREIFELD' && !$showMatrix} required{/if}">
                    {if $Variation->cTyp === 'SELECTBOX'}
                        {block name="productdetails-info-variation-select"}
                        <select class="form-control" title="{if isset($smallView) && $smallView}{$Variation->cName} - {/if}{lang key="pleaseChooseVariation" section="productDetails"}" name="eigenschaftwert[{$Variation->kEigenschaft}]"{if !$showMatrix} required{/if}>
                            {assign var="bSelected" value=false}
							{foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                    {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                {/if}
                                {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                    {assign var="bSelected" value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
                                {/if}
							{/foreach}
                            <option disabled {if !$bSelected}selected {/if}hidden value>{lang key="pleaseChoose" section="global"}</option>
							{foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                {assign var="bSelected" value=false}
                                {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                    {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                {/if}
                                {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                    {assign var="bSelected" value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
                                {/if}
                                {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                {else}
                                    {include file="productdetails/variation_value.tpl" assign="cVariationsWert"}
                                    {include file="productdetails/variation_aufpreis.tpl" assign="cAufpreis"}
                                    <option value="{$Variationswert->kEigenschaftWert}" class="variation"
                                            data-type="option"
                                            data-original="{$Variationswert->cName}"
                                            data-key="{$Variationswert->kEigenschaft}"
                                            data-value="{$Variationswert->kEigenschaftWert}"
											{if $cAufpreis != ''}data-aufpreis="{$cAufpreis}"{/if}
                                            data-content="{$cVariationsWert|escape:'html'}{if $Variationswert->notExists}<span class='label label-default label-not-available'>{lang key='notAvailableInSelection'}</span>{elseif !$Variationswert->inStock}<span class='label label-default label-not-available'>{lang key='ampelRot'}</span>{/if}"
                                            {if !empty($Variationswert->cBildPfadMini)}
                                                data-list='{prepare_image_details item=$Variationswert json=true}'
                                                data-title='{$Variationswert->cName}'
                                            {/if}
                                            {if isset($Variationswert->oVariationsKombi)}
                                                data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                            {/if}
											{* if $Variationswert->notExists} disabled{/if *}
                                            {if $bSelected} selected="selected"{/if}>
                                        {$cVariationsWert|trim}
                                    </option>
                                {/if}
                            {/foreach}
                        </select>
                        {/block}
                    {elseif $Variation->cTyp === 'RADIO'}
                        {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                            {assign var="bSelected" value=false}
                            {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                               {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                            {/if}
                            {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                {assign var="bSelected" value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
                            {/if}
                            {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                            $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                            !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                            {else}
                                {block name="productdetails-info-variation-radio"}
                                <label class="variation" for="{if $modal}modal-{elseif isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                       data-type="radio"
                                       data-original="{$Variationswert->cName}"
                                       data-key="{$Variationswert->kEigenschaft}"
                                       data-value="{$Variationswert->kEigenschaftWert}"
                                       {if !empty($Variationswert->cBildPfadMini)}
                                            data-list='{prepare_image_details item=$Variationswert json=true}'
                                            data-title='{$Variationswert->cName}{if $Variationswert->notExists} - {lang key='notAvailableInSelection'}{elseif !$Variationswert->inStock} - {lang key='ampelRot'}{/if}'
                                       {/if}
                                       {if !$Variationswert->inStock}
                                            data-stock="out-of-stock"
                                       {/if}
                                       {if isset($Variationswert->oVariationsKombi)}
                                            data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                       {/if}>
                                    <input type="radio"
                                           name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                           id="{if $modal}modal-{elseif isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                           value="{$Variationswert->kEigenschaftWert}"
                                           {if $bSelected}checked="checked"{/if}
                                           {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
										   {if $Variationswert->notExists} disabled{/if}
                                           >
                                    {include file="productdetails/variation_value.tpl"}{if $Variationswert->notExists}<span class='label label-default label-not-available'>{lang key='notAvailableInSelection'}</span>{elseif !$Variationswert->inStock}<span class='label label-default label-not-available'>{lang key='ampelRot'}</span>{/if}
                                </label>
                                {/block}
                            {/if}
                        {/foreach}
                    {elseif $Variation->cTyp === 'IMGSWATCHES' || $Variation->cTyp === 'TEXTSWATCHES'}
                        <div class="btn-group swatches {$Variation->cTyp|lower}">
                            {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                {assign var="bSelected" value=false}
                                {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                    {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                {/if}
                                {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                    {assign var="bSelected" value=($Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert)}
                                {/if}
                                {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                    {* /do nothing *}
                                {else}
                                    {block name="productdetails-info-variation-swatch"}
                                    <label class="variation block btn btn-default{if $bSelected} active{/if}{if $Variationswert->notExists} not-available{/if}{if empty($Variationswert->cBildPfadMini)} noimgswatch{/if}"
                                            data-type="swatch"
                                            data-original="{$Variationswert->cName}"
                                            data-key="{$Variationswert->kEigenschaft}"
                                            data-value="{$Variationswert->kEigenschaftWert}"
                                            for="{if $modal}modal-{elseif isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                            {if !empty($Variationswert->cBildPfadMini)}
                                                data-list='{prepare_image_details item=$Variationswert json=true}'
                                            {/if}
                                            {if $Variationswert->notExists}
                                                title="{lang key='notAvailableInSelection'}"
                                                data-title="{$Variationswert->cName} - {lang key='notAvailableInSelection'}"
                                                data-toggle="tooltip"
                                            {elseif $Variationswert->inStock}
                                                data-title="{$Variationswert->cName}"
                                            {else}
                                                title="{lang key='ampelRot'}"
                                                data-title="{$Variationswert->cName} - {lang key='ampelRot'}"
                                                data-toggle="tooltip"
                                                data-stock="out-of-stock"
                                            {/if}
                                            {if isset($Variationswert->oVariationsKombi)}
                                                data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                            {/if}>
                                        <input type="radio"
                                               class="control-hidden"
                                               name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                               id="{if $modal}modal-{elseif isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                               value="{$Variationswert->kEigenschaftWert}"
                                               {if $bSelected}checked="checked"{/if}
                                               {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
											   {if $Variationswert->notExists} disabled{/if}
											   required
                                               />
                                        <span class="label-variation">
                                            {if !empty($Variationswert->cBildPfadMini)}
                                                <img src="{$Variationswert->cBildPfadMini}" alt="{$Variationswert->cName|escape:'quotes'}"
                                                     data-list='{prepare_image_details item=$Variationswert json=true}'
                                                     title="{$Variationswert->cName}" />
                                            {else}
                                                {$Variationswert->cName}
                                            {/if}
                                        </span>
                                        {include file="productdetails/variation_value.tpl" hideVariationValue=true}
                                    </label>
                                    {/block}
                                {/if}
                            {/foreach}
                        </div>
                    {elseif $Variation->cTyp === 'FREIFELD' || $Variation->cTyp === 'PFLICHT-FREIFELD'}
                        {block name="productdetails-info-variation-text"}
                        <input type="text"
                           class="form-control"
                           name="eigenschaftwert[{$Variation->kEigenschaft}]"
                           value="{if isset($oEigenschaftWertEdit_arr[$Variation->kEigenschaft])}{$oEigenschaftWertEdit_arr[$Variation->kEigenschaft]->cEigenschaftWertNameLocalized}{/if}"
                           data-key="{$Variation->kEigenschaft}"{if $Variation->cTyp === 'PFLICHT-FREIFELD'} required{/if}>
                        {/block}
                    {/if}
                </dd>
            {/strip}
            {/foreach}
            </dl>
        </div>
    </div>
{/if}