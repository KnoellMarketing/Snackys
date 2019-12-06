<script type="text/javascript" src="{$currentTemplateDir}js/jtl.billpay.js"></script>

{if $cMissing_arr|@count > 0}
    <div class="alert alert-danger">Bitte f&uuml;llen Sie alle Pflichtfelder aus.</div>
{/if}

{if $billpay_message}
    <div class="alert alert-danger box_{$billpay_message->cType}">{$billpay_message->cCustomerMessage}</div>
{/if}

<fieldset id="billpay_form">
    <input type="hidden" name="za_billpay_jtl" value="1" />
    <input type="hidden" name="billpay_paymenttype" value="1" />

    {if $cAdditionalCustomer_arr|@count > 0}
        <fieldset>
            <legend>Weitere Kundendaten</legend>

            <div id="invoicebusiness_information">
                {*if $nPaymentTypes_arr[1]*}
                <div class="radio">
                    <label for="billpay_b2b_no">
                        <input type="radio" name="billpay_b2b" id="billpay_b2b_no" value="0" {if $cData_arr.billpay_b2b == 0}checked="checked"{/if} />
                        Privatkunde
                    </label>
                </div>
                {*/if*}

                {*if $nPaymentTypes_arr[4]*}
                <div class="radio">
                    <label for="billpay_b2b_yes">
                        <input type="radio" name="billpay_b2b" id="billpay_b2b_yes" value="1" {if $cData_arr.billpay_b2b == 1}checked="checked"{/if} />
                        Gesch&auml;ftskunde
                    </label>
                </div>
                {*/if*}
            </div>

            <div class="{if $cData_arr.billpay_b2b == 1}closed{/if}" id="invoicebusiness_b2c">
                {if $cAdditionalCustomer_arr.cAnrede}
                    <div class="form-group{if $cMissing_arr.cAnrede>0} has-error{/if} required">
                        <label class="control-label col-xs-4" for="salutation">{lang key="salutation" section="account data"}</label>
                        <div class="col-xs-8">
                            <select class="form-control" name="cAnrede" id="salutation" {if $cData_arr.billpay_b2b == 1}disabled{/if}>
                                <option value="" selected="selected">{lang key="pleaseChoose" section="global"}</option>
                                <option value="m" {if $cData_arr.cAnrede === 'm'}selected="selected"{/if}>{$Anrede_m}</option>
                                <option value="w" {if $cData_arr.cAnrede === 'w'}selected="selected"{/if}>{$Anrede_w}</option>
                            </select>
                            {if $cMissing_arr.cAnrede>0}
                                <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
                        </div>
                    </div>
                {/if}

                {if $cAdditionalCustomer_arr.dGeburtstag}
                    <div class="form-group{if $cMissing_arr.dGeburtstag>0} has-error{/if}">
                        <label class="control-label col-xs-4" for="dGeburtstag">{lang key="birthday" section="account data"}</label>
                        <div class="col-xs-8">
                            <input type="text" name="dGeburtstag" value="{$cData_arr.dGeburtstag}" id="dGeburtstag" class="form-control birthday" />
                            {if $cMissing_arr.dGeburtstag>0}
                                <div class="alert alert-danger">
                                    {if $cMissing_arr.dGeburtstag == 1}
                                        {lang key="fillOut" section="global"}
                                    {elseif $cMissing_arr.dGeburtstag == 2}
                                        {lang key="invalidDateformat" section="global"}
                                    {elseif $cMissing_arr.dGeburtstag == 3}
                                        {lang key="invalidDate" section="global"}
                                    {/if}
                                </div>
                            {/if}
                        </div>
                    </div>
                {/if}

                {if $cAdditionalCustomer_arr.cTel}
                    <div class="form-group{if $cMissing_arr.cTel>0} has-error_block{/if} required" id="tel" {*if (($nPaymentTypes_arr[1] || $nPaymentTypes_arr[2]) && $cData_arr.billpay_paymenttype != 3)}style="display:none"{/if*}>
                        <label class="control-label col-xs-4" for="cTel">{lang key="tel" section="account data"}
                            </label>

                        <div class="col-xs-8">
                            <input class="form-control" type="text" name="cTel" value="{$cData_arr.cTel}" id="cTel" />
                            {if $cMissing_arr.cTel>0}
                                <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                            {/if}
                        </div>
                    </div>
                {/if}
            </div>

            <div class="{if $cData_arr.billpay_b2b == 0}closed{/if}" id="invoicebusiness_b2b">

                <div class="row">
                    <div class="col-xs-12 col-md-6">
                        <div class="form-group float-label-control">
                            <select class="form-control" name="cAnrede" id="salutation" {*if $cData_arr.billpay_b2b == 0}disabled{/if*}>
                                <option value="" selected="selected">{lang key="pleaseChoose" section="global"}</option>
                                <option value="m" {if $cData_arr.cAnrede === 'm'}selected="selected"{/if}>{$Anrede_m}</option>
                                <option value="w" {if $cData_arr.cAnrede === 'w'}selected="selected"{/if}>{$Anrede_w}</option>
                            </select>
                            <label for="firstName" class="control-label">{lang key="salutation" section="account data"}</label></div>
                    </div>
                    <div class="col-xs-12 col-md-6">
                        <div class="form-group float-label-control">
                            <input type="text" name="cInhaber" value="{$cData_arr.cInhaber}" id="cInhaber" class="form-control" placeholder="Nachname*" required="">
                            <label for="cInhaber" class="control-label">Inhaber</label></div>
                    </div>
                </div>

                {*
            <div class="form-group{if $cMissing_arr.cAnrede>0} has-error{/if} required>
               <label class="control-label col-xs-4" for="salutation">{lang key="salutation" section="account data"}</label>
                  <select class="form-control" name="cAnrede" id="salutation" {if $cData_arr.billpay_b2b == 0}disabled{/if}>
                     <option value="" selected="selected">{lang key="pleaseChoose" section="global"}</option>
                     <option value="m" {if $cData_arr.cAnrede === 'm'}selected="selected"{/if}>{$Anrede_m}</option>
                     <option value="w" {if $cData_arr.cAnrede === 'w'}selected="selected"{/if}>{$Anrede_w}</option>
                  </select>
                  {if $cMissing_arr.cAnrede>0}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
            </div>

            <div class="form-group{if $cMissing_arr.cInhaber>0} has-error{/if}">
               <label class="control-label col-xs-4" for="cInhaber">Inhaber</label>
                  <input class="form-control" type="text" name="cInhaber" value="{$cData_arr.cInhaber}" id="cInhaber" />
                  {if $cMissing_arr.cInhaber>0}
                     <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                  {/if}
            </div>
            *}
                <div class="form-group{if $cMissing_arr.cRechtsform>0} has-error{/if} required">
                    <label class="control-label col-xs-4" for="salutation">Rechtsform</label>
                        <select class="form-control" name="cRechtsform" id="salutation">
                            <optgroup label="{lang key="pleaseChoose" section="global"}">
                                {if $cCountryISO === 'DEU'}
                                    <option value="ek" {if $cData_arr.cRechtsform === "ek"}selected="selected"{/if}>EK
                                        (eingetragener Kaufmann)
                                    </option>
                                    <option value="gbr" {if $cData_arr.cRechtsform === "gbr"}selected="selected"{/if}>
                                        GbR/BGB (Gesellschaft b&uuml;rgerlichen Rechts)
                                    </option>
                                    <option value="gmbh_ig" {if $cData_arr.cRechtsform === "gmbh_ig"}selected="selected"{/if}>
                                        GmbH in Gr&uuml;ndung
                                    </option>
                                    <option value="gmbh_co_kg" {if $cData_arr.cRechtsform === "gmbh_co_kg"}selected="selected"{/if}>
                                        GmbH &amp; Co. KG
                                    </option>
                                    <option value="ltd_co_kg" {if $cData_arr.cRechtsform === "ltd_co_kg"}selected="selected"{/if}>
                                        Limited &amp; Co. KG
                                    </option>
                                    <option value="ohg" {if $cData_arr.cRechtsform === "ohg"}selected="selected"{/if}>OHG
                                        (offene Handelsgesellschaft)
                                    </option>
                                    <option value="ug" {if $cData_arr.cRechtsform === "ug"}selected="selected"{/if}>UG
                                        (Unternehmensgesellschaft haftungsbeschr&auml;nkt)
                                    </option>
                                {elseif $cCountryISO === 'CHE'}
                                    <option value="einzel" {if $cData_arr.cRechtsform === "einzel"}selected="selected"{/if}>
                                        Einzelfirma
                                    </option>
                                    <option value="e_ges" {if $cData_arr.cRechtsform === "e_ges"}selected="selected"{/if}>
                                        Einfache Gesellschaft
                                    </option>
                                    <option value="inv_kk" {if $cData_arr.cRechtsform === "inv_kk"}selected="selected"{/if}>
                                        Investmentgesellschaft f&uuml;r kollektive Kapitalanlagen
                                    </option>
                                    <option value="k_ges" {if $cData_arr.cRechtsform === "k_ges"}selected="selected"{/if}>
                                        Kollektivgesellschaft
                                    </option>
                                {/if}
                            </optgroup>
                            <optgroup label="Weitere Rechtsformen">
                                <option value="eg" {if $cData_arr.cRechtsform === "eg"}selected="selected"{/if}>eG
                                    (eingetragene Genossenschaft)
                                </option>
                                <option value="ag" {if $cData_arr.cRechtsform === "ag"}selected="selected"{/if}>AG
                                </option>
                                <option value="ev" {if $cData_arr.cRechtsform === "ev"}selected="selected"{/if}>e.V.
                                    (eingetragener Verein)
                                </option>
                                <option value="freelancer" {if $cData_arr.cRechtsform === "freelancer"}selected="selected"{/if}>
                                    Freiberufler/Kleingewerbetreibender/Handelsvertreter
                                </option>
                                <option value="gmbh" {if $cData_arr.cRechtsform === "gmbh"}selected="selected"{/if}>GmbH
                                    (Gesellschaft mit beschr&auml;nkter Haftung)
                                </option>
                                <option value="kg" {if $cData_arr.cRechtsform === "kg"}selected="selected"{/if}>KG
                                    (Kommanditgesellschaft)
                                </option>
                                <option value="kgaa" {if $cData_arr.cRechtsform === "kgaa"}selected="selected"{/if}>
                                    Kommanditgesellschaft auf Aktien
                                </option>
                                <option value="ltd" {if $cData_arr.cRechtsform === "ltd"}selected="selected"{/if}>
                                    Limited
                                </option>
                                <option value="public_inst" {if $cData_arr.cRechtsform === "public_inst"}selected="selected"{/if}>
                                    &ouml;ffentliche Einrichtung
                                </option>
                                <option value="misc_capital" {if $cData_arr.cRechtsform === "misc_capital"}selected="selected"{/if}>
                                    Sonstige Kapitalgesellschaft
                                </option>
                                <option value="misc" {if $cData_arr.cRechtsform === "misc"}selected="selected"{/if}>
                                    Sonstige Personengesellschaft
                                </option>
                                <option value="foundation" {if $cData_arr.cRechtsform === "foundation"}selected="selected"{/if}>
                                    Stiftung
                                </option>
                            </optgroup>
                        </select>
                        {if $cMissing_arr.cRechtsform>0}
                            <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
                </div>

                <div class="form-group{if $cMissing_arr.cFirma>0} has-error{/if} required">
                    <label class="control-label" for="cFirma">Firmenname</label>
                    <input class="form-control" type="text" name="cFirma" value="{$cData_arr.cFirma}" id="cFirma">
                    {if $cMissing_arr.cFirma>0}
                        <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                    {/if}
                </div>

                <div class="form-group{if $cMissing_arr.cUSTID>0} has-error{/if}">
                    <label class="control-label" for="cUSTID">USt-IdNr.</label>
                    <input class="form-control" type="text" name="cUSTID" value="{$cData_arr.cUSTID}" id="cUSTID">
                    {if $cMissing_arr.cUSTID>0}
                        <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                    {/if}
                </div>

                <div class="form-group{if $cMissing_arr.cHrn>0} has-error{/if}">
                    <label class="control-label" for="cHrn">Handelsregisternummer</label>
                    <input class="form-control" type="text" name="cHrn" value="{$cData_arr.cHrn}" id="cHrn">
                    {if $cMissing_arr.cHrn>0}
                        <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                    {/if}
                </div>
            </div>
        </fieldset>
    {/if}

    <div id="billpay_agb_def">
        <fieldset>
            <legend>Weitere Informationen</legend>
            <div class="btn-group">
                <a class="btn btn-default popup" href="{$cBillpayTermsURL}" target="_blank">AGB</a>
                <a class="btn btn-default popup" href="{$cBillpayTermsURL}#datenschutz" target="_blank">Datenschutzbestimmungen</a>
            </div>
        </fieldset>
    </div>

    <div class="checkbox{if $cMissing_arr.billpay_accepted} has-error{/if}">
        <label for="billpay_accepted">
            <input type="checkbox" name="billpay_accepted" id="billpay_accepted" /> Mit der &Uuml;bermittlung der f&uuml;r
            die Abwicklung des Rechnungskaufs und einer Identit&auml;ts
            und Bonit&auml;tspr&uuml;fung <br />erforderlichen Daten an die
            <a href='https://billpay.de/endkunden' target='blank'> Billpay GmbH</a> bin ich einverstanden. Es gelten die
            <a href="{$cBillpayTermsURL}#datenschutz" class="popup" target="_blank">Datenschutzbestimmungen</a>
            von Billpay.
            {if $cMissing_arr.billpay_accepted}
                <div class="alert alert-danger">Bitte best&auml;tigen</div>
            {/if}
        </label>
    </div>

</fieldset>