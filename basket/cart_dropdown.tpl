<li>
    {if $smarty.session.Warenkorb->PositionenArr|@count > 0}
    
        {include file='checkout/inc_order_items.tpl' isSidebar="1"}
    
        {if !empty($WarenkorbVersandkostenfreiHinweis)}
            <p class="small text-muted">{$WarenkorbVersandkostenfreiHinweis|truncate:120:"..."}
                <a class="popup" href="{if !empty($oSpezialseiten_arr) && isset($oSpezialseiten_arr[6])}{$oSpezialseiten_arr[6]->cURL}{else}#{/if}" data-toggle="tooltip"  data-placement="bottom" title="{lang section="login" key="shippingInfo"}">
                    
                </a>
            </p>
        {/if}
            <div class="fixed-btn-group">
                <a href="{get_static_route id='warenkorb.php'}" class="btn btn-block" title="{lang key='gotoBasket'}"> {lang key='gotoBasket'}</a>
                <a href="{get_static_route id='bestellvorgang.php'}" class="btn btn-primary btn-block">{lang key="checkout" section="basketpreview"}</a>
            </div>
  
    {else}
        <span class="alert alert-info text-center block">
            <a href="{get_static_route id='warenkorb.php'}" title="{lang section='checkout' key='emptybasket'}">{lang section='checkout' key='emptybasket'}</a>
        </span>
    {/if}
</li>
