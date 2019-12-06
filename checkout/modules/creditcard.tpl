<fieldset>
    {if isset($fehlendeAngaben)}
        <div class="alert alert-danger">{lang key="invadivdDataWarning" section=""}</div>
    {else}
        <div class="alert alert-info">{lang key="yourDataDesc" section="account data"}</div>
    {/if}
</fieldset>
<fieldset id="payment_creditcard">
    <legend>{lang key="paymentOptionCreditcardDesc" section="shipping payment"}</legend>
    <div class="row">
        <div class="col-xs-12 col-md-6">    
            <div class="form-group float-label-control crc_no required{if isset($fehlendeAngaben.kreditkartennr) && $fehlendeAngaben.kreditkartennr>0} has-error{/if}">
                <label class="control-label" for="inp_creditcardNo">{lang key="creditcardNo" section="shipping payment"}</label>
                <input class="form-control" type="text" name="kreditkartennr" id="inp_creditcardNo" maxlength="32" size="32" value="{if isset($ZahlungsInfo->cKartenNr)}{$ZahlungsInfo->cKartenNr}{/if}" required>
                {if isset($fehlendeAngaben.kreditkartennr) && $fehlendeAngaben.kreditkartennr>0}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
            </div>
        </div>
    
        <div class="col-xs-12 col-md-6">  
            <div class="form-group float-label-control crc_vadivd required{if isset($fehlendeAngaben.gueltigkeit) && $fehlendeAngaben.gueltigkeit>0} has-error{/if}">
                <label class="control-label" for="inp_validity">{lang key="validity" section="shipping payment"}</label>
                <input class="form-control" type="text" name="gueltigkeit" id="inp_validity" maxlength="12"  size="12" value="{if isset($ZahlungsInfo->cGueltigkeit)}{$ZahlungsInfo->cGueltigkeit}{/if}" required>
                {if isset($fehlendeAngaben.gueltigkeit) && $fehlendeAngaben.gueltigkeit>0}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
            </div> 
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12 col-md-6">    
            <div class="form-group float-label-control crc_cvv required{if isset($fehlendeAngaben.cvv) && $fehlendeAngaben.cvv>0} has-error{/if}">
                <label class="control-label" for="inp_cvv">{lang key="cvv" section="shipping payment"}</label>
                <input class="form-control" type="text" name="cvv" id="inp_cvv" maxlength="4" size="4" value="{if isset($ZahlungsInfo->cCVV)}{$ZahlungsInfo->cCVV}{/if}" required>
                {if isset($fehlendeAngaben.cvv) && $fehlendeAngaben.cvv>0}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
            </div>
        </div>

        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control crc_type required{if isset($fehlendeAngaben.kartentyp) && $fehlendeAngaben.kartentyp>0} has-error{/if}">
                <label class="control-label" for="inp_creditcardType">{lang key="creditcardType" section="shipping payment"}</label>
                <input class="form-control" type="text" name="kartentyp" id="inp_creditcardType" maxlength="45" size="32" value="{if isset($ZahlungsInfo->cKartenTyp)}{$ZahlungsInfo->cKartenTyp}{/if}">
                {if isset($fehlendeAngaben.kartentyp) && $fehlendeAngaben.kartentyp>0}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control crc_owner required{if isset($fehlendeAngaben.inhaber) && $fehlendeAngaben.inhaber>0} has-error{/if}">
                <label class="control-label" for="inp_owner">{lang key="owner" section="shipping payment"}</label>
                <input class="form-control" type="text" name="inhaber" id="inp_owner" maxlength="80" size="32" value="{if isset($ZahlungsInfo->cInhaber)}{$ZahlungsInfo->cInhaber}{/if}" required>
                {if isset($fehlendeAngaben.inhaber) && $fehlendeAngaben.gueltigkeit>0}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
            </div>
        </div>
    </div>
</fieldset>