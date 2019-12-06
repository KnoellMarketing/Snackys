<div class="modal modal-dialog blanklist" tabindex="-1" id="login-popup">
	<div class="modal-content">
		<div class="modal-header">
			<span class="modal-title block h5">
				{if empty($smarty.session.Kunde->kKunde)}
					{lang key="login" section="global"}
				{else}
					{lang key='myAccount'}
				{/if}
			</span>
			<button type="button" class="close-btn" data-dismiss="modal" aria-label="Close">
			</button>
		</div>
		<div class="modal-body">
		{if empty($smarty.session.Kunde->kKunde)}
			<form action="{get_static_route id='jtl.php' secure=true}" method="post" class="form evo-validate">
				{$jtl_token}
				<div class="form-group">
					<label for="email_quick">{lang key='emailadress'}</label>
					<input type="email" name="email" id="email_quick" class="form-control" placeholder="{lang key='emailadress'}" required spellcheck="false" autocorrect="off"/>
				</div>
				<div class="form-group">
					<label for="password_quick">{lang key='password'}</label>
					<input type="password"  autocomplete="on" name="passwort" id="password_quick" class="form-control" placeholder="{lang key='password'}" required/>
				</div>
				{if isset($showLoginCaptcha) && $showLoginCaptcha}
					<div class="form-group text-center float-label-control">
						<div class="g-recaptcha" data-sitekey="{$Einstellungen.global.global_google_recaptcha_public}" data-callback="captcha_filled"></div>
					</div>
				{/if}
				<div class="form-group">
					<input type="hidden" name="login" value="1"/>
					{if !empty($oRedirect->cURL)}
						{foreach name=parameter from=$oRedirect->oParameter_arr item=oParameter}
							<input type="hidden" name="{$oParameter->Name}" value="{$oParameter->Wert}" />
						{/foreach}
						<input type="hidden" name="r" value="{$oRedirect->nRedirect} "/>
						<input type="hidden" name="cURL" value="{$oRedirect->cURL}" />
					{/if}
					<button type="submit" id="submit-btn" class="btn btn-primary btn-block btn-lg">{lang key="login" section="global"}</button>
				</div>
			</form>
            <div class="text-center">
				<a href="{get_static_route id='pass.php'}" rel="nofollow" title="{lang key='forgotPassword'}" class="link-underline">{lang key='forgotPassword'}?</a>
            </div>
			<hr>
			<span class="text-center block h4">{lang key='newHere'}</span>
			<a href="{get_static_route id='registrieren.php'}" title="{lang key='registerNow'}" class="btn btn-block btn-lg">{lang key='registerNow'}</a>
    {else}
			<div class="styled-list">
				<a href="{get_static_route id='jtl.php' secure=true}" title="{lang key='myAccount'}" class="dpflex-a-center list-entry defaultlink">
					<span class="img-ct icon icon-wt">
						<svg>
						  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-user"></use>
						</svg>
					</span>
					{lang key="accountOverview" section="account data"}
				</a>
				<a href="{get_static_route id='jtl.php' params=['bestellungen' => 1]}" class="dpflex-a-center list-entry defaultlink">
					<span class="img-ct icon icon icon-wt">
						<svg>
						  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-cart"></use>
						</svg>
					</span>
					{lang key="orders" section="account data"}
				</a>
				<a href="{get_static_route id='jtl.php' params=['editRechnungsadresse' => 1]}" class="dpflex-a-center list-entry defaultlink">
					<span class="img-ct icon icon icon-wt">
						<svg>
						  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-house"></use>
						</svg>
					</span>
					{lang key="addresses" section="account data"}
				</a>
				{if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
					<a href="{get_static_route id='jtl.php' params=['wllist' => 1]}" class="dpflex-a-center list-entry defaultlink">
						<span class="img-ct icon icon icon-wt">
							<svg>
							  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-heart"></use>
							</svg>
						</span>
						{lang key="wishlists" section="account data"}
					</a>
				{/if}
			</div>
			<a href="{get_static_route id='jtl.php' secure=true}?logout=1" title="{lang key='logOut'}" class="btn btn-block">{lang key='logOut'}</a>
    	{/if}
		</div>
	</div>
</div>