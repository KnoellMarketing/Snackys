{if $Einstellungen.kunden.lieferadresse_abfragen_tel !== 'N'
    || $Einstellungen.kunden.lieferadresse_abfragen_fax !== 'N'
    || $Einstellungen.kunden.lieferadresse_abfragen_email !== 'N'
    || $Einstellungen.kunden.lieferadresse_abfragen_mobil !== 'N'}
{$name = 'shipping_address'}
<fieldset>
    <legend>{lang key="contactInformation" section="account data"}</legend>
    {* E-Mail & mobil *}
    {if $Einstellungen.kunden.lieferadresse_abfragen_email !== 'N' || $Einstellungen.kunden.lieferadresse_abfragen_mobil !== 'N'}
    <div class="row">
        {if $Einstellungen.kunden.lieferadresse_abfragen_email !== 'N'}
        <div class="col-xs-12 col-md-6">
            <div class="form-group float-label-control{if $Einstellungen.kunden.lieferadresse_abfragen_email === 'Y'} required{/if}{if isset($fehlendeAngaben.email)} has-error{/if}">
                <label class="control-label" for="email">{lang key="email" section="account data"}</label>
                <input
                        type="email"
                        name="{$prefix}[{$name}][email]"
                        value="{if isset($Lieferadresse->cMail)}{$Lieferadresse->cMail}{/if}"
                        id="{$prefix}-{$name}-email"
                        class="form-control"
                        placeholder="{lang key="email" section="account data"}"
                        {if $Einstellungen.kunden.lieferadresse_abfragen_email === 'Y'}required{/if} spellcheck="false"  autocorrect="off"
                >
                {if isset($fehlendeAngaben.email)}
                    <div class="form-error-msg text-danger">
                        {if $fehlendeAngaben.email == 1}
                            {lang key="fillOut" section="global"}
                        {elseif $fehlendeAngaben.email == 2}
                            {lang key="invalidEmail" section="global"}
                        {elseif $fehlendeAngaben.email == 3}
                            {lang key="blockedEmail" section="global"}
                        {elseif $fehlendeAngaben.email == 4}
                            {lang key="noDnsEmail" section="account data"}
                        {elseif $fehlendeAngaben.email == 5}
                            {lang key="emailNotAvailable" section="account data"}
                        {/if}
                    </div>
                {/if}
            </div>
        </div>
        {/if}
        {if $Einstellungen.kunden.lieferadresse_abfragen_mobil !== 'N'}
            <div class="col-xs-12 col-md-6">
                <div class="form-group float-label-control{if isset($fehlendeAngaben.mobil)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_mobil === 'Y'} required{/if} ">
                    <label class="control-label" for="mobile">{lang key="mobile" section="account data"}</label>
                    <input
                            type="tel"
                            name="{$prefix}[{$name}][mobil]"
                            value="{if isset($Lieferadresse->cMobil)}{$Lieferadresse->cMobil}{/if}"
                            id="{$prefix}-{$name}-mobile"
                            class="form-control"
                            placeholder="{lang key="mobile" section="account data"}"
                            {if $Einstellungen.kunden.lieferadresse_abfragen_mobil === 'Y'} required{/if} {if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternMobil)}pattern="{$snackyConfig.patternMobil}"{/if} spellcheck="false"  autocorrect="off"
                    />
                    {if isset($fehlendeAngaben.mobil)}
                        <div class="form-error-msg text-danger">
                            {if $fehlendeAngaben.mobil == 1}
                                {lang key="fillOut" section="global"}
                            {elseif $fehlendeAngaben.mobil == 2}
                                {lang key="invalidTel" section="global"}
                            {/if}
                        </div>
                    {/if}
                </div>
            </div>
        {/if}
    </div>
    {/if}
    {if $Einstellungen.kunden.lieferadresse_abfragen_tel !== 'N' || $Einstellungen.kunden.lieferadresse_abfragen_fax !== 'N'}
    <div class="row">
        {if $Einstellungen.kunden.lieferadresse_abfragen_tel !== 'N'}
            <div class="col-xs-12 col-md-6">
                <div class="form-group float-label-control{if isset($fehlendeAngaben.tel)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_tel === 'Y'} required{/if}">
                    <label class="control-label" for="tel">{lang key="tel" section="account data"}</label>
                    <input
                            type="tel"
                            name="{$prefix}[{$name}][tel]"
                            value="{if isset($Lieferadresse->cTel)}{$Lieferadresse->cTel}{/if}"
                            id="{$prefix}-{$name}-tel"
                            class="form-control"
                            placeholder="{lang key="tel" section="account data"}"
                            {if $Einstellungen.kunden.lieferadresse_abfragen_tel === 'Y'} required{/if} {if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternTelefon)}pattern="{$snackyConfig.patternTelefon}"{/if} spellcheck="false"  autocorrect="off"
                    />
                    {if isset($fehlendeAngaben.tel)}
                        <div class="form-error-msg text-danger">
                            {if $fehlendeAngaben.tel == 1}
                                {lang key="fillOut" section="global"}
                            {elseif $fehlendeAngaben.tel == 2}
                                {lang key="invalidTel" section="global"}
                            {/if}
                        </div>
                    {/if}
                </div>
            </div>
        {/if}
        {if $Einstellungen.kunden.lieferadresse_abfragen_fax !== 'N'}
            <div class="col-xs-12 col-md-6">
                <div class="form-group float-label-control{if isset($fehlendeAngaben.fax)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_fax === 'Y'} required{/if}">
                    <label class="control-label" for="fax">{lang key="fax" section="account data"}</label>
                    <input
                            type="tel"
                            name="{$prefix}[{$name}][fax]"
                            value="{if isset($Lieferadresse->cFax)}{$Lieferadresse->cFax}{/if}"
                            id="{$prefix}-{$name}-fax"
                            class="form-control"
                            placeholder="{lang key="fax" section="account data"}"
                            {if $Einstellungen.kunden.lieferadresse_abfragen_fax === 'Y'} required{/if} {if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternFax)}pattern="{$snackyConfig.patternFax}"{/if} spellcheck="false"  autocorrect="off"
                    />
                    {if isset($fehlendeAngaben.fax)}
                        <div class="form-error-msg text-danger">
                            {if $fehlendeAngaben.fax == 1}
                                {lang key="fillOut" section="global"}
                            {elseif $fehlendeAngaben.fax == 2}
                                {lang key="invalidTel" section="global"}
                            {/if}
                        </div>
                    {/if}
                </div>
            </div>
        {/if}
    </div>
    {/if}
</fieldset>
{/if}