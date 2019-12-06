<div style="margin:10px 0;">
    {lang key="postfinanceDesc" section=""}
    {strip}
    <div>
        {if $cFehler}
            <br />
            <div class="errorTip">
                {$cFehler}
            </div><br />
        {/if}
        {$iFrame}
    </div>
    {/strip}
</div>