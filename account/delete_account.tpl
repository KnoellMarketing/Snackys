<h1>{lang key="deleteAccount" section="login"}</h1>

{if empty($hinweis)}
    <div class="alert alert-danger">{lang key="reallyDeleteAccount" section="login"}</div>
{/if}

<form id="delete_account" action="{get_static_route id='jtl.php'}" method="post">
    {$jtl_token}
    <input type="hidden" name="del_acc" value="1" />
    <input type="submit" class="submit btn btn-danger" value="{lang key="deleteAccount" section="login"}" />
</form>