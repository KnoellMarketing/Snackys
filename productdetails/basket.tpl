{if ($Artikel->inWarenkorbLegbar == 1 || $Artikel->nErscheinendesProdukt == 1) || $Artikel->Variationen}
    <div id="add-to-cart" class="hidden-print product-buy{if $Artikel->nErscheinendesProdukt} coming_soon{/if}">

        {block name="add-to-cart"}
            {if $Artikel->nErscheinendesProdukt}
                <div class="{if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y'}alert alert-warning coming_soon{else}alert alert-info {/if} text-center">
                    {lang key="productAvailableFrom" section="global"}: <strong>{$Artikel->Erscheinungsdatum_de}</strong>
                    {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar == 1}
                        ({lang key="preorderPossible" section="global"})
                    {/if}
                </div>
            {/if}
            {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}
                <p class="alert alert-info choose-variations">{lang key="chooseVariations" section="messages"}</p>
            {elseif $Artikel->inWarenkorbLegbar == 1 && !$Artikel->oKonfig_arr}
                {if !$showMatrix}
                    {block name="basket-form-inline"}
                    <div class="form-inline">
                        <div id="quantity-grp" class="choose_quantity">
                            <input type="{if $Artikel->cTeilbar === 'Y' && $Artikel->fAbnahmeintervall == 0}text{else}number{/if}" min="0"{if $Artikel->fAbnahmeintervall > 0} required step="{$Artikel->fAbnahmeintervall}"{/if}
                                   id="quantity" class="quantity form-control text-right" name="anzahl"
                                   aria-label="{lang key='quantity'}"
                                   value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}1{/if}" />
                            {if $Artikel->cEinheit}
                                <span class="input-group-addon unit">{$Artikel->cEinheit}</span>
                            {/if}
                            <span class="input-group-btn">
                                <button aria-label="{lang key='addToCart'}" name="inWarenkorb" type="submit" value="{lang key='addToCart'}" class="sn-addBasket submit btn btn-primary btn-lg btn-block{if isset($wkWeiterleiten)} wkWeiterleiten{/if}"
									gtag-type="click" gtag-event="add_to_cart" gtag-p-value="{$Artikel->Preise->fVKNetto}" gtag-p-currency="{$smarty.session.Waehrung->cISO}" gtag-p-items='[{ldelim}"id":"{$Artikel->cArtNr}","category":"{$cate|htmlspecialchars}","name":"{$Artikel->cName|htmlspecialchars}","price":"{$Artikel->Preise->fVKNetto}","quantity":"selectorval:#quantity"{rdelim}]'
								>
                                    <span class="">{lang key='addToCart'}</span>
                                </button>
                            </span>
                        </div>
                    </div>
                    {/block}
                {/if}
            {/if}
            {if $Artikel->inWarenkorbLegbar == 1 && ($Artikel->fMindestbestellmenge > 1 || ($Artikel->fMindestbestellmenge > 0 && $Artikel->cTeilbar === 'Y') || $Artikel->fAbnahmeintervall > 0 || $Artikel->cTeilbar === 'Y' || (isset($Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE]) && $Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE] > 0))}
                <div class="clearfix"></div>
                <div class="purchase-info alert alert-info top10" role="alert">
                    {assign var="units" value=$Artikel->cEinheit}
                    {if empty($Artikel->cEinheit) || $Artikel->cEinheit|@count_characters == 0}
                        <p>{lang key="units" section="productDetails" assign="units"}</p>
                    {/if}

                    {if $Artikel->fMindestbestellmenge > 1 || ($Artikel->fMindestbestellmenge > 0 && $Artikel->cTeilbar === 'Y')}
                        {lang key="minimumPurchase" section="productDetails" assign="minimumPurchase"}
                        <p>{$minimumPurchase|replace:"%d":$Artikel->fMindestbestellmenge|replace:"%s":$units}</p>
                    {/if}

                    {if $Artikel->fAbnahmeintervall > 0 && $Einstellungen.artikeldetails.artikeldetails_artikelintervall_anzeigen === 'Y'}
                        {lang key="takeHeedOfInterval" section="productDetails" assign="takeHeedOfInterval"}
                        <p>{$takeHeedOfInterval|replace:"%d":$Artikel->fAbnahmeintervall|replace:"%s":$units}</p>
                    {/if}

                    {if $Artikel->cTeilbar === 'Y'}
                        <p>{lang key="integralQuantities" section="productDetails"}</p>
                    {/if}

                    {if isset($Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE]) && $Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE] > 0}
                        {lang key="maximalPurchase" section="productDetails" assign="maximalPurchase"}
                        <p>{$maximalPurchase|replace:"%d":$Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE]|replace:"%s":$units}</p>
                    {/if}
                </div>
            {/if}
        {/block}
    </div>
{/if}
