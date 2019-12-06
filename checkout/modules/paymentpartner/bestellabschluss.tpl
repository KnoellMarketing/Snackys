<div style="margin:10px 0;">
    {if $status === 'error'}
        <strong>{$error}</strong>
    {else}
        {lang key="paymentpartnerDesc" section=""}
        {strip}
            <div>
                <a href="{$url}">
                    <img src="{$currentTemplateDir}../../gfx/PaymentPartner/logo.png" alt="PaymentPartner Logo" />
                </a>
            </div>
        {/strip}
    {/if}
</div>