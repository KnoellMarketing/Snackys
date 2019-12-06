{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
    <h1>{$CWunschliste->cName}{if $isCurrenctCustomer === false && isset($CWunschliste->oKunde->cVorname)} {lang key="from" section="product rating" alt_section="login,productDetails,productOverview,global,"} {$CWunschliste->oKunde->cVorname}{/if}</h1>
    
    {if !empty($cHinweis)}
        <div class="alert alert-info">{$cHinweis}</div>
    {/if}
    {if !empty($cFehler)}
        <div class="alert alert-danger">{$cFehler}</div>
    {/if}
    {if $step === 'wunschliste versenden' && $Einstellungen.global.global_wunschliste_freunde_aktiv === 'Y'}
        {*{include file='account/wishlist_email_form.tpl'}*}
        <h1>{lang key="wishlistViaEmail" section="login"}</h1>
        {if !empty($cHinweis)}
            <p class="alert alert-info">{$cHinweis}</p>
        {/if}
        <div class="row">
            <div class="col-xs-12">
                {block name="wishlist-email-form"}
                    <div class="panel-wrap">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h2 class="panel-title h3">{block name="wishlist-email-form-title"}{$CWunschliste->cName}{/block}</h2>
                            </div>
                            <div class="panel-body">
                                {block name="wishlist-email-form-body"}
                                    <form method="post" action="{get_static_route id='wunschliste.php'}" name="Wunschliste">
                                        {$jtl_token}
                                        <input type="hidden" name="wlvm" value="1"/>
                                        <input type="hidden" name="kWunschliste" value="{$CWunschliste->kWunschliste}"/>
                                        <input type="hidden" name="send" value="1"/>
                                        <label for="wishlist-email">{lang key="wishlistEmails" section="login"}{if $Einstellungen.global.global_wunschliste_max_email > 0} | {lang key="wishlistEmailCount" section="login"}: {$Einstellungen.global.global_wunschliste_max_email}{/if}</label>
                                        <textarea id="wishlist-email" name="email" rows="5" class="form-control"></textarea>
                                        <hr>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <button name="action" type="submit" value="sendViaMail" class="btn btn-primary">{lang key="wishlistSend" section="login"}</button>
                                            </div>
                                        </div>
                                    </form>
                                {/block}
                            </div>
                        </div>
                    </div>
                {/block}
            </div>
        </div>
    {else}
        {if $hasItems === true || !empty($wlsearch)}
            <div id="wishlist-search">
                <form method="post" action="{get_static_route id='wunschliste.php'}" name="WunschlisteSuche" class="form form-inline">
                    {$jtl_token}
                    {if $CWunschliste->nOeffentlich == 1 && !empty($cURLID)}
                        <input type="hidden" name="wlid" value="{$cURLID}" />
                    {else}
                        <input type="hidden" name="kWunschliste" value="{$CWunschliste->kWunschliste}" />
                    {/if}
                    <div class="input-group">
                        <input name="cSuche" size="35" type="text" value="{$wlsearch}" placeholder="{lang key="wishlistSearch" section="login"}" class="form-control" />
                        <span class="input-group-btn">
                            <button class="btn btn-default" name="action" value="search" type="submit"> {lang key="wishlistSearchBTN" section="login"}</button>
                            {if !empty($wlsearch)}
                                <a href="{get_static_route id='wunschliste.php'}?wl={$CWunschliste->kWunschliste}" class="btn btn-default">{lang key="wishlistRemoveSearch" section="login"}</a>
                            {/if}
                        </span>
                    </div>
                </form>
            </div>
        {/if}
        <form method="post" action="{get_static_route id='wunschliste.php'}{if $CWunschliste->nStandard != 1}?wl={$CWunschliste->kWunschliste}{/if}" name="Wunschliste" class="basket_wrapper{if $hasItems === true} top15{/if}">
            {$jtl_token}
            {block name="wishlist"}
                <input type="hidden" name="wla" value="1"/>
                <input type="hidden" name="kWunschliste" value="{$CWunschliste->kWunschliste}"/>
				{if $CWunschliste->nOeffentlich == 1 && !empty($cURLID)}
					<input type="hidden" name="wlid" value="{$cURLID}" />
				{/if}
                {if !empty($wlsearch)}
                    <input type="hidden" name="wlsearch" value="1"/>
                    <input type="hidden" name="cSuche" value="{$wlsearch}"/>
                {/if}
                {if !empty($CWunschliste->CWunschlistePos_arr)}
                    {if $isCurrenctCustomer === true}
                        <div id="edit-wishlist-name">
							<span class="input-group-addon block">
								<label for="wishlist-name">{lang key="name" section="global"}</label>
							</span>

							<div class="input-group">
								<input id="wishlist-name" type="text" class="form-control" placeholder="name" name="wishlistName" value="{$CWunschliste->cName}" />
								<div class="input-group-btn dpflex">
									<button type="submit" class="btn">
										<span class="img-ct icon">
											<svg>
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-save"></use>
											</svg>
										</span>
									</button>
								</div>
							</div>
                        </div>
                    {/if}
                    <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>{lang key="wishlistProduct" section="login"}</th>
                            <th class="hidden-xs hidden-sm">&nbsp;</th>
                            <th>{lang key="wishlistComment" section="login"}</th>
                            <th class="text-center">{lang key="wishlistPosCount" section="login"}</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach name=wunschlistepos from=$CWunschliste->CWunschlistePos_arr item=CWunschlistePos}
                            <tr>
                                <td class="img-col hidden-xs hidden-sm">
                                    <a href="{$CWunschlistePos->Artikel->cURL}">
                                        <img alt="{$CWunschlistePos->Artikel->cName}" src="{$CWunschlistePos->Artikel->cVorschaubild}" class="img-responsive">
                                    </a>
                                </td>
                                <td>
                                    <a href="{$CWunschlistePos->Artikel->cURL}">{$CWunschlistePos->cArtikelName}</a>
                                    {if $CWunschlistePos->Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
                                        <p>{lang key="priceOnApplication" section="global"}</p>
                                    {else}
                                        {if isset($CWunschlistePos->Artikel->Preise->strPreisGrafik_Detail)}
                                            {assign var=priceImage value=$CWunschlistePos->Artikel->Preise->strPreisGrafik_Detail}
                                        {else}
                                            {assign var=priceImage value=null}
                                        {/if}
                                        {include file="productdetails/price.tpl" Artikel=$CWunschlistePos->Artikel price_image=$priceImage tplscope="wishlist"}
                                    {/if}
                                    {foreach name=eigenschaft from=$CWunschlistePos->CWunschlistePosEigenschaft_arr item=CWunschlistePosEigenschaft}
                                        {if $CWunschlistePosEigenschaft->cFreifeldWert}
                                            <p>
                                            <b>{$CWunschlistePosEigenschaft->cEigenschaftName}:</b>
                                            {$CWunschlistePosEigenschaft->cFreifeldWert}{if $CWunschlistePos->CWunschlistePosEigenschaft_arr|@count > 1 && !$smarty.foreach.eigenschaft.last}</p>{/if}
                                        {else}
                                            <p>
                                            <b>{$CWunschlistePosEigenschaft->cEigenschaftName}:</b>
                                            {$CWunschlistePosEigenschaft->cEigenschaftWertName}{if $CWunschlistePos->CWunschlistePosEigenschaft_arr|@count > 1 && !$smarty.foreach.eigenschaft.last}</p>{/if}
                                        {/if}
                                    {/foreach}
                                </td>
                                <td class="hidden-xs">
                                    <textarea{if $isCurrenctCustomer !== true} readonly="readonly"{/if} class="form-control" rows="4" name="Kommentar_{$CWunschlistePos->kWunschlistePos}">{$CWunschlistePos->cKommentar}</textarea>
                                </td>
                                {if $CWunschlistePos->Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === "N"}
                                    <td></td>
                                    <td class="text-right">
                                        <div class="dpflex-j-end btn-group">
                                            <button href="{get_static_route id='jtl.php'}?wl={$CWunschliste->kWunschliste}&wlplo={$CWunschlistePos->kWunschlistePos}{if isset($wlsearch)}&wlsearch=1&cSuche={$wlsearch}{/if}"
                                               class="btn btn-default nowrap"
                                               title="{lang key="wishlistremoveItem" section="login"}">
                                                <span class="img-ct icon">
													<svg>
													  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
													</svg>
                                                </span>
                                            </button>
                                        </div>
                                    </td>
                                {else}
                                    <td>
                                        <input{if $isCurrenctCustomer !== true} readonly="readonly"{/if}
                                                name="Anzahl_{$CWunschlistePos->kWunschlistePos}"
                                                class="wunschliste_anzahl form-control" type="text" size="1"
                                                value="{$CWunschlistePos->fAnzahl|replace_delim}">{$CWunschlistePos->Artikel->cEinheit}
                                    </td>
                                    <td class="text-right">
                                        <div class="dpflex-j-end btn-group">
                                            {if $CWunschlistePos->Artikel->bHasKonfig}
                                                <a href="{$CWunschlistePos->Artikel->cURLFull}" class="btn btn-primary"
                                                   title="{lang key="product" section="global"} {lang key="configure" section="global"}">
                                                    
                                                </a>
                                            {else}
                                                <button name="addToCart" value="{$CWunschlistePos->kWunschlistePos}"
                                                        class="btn btn-primary nowrap"
                                                        title="{lang key="wishlistaddToCart" section="login"}">
                                                    {lang key="addToCart" section="global"}
                                                </button>
                                            {/if}
                                            {if $isCurrenctCustomer === true}
                                                <button name="remove" value="{$CWunschlistePos->kWunschlistePos}"
                                                   class="btn btn-default pr"
                                                   title="{lang key="wishlistremoveItem" section="login"}">
                                                    <span class="img-ct icon">
														<svg>
														  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
														</svg>
													</span>
                                                </button>
                                            {/if}
                                        </div>
                                    </td>
                                {/if}
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="pull-right btn-group">
                                <button class="btn btn-primary submit" name="action" value="addAllToCart">
                                    <span class="-xs">{lang key="wishlistAddAllToCart" section="login"}</span>
                                </button>
                                {if $isCurrenctCustomer === true}
                                    <button type="submit" title="{lang key="wishlistUpdate" section="login"}" class="btn btn-default" name="action" value="update">
                                        <span class="-xs">{lang key="wishlistUpdate" section="login"}</span>
                                    </button>
                                    <button class="btn btn-default submit" name="action" value="removeAll">
                                        <span class="-xs">{lang key="wishlistDelAll" section="login"}</span>
                                    </button>
                                {/if}
                            </div>
                        </div>
                    </div>
                {else}
                    <div class="alert alert-info">{lang key="noEntriesAvailable" section="global"}</div>
                {/if}
            {/block}
        </form>
        {if $isCurrenctCustomer === true}
            <div class="wishlist-actions top15">
                <div class="panel-heading">
                    <span class="panel-title block h5">{block name="wishlist-title"}{if $CWunschliste->nOeffentlich == 1}{lang key="wishlistURL" section="login"}{else}{/if}{/block}</span>
                </div>
                <div class="panel-body">
                    {block name="wishlist-body"}
                        {if $CWunschliste->nOeffentlich == 1}
                            <form method="post" action="{get_static_route id='wunschliste.php'}">
                                {$jtl_token}
                                <input type="hidden" name="kWunschliste" value="{$CWunschliste->kWunschliste}"/>
                                <div class="input-group">
                                    <input type="text" name="wishlist-url" readonly="readonly"
                                           value="{get_static_route id='wunschliste.php'}?wlid={$CWunschliste->cURLID}"
                                           class="form-control">
                                    <span class="input-group-btn pr">
                                        {if $Einstellungen.global.global_wunschliste_freunde_aktiv === 'Y'}
                                            <button type="submit" name="action" value="sendViaMail"
                                                    {if !$hasItems} disabled="disabled"{/if}
                                                    class="btn btn-default"
                                                    title="{lang key="wishlistViaEmail" section="login"}">
                                               <span class="img-ct icon">
												<svg>
												  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-mail"></use>
												</svg>
												</span>
                                           </button>
                                        {/if}
                                    </span>
                                </div>
                            </form>
                        {else}
                            <div class="alert alert-info">
                            {lang key="wishlistNoticePrivate" section="login"}&nbsp;</div>
                        {/if}
                    {/block}
                </div>
            </div>
    
            {*@todo*}
            {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
                {block name="account-wishlist"}
                    <div id="wishlist" class="panel panel-default">
                        <div class="panel-heading">
                            <h2 class="panel-title h3">{block name="account-wishlist-title"}{lang key="yourWishlist" section="login"}{/block}</h2>
                        </div>
                        <div class="panel-body">
                            {block name="account-wishlist-body"}
                                {if !empty($oWunschliste_arr[0]->kWunschliste)}
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>{lang key="wishlistName" section="login"}</th>
                                            <th>{lang key="wishlistStandard" section="login"}</th>
                                            <th></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach name=wunschlisten from=$oWunschliste_arr item=Wunschliste}
                                            <tr>
                                                <td>
                                                    <a href="{get_static_route id='wunschliste.php'}{if $Wunschliste->nStandard != 1}?wl={$Wunschliste->kWunschliste}{/if}">{$Wunschliste->cName}</a>
                                                </td>
                                                <td>{if $Wunschliste->nStandard == 1}{lang key="active" section="global"}{/if} {if $Wunschliste->nStandard == 0}{lang key="inactive" section="global"}{/if}</td>
                                                <td class="text-right pr">
                                                    <form method="post" action="{get_static_route id='wunschliste.php'}">
                                                        {$jtl_token}
                                                        <input type="hidden" name="kWunschliste" value="{$CWunschliste->kWunschliste}"/>
                                                        <input type="hidden" name="kWunschlisteTarget" value="{$Wunschliste->kWunschliste}"/>
                                                        <span class="btn-group btn-group-sm">
                                                            {if $Wunschliste->nStandard != 1}
                                                                <button class="btn btn-default" name="action" value="setAsDefault">
                                                                    <span class="img-ct icon">
																		<svg>
																		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-check"></use>
																		</svg>
																	</span> <span class="hidden-xs">{lang key="wishlistStandard" section="login"}</span>
                                                                </button>
                                                            {else}
                                                                <button class="btn btn-success disabled" name="action" value="setAsDefault">
                                                                <span class="img-ct icon">
																	<svg>
																	  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-check-w"></use>
																	</svg>
																</span>
                                                                    <span class="hidden-xs">{lang key="wishlistStandard" section="login"}</span>
                                                                </button>
                                                            {/if}
                                                            {if $Wunschliste->nOeffentlich == 1}
                                                                <button type="submit" name="action" value="setPrivate"
                                                                        class="btn btn-default"
                                                                        title="{lang key="wishlistSetPrivate" section="login"}">
                                                                    <span class="img-ct icon">
																		<svg>
																		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-hide"></use>
																		</svg>
																	</span><span class="hidden-xs">{lang key="wishlistSetPrivate" section="login"}</span>
                                                                </button>
                                                            {/if}
                                                            {if $Wunschliste->nOeffentlich == 0}
                                                                <button type="submit" name="action" value="setPublic" class="btn btn-default">
                                                                    <span class="img-ct icon">
																		<svg>
																		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-show"></use>
																		</svg>
																	</span> <span class="hidden-xs">{lang key="wishlistSetPublic" section="login"}</span>
                                                                </button>
                                                            {/if}
                                                            <button type="submit" class="btn btn-danger" name="action" value="delete">
                                                                <span class="img-ct icon">
																	<svg>
																	  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin-w"></use>
																	</svg>
																</span>
                                                            </button>
                                                        </span>
                                                    </form>
                                                </td>
                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>
                                {/if}
                                <form method="post" action="{get_static_route id='wunschliste.php'}" class="form form-inline">
                                    <input type="hidden" name="kWunschliste" value="{$CWunschliste->kWunschliste}"/>
                                    {$jtl_token}
                                    <div class="input-group">
                                        <input name="cWunschlisteName" type="text" class="form-control input-sm" placeholder="{lang key="wishlistAddNew" section="login"}" size="25" />
                                        <span class="input-group-btn">
                                            <button type="submit" class="btn btn-default btn-sm" name="action" value="createNew">{lang key="wishlistSaveNew" section="login"}</button>
                                        </span>
                                    </div>
                                </form>
                            {/block}
                        </div>
                    </div>
                {/block}
            {/if}
        {/if}
    {/if}
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}