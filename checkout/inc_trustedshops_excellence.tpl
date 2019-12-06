{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

{if !empty($oTrustedShops->tsId) && $oTrustedShops->eType == $TS_BUYERPROT_CLASSIC}
    <table width=400 border="0" cellspacing="0" cellpadding="4">
        <tr>
            <td width="90">
                <form name="formSiegel" method="post" action="https://www.trustedshops.de/de/tshops/seal_de.php3" target="_blank">
                    <input type="image" border="0" src="gfx/TrustedShops/trusted_siegel.gif" title="{lang key="ts_signtitle" section="global"}" />
                    <input name="shop_id" type="hidden" value="{*{$Einstellungen.global.trusted_shops_id}*}{$oTrustedShops->tsId}" />
                </form>
            </td>
            <td align="justify">
                <form id="formTShops" name="formTShops" method="post" action="https://www.trustedshops.de/de/tshops/protect_de.php3" target="_blank">
                    <input type="hidden" name="_charset_" />
                    <input name="shop_id" type="hidden" value="{$oTrustedShops->tsId}" />
                    <input name="paymentType" type="hidden" value="{$oTrustedShops->paymentType}" />
                    <input name="email" type="hidden" value="{$Kunde->cMail}" />
                    <input name="first_name" type="hidden" value="{$Kunde->cVorname}" />
                    <input name="last_name" type="hidden" value="{$Kunde->cNachname}" />
                    <input name="street" type="hidden" value="{$Kunde->cStrasse} {$Kunde->cHausnummer}" />
                    <input name="zip" type="hidden" value="{$Kunde->cPLZ}" />
                    <input name="city" type="hidden" value="{$Kunde->cOrt}" />
                    <input name="country" type="hidden" value="{$Kunde->cLand}" />
                    <input name="phone" type="hidden" value="{$Kunde->cTel}" />
                    <input name="KDNR" type="hidden" value="{$Kunde->cKundenNr}" />
                    <input name="amount" type="hidden" value="{$Bestellung->fGesamtsummeKundenwaehrung}" />
                    <input name="curr" type="hidden" value="{$Bestellung->Waehrung->cISO}" />
                    <input name="ORDERNR" type="hidden" value="{$Bestellung->cBestellNr}" />
                    <span class="ts-comment">{lang key="ts_comment" section="global"}<br /></span>
                    <input type="submit" id="btnProtect" name="btnProtect" value="{lang key="ts_register" section="global"}" />
                </form>
            </td>
        </tr>
    </table>
{/if}