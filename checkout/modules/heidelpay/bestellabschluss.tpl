<div style="margin:10px 0;">
    {if $status === 'error'}
        <strong>{$error}</strong>
    {else}
        {lang key="heidelpayDesc" section=""}
        {strip}
            <div>
                <a href="{$url}">
                    <img src="{$currentTemplateDir}../../gfx/HeidelPay/logo.gif" alt="HeidelPay Logo" />
                </a>
            </div>
        {/strip}
    {/if}
</div>