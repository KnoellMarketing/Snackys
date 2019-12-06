<h1 class="text-center">{lang key="kwkName" section="login"}</h1>
{if !empty($cFehler)}
    <div class="alert alert-danger">{$cFehler}</div>
{/if}
{block name="customers-recruiting"}
<form id="kwk" action="{get_static_route id='jtl.php'}" method="post" class="form form-horizontal col-md-6 col-md-offset-3 evo-validate">
    {$jtl_token}
    <div class="form-group float-label-control required">
        <label for="kwkFirstName" class="control-label">{lang key="kwkFirstName" section="login"}</label>
        <input type="text" name="cVorname" id="kwkFirstName" class="form-control" required>
    </div>

    <div class="form-group float-label-control required">
        <label for="kwkLastName" class="control-label">{lang key="kwkLastName" section="login"}</label>
        <input type="text" name="cNachname" id="kwkLastName" class="form-control" required>
    </div>

    <div class="form-group float-label-control">
        <label for="kwkEmail" class="control-label">{lang key="kwkEmail" section="login"}</label>
        <input type="text" name="cEmail" id="kwkEmail" class="form-control" required>
    </div>

    <div class="form-group text-right">
        <input type="hidden" name="KwK" value="1">
        <input type="hidden" name="kunde_werben" value="1">
        <input type="submit" value="{lang key="kwkSend" section="login"}" class="submit btn btn-primary">
    </div>
</form>
{/block}