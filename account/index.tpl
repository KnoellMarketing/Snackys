{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
{include file="snippets/extension.tpl"}
    {if isset($smarty.get.reg)}
        <div class="alert alert-success mb-spacer mb-small">{lang key="accountCreated" section="global"}</div>
    {elseif !isset($hinweis)}
        <div class="alert alert-info mb-spacer mb-small">{lang key="myAccountDesc" section="login"}</div>
    {elseif !empty($hinweis)}
        <div class="alert alert-info mb-spacer mb-small">{$hinweis}</div>
    {/if}
	
    {if (isset($nWarenkorb2PersMerge) && $nWarenkorb2PersMerge === 1)}
	<div class="modal-dialog modal-lg">
		<div class="modal-content">   
			<div class="modal-header"><h4 class="modal-title">{lang key="basket" section="global"}</h4></div> 
			<section class="tmp-modal-content">
				<div class="modal-body">
					{lang key="basket2PersMerge" section="login"}<div class="answer"><a href="{get_static_route id='bestellvorgang.php'}?basket2Pers=1">{lang key="yes" section="global"}</a><a href="javascript:void();" class="x">{lang key="no" section="global"}</a></div>
				</div>
			</section>
		</div>
	</div>
    {/if}
    
    {$showLoginPanel = true}
    {if $step === 'login' || (isset($editRechnungsadresse) && $editRechnungsadresse)}
        {$showLoginPanel = false}
    {/if}
    {include file="snippets/zonen.tpl" id="before_account" title="before_account"}
    <div id="account" class="row dpflex-j-between">
        {if $showLoginPanel}
            <div class="col-xs-12 col-md-3 col-lg-2 ">
                <ul class="styled-list img-brd blanklist border-box" id="account-list">
					<li class="list-entry">
						<h4>{lang key="myAccount" section="global"}</h4>
					</li>
                    <li class="list-entry">
						<a href="{get_static_route id='jtl.php'}" class="defaultlink block{if $step === 'mein Konto'} active{/if}">
						{if $step === 'mein Konto'}<strong>{/if}
                        	{lang key="accountOverview" section="account data"}
						{if $step === 'mein Konto'}</strong>{/if}
						</a>
					</li>
                    <li class="list-entry">
						<a href="{get_static_route id='jtl.php' params=['bestellungen' => 1]}" class="defaultlink block{if $step === 'bestellung' || $step === 'bestellungen'} active{/if}">
						{if $step === 'bestellung' || $step === 'bestellungen'}<strong>{/if}
                        {lang key="orders" section="account data"}
						{if $step === 'bestellung' || $step === 'bestellungen'}</strong>{/if}
						</a>
					</li>
                    <li class="list-entry">
						<a href="{get_static_route id='jtl.php' params=['editRechnungsadresse' => 1]}" class="defaultlink block{if $step === 'rechnungsdaten'} active{/if}">
						{if $step === 'rechnungsdaten'}<strong>{/if}
                        {lang key="addresses" section="account data"}
						{if $step === 'rechnungsdaten'}</strong>{/if}
						</a>
					</li>
                    {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
                        <li class="list-entry">
							<a href="{get_static_route id='jtl.php' params=['wllist' => 1]}" class="defaultlink block{if $step|substr:0:11 === 'wunschliste'} active{/if}">
							{if $step|substr:0:11 === 'wunschliste'}<strong>{/if}
                            {lang key="wishlists" section="account data"}
							{if $step|substr:0:11 === 'wunschliste'}</strong>{/if}
							</a>
						</li>
                    {/if}					
                </ul>
            </div>
        {/if}
    
        <div class="col-xs-12 {if !$showLoginPanel}col-md-12{else}col-md-9 col-lg-push-1{/if}">
            {if $step === 'login'}
                {include file='account/login.tpl'}
            {elseif $step === 'mein Konto'}
                {include file='account/my_account.tpl'}
            {elseif $step === 'rechnungsdaten'}
                {include file='account/address_form.tpl'}
            {elseif $step === 'passwort aendern'}
                {include file='account/change_password.tpl'}
            {elseif $step === 'bestellung'}
                <div id="order-details">
                    {include file='account/order_details.tpl'}
                </div>
            {elseif $step === 'bestellungen'}
                {include file='account/orders.tpl'}
            {elseif $step === 'account loeschen'}
                {include file='account/delete_account.tpl'}
            {elseif $step === 'wunschliste'}
                {include file='account/wishlists.tpl'}
            {elseif $step === 'wunschliste anzeigen'}
                {include file='account/wishlist.tpl'}
            {elseif $step === 'wunschliste versenden'}
                {include file='account/wishlist_email_form.tpl'}
            {elseif $step === 'kunden_werben_kunden'}
                {include file='account/customers_recruiting.tpl'}
            {/if}
        </div>
    </div>
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}