<div style="margin:10px 0;">
    {if $status === 'error'}
        <strong>{$error}</strong>
    {else}
        {lang key="iclearDesc" section=""}
        {strip}
            <div>
                <a href="{$url}">
                    <img src="{$currentTemplateDir}../../gfx/iClear/logo.jpg" alt="iClear Logo" />
                </a>
            </div>
        {/strip}
    {/if}
</div>