<h1>{lang key="changePassword" section="login"}</h1>

{include file="snippets/extension.tpl"}

{block name="change-password-form"}
<div class="panel-wrap">
    {if empty($hinweis)}
        <p class="alert alert-info">{lang key="changePasswordDesc" section="login"}</p>
    {/if}
    {if !empty($cFehler)}
        <p class="alert alert-danger">{$cFehler}</p>
    {/if}
    <div class="row">
        <form id="password" action="{get_static_route id='jtl.php'}" method="post" class="col-xs-12 evo-validate">
            {$jtl_token}
            <div class="form-group required">
                <label for="currentPassword" class="control-label">{lang key="currentPassword" section="login"}</label>
                <input type="password" name="altesPasswort" id="currentPassword" class="form-control" required>
            </div>

            <div class="form-group required">
                <label for="newPassword" class="control-label">{lang key="newPassword" section="login"}</label>
                <input type="password" name="neuesPasswort1" id="newPassword" class="form-control" required>
            </div>

            <div class="form-group required">
                <label for="newPasswordRpt" class="control-label">{lang key="newPasswordRpt" section="login"}</label>
                <input type="password" name="neuesPasswort2" id="newPasswordRpt" class="form-control" required>
            </div>

            <div class="form-group">
                <input type="hidden" name="pass_aendern" value="1">
                <input type="submit" value="{lang key="changePassword" section="login"}" class="submit btn btn-primary btn-block">
            </div>
        </form>
    </div>
</div>
{/block}