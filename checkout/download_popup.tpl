{assign var=bExclusive value=true}
{include file='layout/header.tpl'}

<script type="text/javascript">
    {literal}
    $(document).ready(function () {
        var h = $('#popup_wrapper').outerHeight();
        window.resizeBy(0, h - $(window).height());

        $('img').load(function () {
            var h = $('#popup_wrapper').outerHeight();
            window.resizeBy(0, h - $(window).height());
        });
    });
    {/literal}
</script>

<div id="popup_wrapper">
    <div id="popup">
        {if $bNoData}
            <div class="alert alert-danger">{lang key="pageNotFound"}</div>
        {else}
            {if $cAction === 'download_vorschau'}
                {include file='account/download_preview.tpl'}
            {/if}
        {/if}
    </div>
</div>