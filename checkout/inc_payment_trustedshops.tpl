{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}
{if isset($oTrustedShops->oKaeuferschutzProdukte->item) && $oTrustedShops->oKaeuferschutzProdukte->item|@count > 0 && $Einstellungen.trustedshops.trustedshops_nutzen === 'Y'}
    <div id="ts-buyerprotection">
        <div class="row bottom15">
            <div class="col-xs-10">
                {if $oTrustedShops->oKaeuferschutzProdukte->item|@count > 1}
                    <div class="checkbox">
                        <label for="trusted_bTS" class="btn-block">
                            <input id="trusted_bTS" name="bTS" type="checkbox" value="1">
                            <span class="control-label label-default">
                            <span class="content">
                                <span class="title">{lang key="trustedShopsBuyerProtection" section="global"} ({lang key="trustedShopsRecommended" section="global"})</span>
                            </span>
                        </span>
                        </label>
                    </div>

                    <select name="cKaeuferschutzProdukt" class="form-control">
                        {foreach name=kaeuferschutzprodukte from=$oTrustedShops->oKaeuferschutzProdukte->item item=oItem}
                            <option value="{$oItem->tsProductID}"{if $oTrustedShops->cVorausgewaehltesProdukt == $oItem->tsProductID} selected{/if}>{lang key="trustedShopsBuyerProtection" section="global"} {lang key="trustedShopsTo" section="global"} {$oItem->protectedAmountDecimalLocalized}
                                ({$oItem->grossFeeLocalized} {$oItem->cFeeTxt})
                            </option>
                        {/foreach}
                    </select>
                {elseif $oTrustedShops->oKaeuferschutzProdukte->item|@count == 1}
                    <div class="checkbox">
                        <label for="trusted_bTS" class="btn-block">
                            <input id="trusted_bTS" name="bTS" type="checkbox" value="1">
                            <span class="control-label label-default">
                            <span class="content">
                                <span class="title">{lang key="trustedShopsBuyerProtection" section="global"} {lang key="trustedShopsTo" section="global"} {$oTrustedShops->oKaeuferschutzProdukte->item[0]->protectedAmountDecimalLocalized}
                                    ({$oTrustedShops->oKaeuferschutzProdukte->item[0]->grossFeeLocalized} {$oTrustedShops->oKaeuferschutzProdukte->item[0]->cFeeTxt})
                                </span>
                            </span>
                        </span>
                        </label>
                    </div>
                    <input name="cKaeuferschutzProdukt" type="hidden" value="{$oTrustedShops->oKaeuferschutzProdukte->item[0]->tsProductID}">
                {/if}
                <p class="small text-muted top10">
                    {assign var=cISOSprache value=$oTrustedShops->cISOSprache}
                    {if !empty($oTrustedShops->cBoxText[$cISOSprache])}
                        {$oTrustedShops->cBoxText[$cISOSprache]}
                    {else}
                        {assign var=cISOSprache value='default'}
                        {$oTrustedShops->cBoxText[$cISOSprache]}
                    {/if}
                </p>
            </div>
            <div class="col-xs-2">
                <a href="{$oTrustedShops->cLogoURL}" target="_blank"><img src="{$URL_SHOP}/{$PFAD_GFX_TRUSTEDSHOPS}ts_logo.jpg" alt="" class="img-responsive"></a>
            </div>
        </div>
    </div>
{/if}