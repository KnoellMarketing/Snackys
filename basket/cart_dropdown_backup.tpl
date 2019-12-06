<li>
    {if $smarty.session.Warenkorb->PositionenArr|@count > 0}
        <table class="table table-striped dropdown-cart-items hyphens">
            <tbody>
            {foreach from=$smarty.session.Warenkorb->PositionenArr item=oPosition}
                {if !$oPosition->istKonfigKind()}
                    {if $oPosition->nPosTyp == C_WARENKORBPOS_TYP_ARTIKEL}
                        <tr>
                            <td class="item-image">
                                {if $oPosition->Artikel->Bilder[0]->cPfadNormal !== $BILD_KEIN_ARTIKELBILD_VORHANDEN}
                                    <img src="{$oPosition->Artikel->Bilder[0]->cPfadMini}" alt="" class="img-sm" />
                                {/if}
                            </td>
                            <td class="item-name" colspan="2">
                                {$oPosition->nAnzahl|replace_delim}&nbsp;&times;&nbsp;
                                <a href="{$oPosition->Artikel->cURL}" title="{$oPosition->cName|trans|escape:"html"}">
                                    {$oPosition->cName|trans}
                                </a>
                            </td>
                            <td class="item-price">
                                {if $oPosition->istKonfigVater()}
                                    {$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {else}
                                    {$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {/if}
                            </td>
                        </tr>
                    {else}
                        <tr>
                            <td></td>
                            <td class="item-name" colspan="2">
                                {$oPosition->nAnzahl|replace_delim}&nbsp;&times;&nbsp;{$oPosition->cName|trans|escape:"htmlall"}
                            </td>
                            <td class="item-price">
                                {$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                            </td>
                        </tr>
                    {/if}
                {/if}
            {/foreach}
            </tbody>
            <tfoot>
            {if $NettoPreise}
                <tr class="total total-net">
                    <td colspan="3">{lang key="totalSum"} ({lang key="net" section="global"}):</td>
                    <td class="text-nowrap text-right"><strong>{$WarensummeLocalized[$NettoPreise]}</strong></td>
                </tr>
            {/if}
            {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && isset($Steuerpositionen) && $Steuerpositionen|@count > 0}
                {foreach name=steuerpositionen from=$Steuerpositionen item=Steuerposition}
                    <tr class="text-muted tax">
                        <td colspan="3">{$Steuerposition->cName}</td>
                        <td class="text-nowrap text-right">{$Steuerposition->cPreisLocalized}</td>
                    </tr>
                {/foreach}
            {/if}
            <tr class="total">
                <td colspan="3">{lang key="totalSum"}:</td>
                <td class="text-nowrap text-right total"><strong>{$WarensummeLocalized[0]}</strong></td>
            </tr>
            </tfoot>
        </table>
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
