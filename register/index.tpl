{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
    {if $step === 'formular'}
        {if isset($checkout) && $checkout == 1}
            {include file='checkout/inc_steps.tpl'}
            {if !empty($smarty.session.Kunde->kKunde)}
                {lang key="changeBillingAddress" section="account data" assign="panel_heading"}
            {else}
                {lang key="createNewAccount" section="account data" assign="panel_heading"}
            {/if}
        {/if}
    
        {include file="snippets/extension.tpl"}
        {if !empty($hinweis)}
            <div class="alert alert-info">{$hinweis}</div>
        {/if}
        {if !empty($fehlendeAngaben) && !$hinweis}
            <div class="alert alert-danger">{lang key="yourDataDesc" section="account data"}</div>
        {/if}
        {if isset($fehlendeAngaben.email_vorhanden) && $fehlendeAngaben.email_vorhanden == 1}
            <div class="alert alert-danger">{lang key="emailAlreadyExists" section="account data"}</div>
        {/if}
        {if isset($fehlendeAngaben.formular_zeit) && $fehlendeAngaben.formular_zeit == 1}
            <div class="alert alert-danger">{lang key="formToFast" section="account data"}</div>
        {/if}
        <div id="new_customer" class="row">
        <div class="col-xs-12">
            {if !isset($checkout) && empty($smarty.session.Kunde->kKunde)}
                <h1>{lang key="createNewAccount" section="account data"}</h1>
            {/if}
            <div class="panel-wrap" id="panel-register-form">
                {include file='register/form.tpl'}
            </div>
        </div>
    </div>
                        
    
    {elseif $step === 'formular eingegangen'}
        <h1>{lang key="accountCreated" section="global"}</h1>
        <p>{lang key="activateAccountDesc" section="global"}</p>
    {/if}
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}