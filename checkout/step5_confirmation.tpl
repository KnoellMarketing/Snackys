<div id="order-confirm">
    {if $hinweis}
       <p class="alert alert-danger">{$hinweis}</p>
    {/if}

    {if !empty($smarty.get.mailBlocked)}
        <p class="alert alert-danger">{lang key="kwkEmailblocked" section="errorMessages"}</p>
    {/if}

    {if !empty($smarty.get.fillOut)}
       <p class="alert alert-danger">{lang key="fillOutQuestion" section="messages"}</p>
    {/if}

    <div class="row row-eq-height">
        <div class="col-xs-12 col-sm-8"  id="check-billing-shipping-address">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        {* ToDo: New Localization! *}
                        {lang key="billingAdress" section="account data"} &amp; {lang key="shippingAdress" section="account data"}
                    </h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-6" id="billing-address">
                        {block name="checkout-confirmation-billing-address"}
                            <p class="title">
                                <strong>{lang key="billingAdress" section="account data"}</strong>
                            </p>
                            <p>
                                {include file='checkout/inc_billing_address.tpl'}
                            </p>
                            <a class="small edit pr" href="{get_static_route id='bestellvorgang.php'}?editRechnungsadresse=1">
                                <span class="img-ct icon">
									<svg>
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-edit"></use>
									</svg>
								</span> {lang key="modifyBillingAdress" section="global"}
                            </a>
                        {/block}
                        </div>
                        <div class="col-xs-6" id="shipping-address">
                        {block name="checkout-confirmation-shipping-address"}
                            <p class="title">
                                <strong>{lang key="shippingAdress" section="account data"}</strong>
                            </p>
                            <p>
                                {include file='checkout/inc_delivery_address.tpl'}
                            </p>
                            <a class="small edit pr" href="{get_static_route id='bestellvorgang.php'}?editLieferadresse=1#select_shipping_address">
                                <span class="img-ct icon">
									<svg>
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-edit"></use>
									</svg>
								</span> {lang key="modifyShippingAdress" section="checkout"}
                            </a>
                        {/block}
                        </div>
                    </div>{* /row *}
                </div>{* /panel-body *}
            </div>{* /panel *}
        </div>

        <div class="col-xs-12 col-sm-4" id="check-payment-shipping">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        {* ToDo: New Localization! *}
                        {lang key="shippingOptions" section="global"} &amp; {lang key="paymentOptions" section="global"}
                    </h3>
                </div>
                <div class="panel-body">
                    <div id="shipping-method">
                        {block name="checkout-confirmation-shipping-method"}
                            <p>
                                <strong class="title">{lang key="shippingOptions" section="global"}: </strong>
                                {$smarty.session.Versandart->angezeigterName|trans}
                            </p>

                            {$cEstimatedDelivery = $smarty.session.Warenkorb->getEstimatedDeliveryTime()}
                            {if $cEstimatedDelivery|@count_characters > 0}
                                <p class="small text-muted">
                                    <strong>{lang key="shippingTime" section="global"}</strong>: {$cEstimatedDelivery}
                                </p>
                            {/if}
                            <a class="small edit pr" href="{get_static_route id='bestellvorgang.php'}?editVersandart=1">
                                <span class="img-ct icon">
									<svg>
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-edit"></use>
									</svg>
								</span> {lang key="modifyShippingOption" section="checkout"}
                            </a>
                        {/block}
                    </div>
                    <hr>
                    <div id="payment-method">
                        {block name="checkout-confirmation-payment-method"}
                        <p>
                            <strong class="title">{lang key="paymentOptions" section="global"}: </strong>
                            {$smarty.session.Zahlungsart->angezeigterName|trans}
                        </p>
                        {if isset($smarty.session.Zahlungsart->cHinweisText) && !empty($smarty.session.Zahlungsart->cHinweisText)}{* this should be localized *}
                            <p class="small text-muted">{$smarty.session.Zahlungsart->cHinweisText}</p>
                        {/if}
                        <a class="small edit pr" href="{get_static_route id='bestellvorgang.php'}?editZahlungsart=1">
                            <span class="img-ct icon">
								<svg>
								  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-edit"></use>
								</svg>
							</span> {lang key="modifyPaymentOption" section="checkout"}
                        </a>
                        {/block}
                    </div>
                </div>{* /panel-body *}
            </div>
        </div>
    </div>{* /row *}

    {if $GuthabenMoeglich}
        {block name="checkout-confirmation-credit"}
            <div class="panel panel-default" id="panel-edit-credit">
                <div class="panel-heading">
                    <h3 class="panel-title">{block name="checkout-confirmation-credit-title"}{lang key="credit" section="account data"}{/block}</h3>
                </div>
                <div class="panel-body">
                    {include file='checkout/credit_form.tpl'}
                </div>
            </div>
        {/block}
    {/if}
    <div class="row row-eq-height row-multi">
        {block name="checkout-confirmation-comment"}
            <div class="col-xs-12 col-md-{if $KuponMoeglich == 1}8{else}12{/if}">
                <div class="panel panel-default" id="panel-edit-comment">
                    <div class="panel-heading">
                        <h3 class="panel-title">{block name="checkout-confirmation-comment-title"}{lang key="comment" section="product rating"}{/block}</h3>
                    </div>
                    <div class="panel-body">
                        {block name="checkout-confirmation-comment-body"}
                            {lang assign="orderCommentsTitle" key="orderComments" section="shipping payment"}
                            <textarea class="form-control" title="{$orderCommentsTitle|escape:"html"}" name="kommentar" cols="50" rows="3" id="comment" placeholder="{lang key="comment" section="product rating"}">{if isset($smarty.session.kommentar)}{$smarty.session.kommentar}{/if}</textarea>
                        {/block}
                    </div>
                </div>
            </div>
        {/block}
        {if $KuponMoeglich}
            <div class="col-xs-12 col-md-4">
                {block name="checkout-confirmation-coupon"}
                <div class="panel panel-default" id="panel-edit-coupon">
                    <div class="panel-heading">
                        <h3 class="panel-title">{block name="checkout-confirmation-coupon-title"}{lang key="coupon" section="account data"}{/block}</h3>
                    </div>
                    <div class="panel-body">
                        {include file='checkout/coupon_form.tpl'}
                    </div>
                </div>
                {/block}
            </div>
        {/if}
    </div>{* /row *}

    {if isset($safetypay_form)}
        <div class="alert alert-info">{$safetypay_form}</div>
    {/if}
    <form method="post" name="agbform" id="complete_order" action="{get_static_route id='bestellabschluss.php'}" class="evo-validate">
        {$jtl_token}
        {if $Einstellungen.kaufabwicklung.bestellvorgang_wrb_anzeigen == 1}
            {lang key="cancellationPolicyNotice" section="checkout" assign="cancellationPolicyNotice"}
            {lang key="wrb" section="checkout" assign="wrb"}
            {if isset($AGB->kLinkWRB) && $AGB->kLinkWRB > 0}
                {assign var='linkWRB' value='<a href="navi.php?s='|cat:$AGB->kLinkWRB|cat:'" class="popup">'|cat:$wrb|cat:'</a>'}

                <div class="alert alert-info">{$cancellationPolicyNotice|replace:"#LINK_WRB#":$linkWRB}</div>
            {elseif !empty($AGB->cWRBContentHtml)}
                {block name="checkout-confirmation-modal-agb-html"}
                {assign var='linkWRB' value='<a href="#" data-toggle="modal" data-target="#wrbHtmlModal" class="modal-popup" id="wrb">'|cat:$wrb|cat:'</a>'}
                <div class="alert alert-info">{$cancellationPolicyNotice|replace:'#LINK_WRB#':$linkWRB}</div>
                <div class="modal fade" id="wrbHtmlModal" tabindex="-1" role="dialog" aria-labelledby="wrbHtmlLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" id="wrbHtmlLabel">{lang key="wrb" section="checkout"}</h4>
                                <button type="button" class="close-btn" data-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                {$AGB->cWRBContentHtml}
                            </div>
                        </div>
                    </div>
                </div>
                {/block}
            {elseif !empty($AGB->cWRBContentText)}
                {block name="checkout-confirmation-modal-agb-text"}
                {assign var='linkWRB' value='<a href="#" data-toggle="modal" data-target="#wrbTextModal" class="modal-popup" id="wrb">'|cat:$wrb|cat:'</a>'}
                <div class="alert alert-info">{$cancellationPolicyNotice|replace:'#LINK_WRB#':$linkWRB}</div>
                <div class="modal fade" id="wrbTextModal" tabindex="-1" role="dialog" aria-labelledby="wrbTextLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" id="wrbTextLabel">{lang key="wrb" section="checkout"}</h4>
                                <button type="button" class="close-btn" data-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                {$AGB->cWRBContentText}
                            </div>
                        </div>
                    </div>
                </div>
                {/block}
            {/if}
        {/if}
        {if !isset($smarty.session.cPlausi_arr)}
            {assign var=plausiArr value=array()}
        {else}
            {assign var=plausiArr value=$smarty.session.cPlausi_arr}
        {/if}

        {hasCheckBoxForLocation bReturn="bCheckBox" nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr}
        {if $bCheckBox}
            <hr>
            {include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr}
            <hr>
        {/if}
        <div class="row">
            <div class="col-xs-12 order-submit">
                {block name="checkout-confirmation-confirm-order"}
                <div class="panel-wrap basket-well basket-final">
                    <div class="panel panel-primary" id="panel-submit-order">
                        <div class="panel-body">
                            <input type="hidden" name="abschluss" value="1" />
                            <input type="hidden" id="comment-hidden" name="kommentar" value="" />
                            <div class="">
                            {include file="checkout/inc_order_items.tpl" tplscope="confirmation"}
								<hR>
							<div class="cart-sum mb-spacer">
								{if $NettoPreise}
									<div class="total-net dpflex-a-center dpflex-j-between">
										<span class="price_label"><strong>{lang key="totalSum" section="global"} ({lang key="net" section="global"}):</strong></span>
										<strong class="price total-sum">{$WarensummeLocalized[$NettoPreise]}</strong>
									</div>
								{/if}

								{if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && $Steuerpositionen|@count > 0}
									{foreach name=steuerpositionen from=$Steuerpositionen item=Steuerposition}
										<div class="tax dpflex-a-center dpflex-j-between">
											<span class="tax_label">{$Steuerposition->cName}:</span>
											<span class="tax_label">{$Steuerposition->cPreisLocalized}</span>
										</div>
									{/foreach}
								{/if}

								{if isset($smarty.session.Bestellung->GuthabenNutzen) && $smarty.session.Bestellung->GuthabenNutzen == 1}
									 <div class="customer-credit dpflex-a-center dpflex-j-between">
										 <span>{lang key="useCredit" section="account data"}</span>
										  <span>{$smarty.session.Bestellung->GutscheinLocalized}</span>
									 </div>
								{/if}

								<div class="total info dpflex-a-center dpflex-j-between">
									<span class="price_label"><strong>{lang key="totalSum" section="global"}:</strong></span>
									<strong class="price total-sum">{$WarensummeLocalized[0]}</strong>
								</div>
							</div>
                            </div>
                            <input type="submit" value="{lang key="orderLiableToPay" section="checkout"}" id="complete-order-button" class="btn btn-primary btn-lg submit submit_once" />
                            <a href="{get_static_route id='warenkorb.php'}" class="btn btn-link btn-lg hidden-xxs">{lang key="modifyBasket" section="checkout"}</a>
                        </div>
                    </div>
                </div>
                {/block}
            </div>
        </div>{* /row *}
    </form>
</div>