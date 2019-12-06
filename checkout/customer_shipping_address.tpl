{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

{$name = 'shipping_address'}
{* salutation / title *}
<div class="row">
    {if $Einstellungen.kunden.lieferadresse_abfragen_anrede !== 'N'}
        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control{if !empty($fehlendeAngaben.anrede)} has-error{/if} required">
                <label for="{$prefix}-{$name}-salutation" class="control-label">{lang key="salutation" section="account data"}</label>
                <select name="{$prefix}[{$name}][anrede]" id="{$prefix}-{$name}-salutation" class="form-control" required>
                    <option value="" selected="selected" disabled>{lang key="salutation" section="account data"}</option>
                    <option value="w"{if isset($Lieferadresse->cAnrede) && $Lieferadresse->cAnrede === 'w'} selected="selected"{/if}>{$Anrede_w}</option>
                    <option value="m"{if isset($Lieferadresse->cAnrede) && $Lieferadresse->cAnrede === 'm'} selected="selected"{/if}>{$Anrede_m}</option>
                </select>
                {if !empty($fehlendeAngaben.anrede)}
                    <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                {/if}
            </div>
        </div>
    {/if}
    {if $Einstellungen.kunden.lieferadresse_abfragen_titel !== 'N'}
        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control{if !empty($fehlendeAngaben.titel)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_titel === 'Y'} required{/if}">
                <label for="{$prefix}-{$name}-title" class="control-label">{lang key="title" section="account data"}</label>
                <input type="text" name="{$prefix}[{$name}][titel]" value="{if isset($Lieferadresse->cTitel)}{$Lieferadresse->cTitel}{/if}" id="{$prefix}-{$name}-title" class="form-control" placeholder="{lang key="title" section="account data"}"{if $Einstellungen.kunden.lieferadresse_abfragen_titel === 'Y'} required{/if}>
                {if !empty($fehlendeAngaben.titel)}
                    <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                {/if}
            </div>
        </div>
    {/if}
</div>

{* firstname lastname *}
<div class="row">
    <div class="col-xs-12 col-md-6">
        <div class="form-group float-label-control{if !empty($fehlendeAngaben.vorname)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_pflicht_vorname === 'Y'} required{/if}">
            <label for="{$prefix}-{$name}-firstName" class="control-label">{lang key="firstName" section="account data"}</label>
            <input type="text" name="{$prefix}[{$name}][vorname]" value="{if isset($Lieferadresse->cVorname)}{$Lieferadresse->cVorname}{/if}" id="{$prefix}-{$name}-firstName" class="form-control" placeholder="{lang key="firstName" section="account data"}"{if $Einstellungen.kunden.kundenregistrierung_pflicht_vorname === 'Y'} required{/if}>
            {if !empty($fehlendeAngaben.vorname)}
                {if $fehlendeAngaben.vorname == 1}
                    <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                {elseif $fehlendeAngaben.vorname == 2}
                    <div class="alert alert-danger">{lang key="firstNameNotNumeric" section="account data"}</div>
                {/if}
            {/if}
        </div>
    </div>
    <div class="col-xs-12 col-md-6">
        <div class="form-group float-label-control{if !empty($fehlendeAngaben.nachname)} has-error{/if} required">
            <label for="{$prefix}-{$name}-lastName" class="control-label">{lang key="lastName" section="account data"}</label>
            <input type="text" name="{$prefix}[{$name}][nachname]" value="{if isset($Lieferadresse->cNachname)}{$Lieferadresse->cNachname}{/if}" id="{$prefix}-{$name}-lastName" class="form-control" placeholder="{lang key="lastName" section="account data"}" required />
            {if !empty($fehlendeAngaben.nachname)}
                {if $fehlendeAngaben.nachname == 1}
                    <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                {elseif $fehlendeAngaben.nachname == 2}
                    <div class="alert alert-danger">{lang key="lastNameNotNumeric" section="account data"}</div>
                {/if}
            {/if}
        </div>
    </div>
</div>

{* firm / firmtext *}
<div class="row">
    {if $Einstellungen.kunden.kundenregistrierung_abfragen_firma !== 'N'}
        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control{if !empty($fehlendeAngaben.firma)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_firma === 'Y'} required{/if}">
                <label for="{$prefix}-{$name}-firm" class="control-label">{lang key="firm" section="account data"}</label>
                <input type="text" name="{$prefix}[{$name}][firma]" value="{if isset($Lieferadresse->cFirma)}{$Lieferadresse->cFirma}{/if}" id="{$prefix}-{$name}-firm" class="form-control" placeholder="{lang key="firm" section="account data"}"{if $Einstellungen.kunden.kundenregistrierung_abfragen_firma === 'Y'} required{/if}>
                {if !empty($fehlendeAngaben.firma)}
                    <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                {/if}
            </div>
        </div>
    {/if}
    {if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz !== 'N'}
        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control{if !empty($fehlendeAngaben.firmazusatz)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz === 'Y'} required{/if}">
                <label for="{$prefix}-{$name}-firmext" class="control-label">{lang key="firmext" section="account data"}</label>
                <input type="text" name="{$prefix}[{$name}][firmazusatz]" value="{if isset($Lieferadresse->cZusatz)}{$Lieferadresse->cZusatz}{/if}" id="{$prefix}-{$name}-firmext" class="form-control" placeholder="{lang key="firmext" section="account data"}"{if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz === 'Y'} required{/if}>
                {if !empty($fehlendeAngaben.firmazusatz)}
                    <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                {/if}
            </div>
        </div>
    {/if}
</div>

{* street / number *}
<div class="row">
    <div class="col-xs-12 col-md-6">
        <div class="form-group float-label-control{if !empty($fehlendeAngaben.strasse)} has-error{/if} required">
            <label class="control-label" for="{$prefix}-{$name}-street">{lang key="street" section="account data"}</label>
            <input type="text" name="{$prefix}[{$name}][strasse]" value="{if isset($Lieferadresse->cStrasse)}{$Lieferadresse->cStrasse}{/if}" id="{$prefix}-{$name}-street" class="form-control" placeholder="{lang key="street" section="account data"}*" required>
            {if !empty($fehlendeAngaben.strasse)}
                <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
            {/if}
        </div>
    </div>
    <div class="col-xs-12 col-md-6">
        <div class="form-group float-label-control{if !empty($fehlendeAngaben.hausnummer)} has-error{/if} required">
            <label class="control-label" for="{$prefix}-{$name}-streetnumber">{lang key="streetnumber" section="account data"}</label>
            <input type="text" name="{$prefix}[{$name}][hausnummer]" value="{if isset($Lieferadresse->cHausnummer)}{$Lieferadresse->cHausnummer}{/if}" id="{$prefix}-{$name}-streetnumber" class="form-control" placeholder="{lang key="streetnumber" section="account data"}*" required />
            {if !empty($fehlendeAngaben.hausnummer)}
                <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
            {/if}
        </div>
    </div>
</div>

{* adress addition *}
{if $Einstellungen.kunden.lieferadresse_abfragen_adresszusatz !== 'N'}
    <div class="row">
        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control{if !empty($fehlendeAngaben.adresszusatz)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_adresszusatz === 'Y'} required{/if}">
                <label class="control-label" for="{$prefix}-{$name}-street2">{lang key="street2" section="account data"}</label>
                <input type="text" name="{$prefix}[{$name}][adresszusatz]" value="{if isset($Lieferadresse->cAdressZusatz)}{$Lieferadresse->cAdressZusatz}{/if}" id="{$prefix}-{$name}-street2" class="form-control" placeholder="{lang key="street2" section="account data"}"{if $Einstellungen.kunden.lieferadresse_abfragen_adresszusatz === 'Y'} required{/if}>
                {if !empty($fehlendeAngaben.adresszusatz)}
                    <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                {/if}
            </div>
        </div>
    </div>
{/if}

{* country *}
<div class="row">
    <div class="col-xs-12 col-md-6">
        <div class="form-group float-label-control">
            <label class="control-label" for="{$prefix}-{$name}-country">{lang key="country" section="account data"}</label>
            <select name="{$prefix}[{$name}][land]" id="{$prefix}-{$name}-country" class="country_input form-control">
                <option value="" selected disabled>{lang key="country" section="account data"}*</option>
                {foreach name=land from=$LieferLaender item=land}
                    <option value="{$land->cISO}" {if ($Einstellungen.kunden.kundenregistrierung_standardland == $land->cISO && empty($Lieferadresse->cLand)) || (isset($Lieferadresse->cLand) && $Lieferadresse->cLand == $land->cISO)}selected="selected"{/if}>{$land->cName}</option>
                {/foreach}
            </select>
        </div>
    </div>
    {if $Einstellungen.kunden.lieferadresse_abfragen_bundesland !== 'N'}
        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control{if !empty($fehlendeAngaben.bundesland)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_bundesland === 'Y'} required{/if}">
                <label class="control-label" for="{$prefix}-{$name}-state">{lang key="state" section="account data"}</label>
                <input
                    type="text"
                    title="{lang key=pleaseChoose}"
                    name="{$prefix}[{$name}][bundesland]"
                    value="{if isset($Lieferadresse->cBundesland)}{$Lieferadresse->cBundesland}{/if}"
                    id="{$prefix}-{$name}-state"
                    class="form-control"
                    data-toggle="state" data-target="#{$prefix}-{$name}-country"
                    placeholder="{lang key="state" section="account data"}"{if $Einstellungen.kunden.lieferadresse_abfragen_bundesland === 'Y'} required{/if}>

                {if !empty($fehlendeAngaben.bundesland)}
                    <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                {/if}
            </div>
        </div>
    {/if}
</div>

{* zip / city *}
<div class="row">
    <div class="col-xs-12 col-md-6">
        <div class="form-group float-label-control{if !empty($fehlendeAngaben.plz)} has-error{/if} required">
            <label class="control-label" for="{$prefix}-{$name}-postcode">{lang key="plz" section="account data"}</label>
            <input
                type="text"
                name="{$prefix}[{$name}][plz]"
                value="{if isset($Lieferadresse->cPLZ)}{$Lieferadresse->cPLZ}{/if}"
                id="{$prefix}-{$name}-postcode"
                class="postcode_input form-control"
                placeholder="{lang key="plz" section="account data"}"
                data-toggle="postcode" data-city="#{$prefix}-{$name}-city" data-country="#{$prefix}-{$name}-country"
                required>
            {if !empty($fehlendeAngaben.plz)}
                <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
        </div>
    </div>

    <div class="col-xs-12 col-md-6">
        <div class="form-group float-label-control{if !empty($fehlendeAngaben.ort)} has-error{/if} required">
            <label class="control-label" for="{$prefix}-{$name}-city">{lang key="city" section="account data"}</label>
            <input type="text" name="{$prefix}[{$name}][ort]" value="{if isset($Lieferadresse->cOrt)}{$Lieferadresse->cOrt}{/if}" id="{$prefix}-{$name}-city" class="city_input form-control" placeholder="{lang key="city" section="account data"}" required>
            {if !empty($fehlendeAngaben.ort)}
                {if $fehlendeAngaben.ort == 3}
                    <div class="alert alert-danger">{lang key="cityNotNumeric" section="account data"}</div>
                {else}
                    <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                {/if}
            {/if}
        </div>
    </div>
</div>