{assign var="showProductWeight" value=false}
{if isset($Artikel->cArtikelgewicht) && $Artikel->fArtikelgewicht > 0
&& ($Einstellungen.artikeldetails.artikeldetails_artikelgewicht_anzeigen === 'Y' && $tplscope === 'details'
||  $Einstellungen.artikeluebersicht.artikeluebersicht_artikelgewicht_anzeigen === 'Y' && $tplscope === 'productlist')}
    {assign var="showProductWeight" value=true}
{/if}

{assign var="showShippingWeight" value=false}
{if isset($Artikel->cGewicht) && $Artikel->fGewicht > 0
&& ($Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $tplscope === 'details'
||  $Einstellungen.artikeluebersicht.artikeluebersicht_gewicht_anzeigen === 'Y' && $tplscope === 'productlist')}
    {assign var="showShippingWeight" value=true}
{/if}

{assign var="dimension" value=$Artikel->getDimension()}

{assign var="showAttributesTable" value=false}
{if $Einstellungen.artikeldetails.merkmale_anzeigen === 'Y' && !empty($Artikel->oMerkmale_arr)
|| $showProductWeight
|| $showShippingWeight
|| $Einstellungen.artikeldetails.artikeldetails_abmessungen_anzeigen === 'Y' && (!empty($dimension['length']) || !empty($dimension['width']) || !empty($dimension['height']))
|| isset($Artikel->cMasseinheitName) && isset($Artikel->fMassMenge) && $Artikel->fMassMenge > 0  && $Artikel->cTeilbar !== 'Y' && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1)
|| ($Einstellungen.artikeldetails.artikeldetails_attribute_anhaengen === 'Y'
|| (isset($Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ATTRIBUTEANHAENGEN]) && $Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ATTRIBUTEANHAENGEN] == 1)) && !empty($Artikel->Attribute)
}
    {assign var="showAttributesTable" value=true}
{/if}

{if $showAttributesTable}
<hr>
<div class="product-attributes">
    {block name="productdetails-attributes"}
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tbody>
                {if $Einstellungen.artikeldetails.merkmale_anzeigen === 'Y'}
                    {block name="productdetails-attributes-characteristics"}
                    {foreach from=$Artikel->oMerkmale_arr item=oMerkmal}
                        <tr class="attr-characteristic">
                            <td class="attr-label word-break">
                                {$oMerkmal->cName}:
{*                              ******* images as labels dont look well here *******
                                {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als === 'T'}
                                    {$oMerkmal->cName}:
                                {elseif $Einstellungen.navigationsfilter.merkmal_anzeigen_als === 'B' && !empty($oMerkmal->cBildpfadKlein)}
                                    <img src="{$oMerkmal->cBildpfadKlein}" title="{$oMerkmal->cName}" />
                                {elseif $Einstellungen.navigationsfilter.merkmal_anzeigen_als === 'BT'}
                                    {if isset($oMerkmal->cBildpfadKlein)}<img src="{$oMerkmal->cBildpfadKlein}" alt="{$oMerkmal->cName}" title="{$oMerkmal->cName}" class="vmiddle" /> {/if}{$oMerkmal->cName}:
                                {/if}
*}
                            </td>
                             <td class="attr-value">
                                 {strip}
                                 {foreach name="attr_characteristics" from=$oMerkmal->oMerkmalWert_arr item=oMerkmalWert}
                                         {if $oMerkmal->cTyp === 'TEXT' || $oMerkmal->cTyp === 'SELECTBOX' || $oMerkmal->cTyp === ''}
                                             <span class="value"><a href="{$oMerkmalWert->cURL}" class="label label-primary">{$oMerkmalWert->cWert|escape:"html"}</a> </span>
                                         {else}
                                             <span class="value">
                                                <a href="{$oMerkmalWert->cURL}" data-toggle="tooltip" data-placement="top" title="{$oMerkmalWert->cWert|escape:"html"}">
                                                    {if $oMerkmalWert->cBildpfadKlein !== 'gfx/keinBild_kl.gif'}
                                                        <img src="{$oMerkmalWert->cBildpfadKlein}" title="{$oMerkmalWert->cWert|escape:"html"}" alt="{$oMerkmalWert->cWert|escape:"html"}" />
                                                    {else}
                                                        <span class="value"><a href="{$oMerkmalWert->cURL}" class="label label-primary">{$oMerkmalWert->cWert|escape:"html"}</a> </span>
                                                    {/if}
                                                </a>
                                            </span>
                                         {/if}
                                {/foreach}
                                {/strip}
                            </td>
                        </tr>
                    {/foreach}
                    {/block}
                {/if}

                {if $showShippingWeight}
                    {block name="productdetails-attributes-shipping-weight"}
                    <tr class="attr-weight">
                        <td class="attr-label word-break">{lang key="shippingWeight" section="global"}: </td>
                        <td class="attr-value weight-unit">{$Artikel->cGewicht} {lang key="weightUnit" section="global"}</td>
                    </tr>
                    {/block}
                {/if}

                {if $showProductWeight}
                    {block name="productdetails-attributes-product-weight"}
                    <tr class="attr-weight" itemprop="weight" itemscope itemtype="http://schema.org/QuantitativeValue">
                        <td class="attr-label word-break">{lang key="productWeight" section="global"}: </td>
                        <td class="attr-value weight-unit weight-unit-article">
                            <span itemprop="value">{$Artikel->cArtikelgewicht}</span> <span itemprop="unitText">{lang key="weightUnit" section="global"}</span>
                        </td>
                    </tr>
                    {/block}
                {/if}

                {if isset($Artikel->cMasseinheitName) && isset($Artikel->fMassMenge) && $Artikel->fMassMenge > 0 && $Artikel->cTeilbar !== 'Y' && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1) && isset($Artikel->cMassMenge)}
                    {block name="productdetails-attributes-unit"}
                    <tr class="attr-contents">
                        <td class="attr-label word-break">{lang key="contents" section="productDetails"}: </td>
                        <td class="attr-value">{$Artikel->cMassMenge} {$Artikel->cMasseinheitName}</td>
                    </tr>
                    {/block}
                {/if}

                {if $dimension && $Einstellungen.artikeldetails.artikeldetails_abmessungen_anzeigen === 'Y'}
                    {block name="productdetails-attributes-dimensions"}
                    {assign var=dimensionArr value=$Artikel->getDimensionLocalized()}
                    {if $dimensionArr|count > 0}
                        <tr class="attr-dimensions">
                            <td class="attr-label word-break">{lang key="dimensions" section="productDetails"}
                                ({foreach name=DimensionKey from=$dimensionArr key=dimkey item=dim}
                                    {$dimkey}{if $smarty.foreach.DimensionKey.last}{else} &times; {/if}
                                {/foreach}):
                            </td>
                            <td class="attr-value">
                                {foreach name=Dimension from=$dimensionArr item=dim}
                                    {$dim}{if $smarty.foreach.Dimension.last} cm {else} &times; {/if}
                                {/foreach}
                            </td>
                        </tr>
                    {/if}
                    {/block}
                {/if}

                {if $Einstellungen.artikeldetails.artikeldetails_attribute_anhaengen === 'Y' || (isset($Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ATTRIBUTEANHAENGEN]) && $Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ATTRIBUTEANHAENGEN] == 1)}
                    {block name="productdetails-attributes-shop-attributes"}
                    {foreach name=Attribute from=$Artikel->Attribute item=Attribut}
                        <tr class="attr-custom">
                            <td class="attr-label word-break">{$Attribut->cName}: </td>
                            <td class="attr-value">{$Attribut->cWert}</td>
                        </tr>
                    {/foreach}
                    {/block}
                {/if}
            </tbody>{* /attr-group *}
        </table>
    </div>
    {/block}
</div>
{/if}
