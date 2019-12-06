{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
{include file="snippets/extension.tpl"}
<div class="row dpflex-j-between">
    <div class="{if ($Warenkorb->PositionenArr|@count > 0)}col-xs-12 col-md-7 col-lg-8{else}col-xs-12{/if}">
    <h1 class="mb-spacer mb-small">{lang key="basket" section="global"} <span class="text-muted">({$WarenkorbArtikelPositionenanzahl} {lang key="product" section="global"})</span></h1>
    
    {if !empty($WarenkorbVersandkostenfreiHinweis) && $Warenkorb->PositionenArr|@count > 0}
        <div class="alert alert-info">
            <span class="basket_notice">{$WarenkorbVersandkostenfreiHinweis}</span>
        </div>
    {/if}
    {if $Schnellkaufhinweis}
        <div class="alert alert-info">{$Schnellkaufhinweis}</div>
    {/if}
    {if count($Warenkorbhinweise)>0}
        <div class="alert alert-warning">
            {foreach name=hinweise from=$Warenkorbhinweise item=Warenkorbhinweis}
                {$Warenkorbhinweis}
                <br />
            {/foreach}
        </div>
    {/if}
    {if !empty($MsgWarning)}
        <p class="alert alert-danger" id="msgWarning">{$MsgWarning}</p>
    {/if}
    
    {if ($Warenkorb->PositionenArr|@count > 0)}
        {if !empty($BestellmengeHinweis)}
            <div class="alert alert-warning">{$BestellmengeHinweis}</div>
        {/if}
    
        {if !empty($invalidCouponCode)}
            <p class="alert alert-danger">{lang key='invalidCouponCode' section='checkout'}</p>
        {elseif !empty($cKuponfehler)}
            <p class="alert alert-danger">{lang key="couponErr$cKuponfehler"}</p>
        {/if}
        {if $nVersandfreiKuponGueltig}
            <div class="alert alert-success">
                {lang key='couponSucc1'}
                {foreach name=lieferlaender from=$cVersandfreiKuponLieferlaender_arr item=cVersandfreiKuponLieferlaender}
                    {$cVersandfreiKuponLieferlaender}{if !$smarty.foreach.lieferlaender.last}, {/if}
                {/foreach}
            </div>
        {/if}
        {block name="basket"}
            <div class="basket_wrapper">
                <div class="basket-well{if !empty($xselling->Kauf) && count($xselling->Kauf->Artikel) > 0} mb-spacer{/if}">
                    {block name="basket-items"}
						{include file="snippets/zonen.tpl" id="before_basket" title="before_basket"}
                        <form id="cart-form" method="post" action="{get_static_route id='warenkorb.php'}">
                            {$jtl_token}
                            <input type="hidden" name="wka" value="1" />
                            {include file='checkout/inc_order_items.tpl' tplscope='cart'}
							{if !$device->isMobile()}
                            <div class="cart-sum hidden-sm hidden-xs">
                                <hr>
                                {if $NettoPreise}
                                    <div class="total-net dpflex-j-between">
                                        <span class="price_label"><strong>{lang key="totalSum" section="global"} ({lang key="net" section="global"}):</strong></span>
                                        <strong class="price total-sum">{$WarensummeLocalized[$NettoPreise]}</strong>
                                    </div>
                                {/if}

                                {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && $Steuerpositionen|@count > 0}
                                    {foreach name=steuerpositionen from=$Steuerpositionen item=Steuerposition}
                                        <div class="tax dpflex-j-between">
                                            {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                                                <td class="hidden-xs"></td>
                                            {/if}
                                            <span class="tax_label">{$Steuerposition->cName}:</span>
                                            <span class="tax_label">{$Steuerposition->cPreisLocalized}</span>
                                        </div>
                                    {/foreach}
                                {/if}

                                {if isset($smarty.session.Bestellung->GuthabenNutzen) && $smarty.session.Bestellung->GuthabenNutzen == 1}
                                     <div class="customer-credit dpflex-j-between">
                                         <span>{lang key="useCredit" section="account data"}</span>
                                          <span>{$smarty.session.Bestellung->GutscheinLocalized}</span>
                                     </div>
                                {/if}

                                <div class="total info dpflex-j-between mb-spacer mb-xs">
                                    <span class="price_label"><strong>{lang key="totalSum" section="global"}:</strong></span>
                                    <strong class="price total-sum">{$WarensummeLocalized[0]}</strong>
                                </div>
                                <a href="{get_static_route id='bestellvorgang.php'}?wk=1" class="submit btn btn-primary btn-block">{lang key='nextStepCheckout' section='checkout'}</a>
                            </div>
							{/if}
                            {if !empty($oUploadSchema_arr)}
							<hr class="invisible">
							<hr class="invisible">
                            <div id="fileupload-wrapper">
                                {include file="productdetails/uploads.tpl"}
                            </div>
                            {/if}
                        </form>
                    {/block}
                </div>
    
                {if !empty($xselling->Kauf) && count($xselling->Kauf->Artikel) > 0}
                    {block name="basket-xsell"}
                        {lang key='basketCustomerWhoBoughtXBoughtAlsoY' section='global' assign='panelTitle'}
                        {include file='snippets/product_slider.tpl' productlist=$xselling->Kauf->Artikel title=$panelTitle}
                    {/block}
                {/if}
            </div>
        {/block}
    {else}
        <div class="alert alert-info">{lang key="emptybasket" section="checkout"}</div>
        <a href="{$ShopURL}" class="submit btn btn-primary">{lang key="continueShopping" section="checkout"}</a>
    {/if}
    </div>
    {if ($Warenkorb->PositionenArr|@count > 0)}
    <div class="col-xs-12 col-md-5 col-lg-4 right-boxes img-brd">
        <div class="cart-sum border-box mb-spacer mb-xs">
        <h2 class="h3">{lang key="accountOverview" section="account data"}</h2>
            {if $NettoPreise}
                <div class="total-net dpflex-j-between">
                    <span class="price_label"><strong>{lang key="totalSum" section="global"} ({lang key="net" section="global"}):</strong></span>
                    <strong class="price total-sum">{$WarensummeLocalized[$NettoPreise]}</strong>
                </div>
            {/if}

            {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && $Steuerpositionen|@count > 0}
                {foreach name=steuerpositionen from=$Steuerpositionen item=Steuerposition}
                    <div class="tax dpflex-j-between">
                        {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                            <td class="hidden-xs"></td>
                        {/if}
                        <span class="tax_label">{$Steuerposition->cName}:</span>
                        <span class="tax_label">{$Steuerposition->cPreisLocalized}</span>
                    </div>
                {/foreach}
            {/if}

            {if isset($smarty.session.Bestellung->GuthabenNutzen) && $smarty.session.Bestellung->GuthabenNutzen == 1}
                 <div class="customer-credit dpflex-j-between">
                     <span>{lang key="useCredit" section="account data"}</span>
                      <span>{$smarty.session.Bestellung->GutscheinLocalized}</span>
                 </div>
            {/if}

            <div class="total info dpflex-j-between mb-spacer mb-xs">
                <span class="price_label"><strong>{lang key="totalSum" section="global"}:</strong></span>
                <strong class="price total-sum">{$WarensummeLocalized[0]}</strong>
            </div>
            <a href="{get_static_route id='bestellvorgang.php'}?wk=1" class="submit btn btn-primary btn-block">{lang key='nextStepCheckout' section='checkout'}</a>
        </div>
        {if $oArtikelGeschenk_arr|@count > 0}
            {block name="basket-freegift"}
                <div id="freegift" class="panel panel-info border-box img-brd mb-spacer mb-xs">
                    <div class="panel-heading"><h2 class="panel-title h4">{block name="basket-freegift-title"}{lang key='freeGiftFromOrderValueBasket'}{/block}</h2></div>
                    <div class="panel-body">
                        {block name="basket-freegift-body"}
                            <form method="post" name="freegift" action="{get_static_route id='warenkorb.php'}">
                                {$jtl_token}
                                    {foreach name=gratisgeschenke from=$oArtikelGeschenk_arr item=oArtikelGeschenk}
									<div class="row mb-spacer mb-xs">
										<label class="thumbnail dpflex-a-center dpflex-nowrap w100" for="gift{$oArtikelGeschenk->kArtikel}" role="button">
											<div class="col-xs-1">
												<input name="gratisgeschenk" type="radio" value="{$oArtikelGeschenk->kArtikel}" id="gift{$oArtikelGeschenk->kArtikel}" />
											</div>
											<div class="col-xs-3 col-sm-2 col-md-3">
											<div class="img-ct">
												<img src="{$snackyConfig.preloadImage}" data-src="{$oArtikelGeschenk->Bilder[0]->cPfadNormal}" class="image" />
											</div>
											</div>
											<div class="caption col-xs-8 col-sm-9 col-md-8">
												<p class="m0">{$oArtikelGeschenk->cName}</p>
												<p class="small text-muted m0">{lang key='freeGiftFrom1'} {$oArtikelGeschenk->cBestellwert} {lang key='freeGiftFrom2'}</p>
											</div>
										</label>
									</div>
                                    {/foreach}
                                <div class="">
                                    <input type="hidden" name="gratis_geschenk" value="1" />
                                    <input name="gratishinzufuegen" type="submit" value="{lang key='addToCart'}" class="submit btn btn-block" />
                                </div>
                            </form>
                        {/block}
                    </div>
                </div>
            {/block}
        {/if}
        {assign var="showCoupon" value=false}
        {if $Einstellungen.kaufabwicklung.warenkorb_kupon_anzeigen === 'Y' && $KuponMoeglich == 1}
            {assign var="showCoupon" value=true}
            <div class="apply-coupon border-box img-brd mb-spacer mb-xs">
				<h2 class="h4">{lang key="useCoupon" section="checkout"}</h2>
                <form class="form-inline evo-validate" id="basket-coupon-form" method="post" action="{get_static_route id='warenkorb.php'}">
                    {$jtl_token}
                    {block name="basket-coupon"}
                        <div class="form-group m0 w100{if !empty($invalidCouponCode) || !empty($cKuponfehler)} has-error{/if}">
                            <div class="input-group">
                                <input aria-label="{lang key='couponCode' section='account data'}" class="form-control" type="text" name="Kuponcode" id="couponCode" maxlength="32" placeholder="{lang key='couponCode' section='account data'}" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" required/>
                                <span class="input-group-btn">
                                    <input class="btn btn-default" type="submit" value="&rsaquo;" />
                                </span>
                            </div>
                        </div>
                    {/block}
                </form>
            </div>
        {/if}
        
        {if $Einstellungen.kaufabwicklung.warenkorb_versandermittlung_anzeigen === 'Y'}
        <div class="basket-shipping-estimate-form border-box img-brd">
			{include file="snippets/zonen.tpl" id="before_shipping_calculator" title="before_shipping_calculator"}
            <form id="basket-shipping-estimate-form" method="post" action="{get_static_route id='warenkorb.php'}">
                {$jtl_token}
                {include file='snippets/shipping_calculator.tpl' checkout=true tplscope="cart"}
            </form>
        </div>
        {/if}
    </div>
    {/if}
    </div>
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}