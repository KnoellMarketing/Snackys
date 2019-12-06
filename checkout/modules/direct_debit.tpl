<fieldset id="payment_debit">
   <legend>{lang key="paymentOptionDebitDesc" section="shipping payment"}</legend>
    <div class="row">   
        {if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_kontoinhaber_abfrage !== 'N'}
            <div class="col-xs-12 col-md-6">
                <div class="form-group float-label-control owner {if isset($fehlendeAngaben.inhaber) && $fehlendeAngaben.inhaber>0} has-error{/if}{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_kontoinhaber_abfrage === 'Y'} required{/if}">
                    <label class="control-label" for="inp_owner">{lang key="owner" section="shipping payment"}</label>
                    <input required class="form-control" id="inp_owner" type="text" name="inhaber" maxlength="32" size="32" value="{if isset($ZahlungsInfo->cInhaber) && $ZahlungsInfo->cInhaber|count_characters > 0}{$ZahlungsInfo->cInhaber}{elseif isset($oKundenKontodaten->cInhaber)}{$oKundenKontodaten->cInhaber}{/if}"{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_kontoinhaber_abfrage === 'Y'} required{/if}>
                    {if isset($fehlendeAngaben.inhaber) && $fehlendeAngaben.inhaber>0}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
                </div>
            </div>
        {/if}

        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control bankname required{if isset($fehlendeAngaben.bankname) && $fehlendeAngaben.bankname>0} has-error{/if}">
                <label class="control-label" for="inp_bankname">{lang key="bankname" section="shipping payment"}</label>
                <input required class="form-control" id="inp_bankname" type="text" name="bankname" size="20" maxlength="90" value="{if isset($ZahlungsInfo->cBankName) && $ZahlungsInfo->cBankName|count_characters > 0}{$ZahlungsInfo->cBankName}{elseif isset($oKundenKontodaten->cBankName)}{$oKundenKontodaten->cBankName}{/if}">
               {if isset($fehlendeAngaben.bankname) && $fehlendeAngaben.bankname>0}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
            </div>
        </div>
    </div>

    {if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_kontonummer_abfrage !== 'N'}
        <div class="row">   
            <div class="col-xs-12 col-md-6">
                <div class="form-group float-label-control account_no{if isset($fehlendeAngaben.kontonr) && $fehlendeAngaben.kontonr>0} has-error{/if}{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_kontonummer_abfrage === 'Y'} required{/if}">
                    <label class="control-label" for="inp_account_no">{lang key="accountNo" section="shipping payment"}</label>
                    <input class="form-control" id="inp_account_no" type="text" name="kontonr" maxlength="32" size="12" value="{if isset($ZahlungsInfo->cKontoNr) && $ZahlungsInfo->cKontoNr|count_characters > 0}{$ZahlungsInfo->cKontoNr}{elseif isset($oKundenKontodaten->nKonto)}{$oKundenKontodaten->nKonto}{/if}"{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_kontonummer_abfrage === 'Y'} required{/if}>
                    {if isset($fehlendeAngaben.kontonr) && $fehlendeAngaben.kontonr>0}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
                </div>
            </div>

            <div class="col-xs-12 col-md-6">
                <div class="form-group float-label-control blz required{if isset($fehlendeAngaben.blz) && $fehlendeAngaben.blz>0} has-error{/if}{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_blz_abfrage === 'Y'} required{/if}">
                    <label class="control-label" for="inp_blz">{lang key="blz" section="shipping payment"}</label>
                    <input class="form-control" id="inp_blz" type="text" name="blz" maxlength="12" size="10" value="{if isset($ZahlungsInfo->cBLZ) && $ZahlungsInfo->cBLZ|count_characters > 0}{$ZahlungsInfo->cBLZ}{elseif isset($oKundenKontodaten->cBLZ)}{$oKundenKontodaten->cBLZ}{/if}"{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_blz_abfrage === 'Y'} required{/if}>
                   {if isset($fehlendeAngaben.blz) && $fehlendeAngaben.blz>0}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
                </div>
            </div>
        </div>
    {/if}

    {if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_iban_abfrage !== 'N'}
    <div class="row">   
        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control iban{if isset($fehlendeAngaben.iban) && $fehlendeAngaben.iban>0} has-error{/if}{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_iban_abfrage === 'Y'} required{/if}">
                <label class="control-label" for="inp_iban">{lang key="iban" section="shipping payment"}</label>
                <input class="form-control" id="inp_iban" type="text" name="iban" maxlength="32" value="{if isset($ZahlungsInfo->cIBAN) && $ZahlungsInfo->cIBAN|count_characters > 0}{$ZahlungsInfo->cIBAN}{elseif isset($oKundenKontodaten->cIBAN)}{$oKundenKontodaten->cIBAN}{/if}" size="20"{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_iban_abfrage === 'Y'} required{/if}>
                {if isset($fehlendeAngaben.iban) && $fehlendeAngaben.iban == 1}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
                {if isset($fehlendeAngaben.iban) && $fehlendeAngaben.iban == 2}<div class="alert alert-danger">{lang key="wrongIban" section="checkout"}</div>{/if}
            </div>
        </div>
    </div>
    {/if}

    {if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_bic_abfrage !== 'N'}
    <div class="row">   
        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control bic{if isset($fehlendeAngaben.bic) && $fehlendeAngaben.bic>0} has-error{/if}{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_bic_abfrage === 'Y'} required{/if}">
                <label class="control-label" for="inp_bic">{lang key="bic" section="shipping payment"}</label>
                <input class="form-control" id="inp_bic" type="text" name="bic" maxlength="32" size="20" value="{if isset($ZahlungsInfo->cBIC) && $ZahlungsInfo->cBIC|count_characters > 0}{$ZahlungsInfo->cBIC}{elseif isset($oKundenKontodaten->cBIC)}{$oKundenKontodaten->cBIC}{/if}"{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_bic_abfrage === 'Y'} required{/if}>
                {if isset($fehlendeAngaben.bic) && $fehlendeAngaben.bic>0}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
            </div>
        </div>
    </div>
    {/if}
</fieldset>