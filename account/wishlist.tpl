<form method="post" action="{get_static_route id='jtl.php'}" name="Wunschliste">
    {$jtl_token}
    {block name="wishlist"}
    <input type="hidden" name="wla" value="1" />
    <input type="hidden" name="wl" value="{$CWunschliste->kWunschliste}" />

    {if isset($wlsearch)}
        <input type="hidden" name="wlsearch" value="1" />
        <input type="hidden" name="cSuche" value="{$wlsearch}" />
    {/if}

    <div id="edit-wishlist-name">
        <div class="">
            <label class="input-group-addon pr" for="wishlist-name">
                {lang key="name" section="global"}
            </label>
            <div class="input-group pr">
            <input id="wishlist-name" type="text" class="form-control" placeholder="name" name="WunschlisteName" value="{$CWunschliste->cName}" autofocus />
                <div class="input-group-btn">
            <button type="submit" class="btn">
			<span class="img-ct icon">
				<svg>
				  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-save"></use>
				</svg>
			</span></button></div></div>
        </div>
    </div>

    {if !empty($CWunschliste->CWunschlistePos_arr)}
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
							<span class="img-ct">
                            	<img alt="{$CWunschlistePos->Artikel->cName}" src="{$snackyConfig.preloadImage}" data-src="{$CWunschlistePos->Artikel->cVorschaubild}" class="img-responsive">
							</span>
                        </a>
                    </td>
                    <td>
                        <div class="text-content">
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
                        </div>
                    </td>
                    <td>
                        <div class="text-content">
                            <textarea class="form-control" rows="2" name="Kommentar_{$CWunschlistePos->kWunschlistePos}">{$CWunschlistePos->cKommentar}</textarea>
                        </div>
                    </td>
                    {if $CWunschlistePos->Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === "N"}
                        <td width="1%"></td>
                        <td class="text-right">
                            <div class="btn-group-vertical">
                                <a href="{get_static_route id='jtl.php'}?wl={$CWunschliste->kWunschliste}&wlplo={$CWunschlistePos->kWunschlistePos}{if isset($wlsearch)}&wlsearch=1&cSuche={$wlsearch}{/if}" class="btn btn-default" title="{lang key="wishlistremoveItem" section="login"}">
                                    
                                </a>
                            </div>
                        </td>
                    {else}
                        <td>
                            <input name="Anzahl_{$CWunschlistePos->kWunschlistePos}" class="wunschliste_anzahl form-control" type="text" size="1" value="{$CWunschlistePos->fAnzahl|replace_delim}"><br />{$CWunschlistePos->Artikel->cEinheit}
                        </td>
                        <td class="text-right">
                            <div class="btn-group-vertical pr">
                                {* @todo: button href? *}
                                {if $CWunschlistePos->Artikel->bHasKonfig}
                                    <a href="{$CWunschlistePos->Artikel->cURL}" class="btn btn-default" title="{lang key="product" section="global"} {lang key="configure" section="global"}">
                                        
                                    </a>
                                {else}
                                    <a href="{get_static_route id='jtl.php'}?wl={$CWunschliste->kWunschliste}&wlph={$CWunschlistePos->kWunschlistePos}{if isset($wlsearch)}&wlsearch=1&cSuche={$wlsearch}{/if}" class="btn btn-primary" title="{lang key="wishlistaddToCart" section="login"}">
                                        <span class="img-ct icon">
											<svg>
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-cart-simple-w"></use>
											</svg>
										</span>
                                    </a>
                                {/if}
                                <a href="{get_static_route id='jtl.php'}?wl={$CWunschliste->kWunschliste}&wlplo={$CWunschlistePos->kWunschlistePos}{if isset($wlsearch)}&wlsearch=1&cSuche={$wlsearch}{/if}" class="btn btn-default" title="{lang key="wishlistremoveItem" section="login"}">
                                    <span class="img-ct icon">
										<svg>
										  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
										</svg>
									</span>
                                </a>
                            </div>
                        </td>
                    {/if}
                </tr>
            {/foreach}
            </tbody>
        </table>
        <div class="row">
            <div class="col-xs-12 send-wishlist mb-spacer mb-small">
                {block name="wishlist-body"}
                    {if $CWunschliste->nOeffentlich == 1}
                        <div class="input-group input-group">
                            <input type="text" name="wishlist-url" readonly="readonly" value="{$ShopURL}/index.php?wlid={$CWunschliste->cURLID}" class="form-control">
                                {if $Einstellungen.global.global_wunschliste_freunde_aktiv === 'Y'}
                                <span class="input-group-btn pr">
                                    <button type="submit" name="wlvm" value="1" class="btn btn-default" title="{lang key="wishlistViaEmail" section="login"}">
                                      <span class="img-ct icon">
										<svg">
										  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-mail"></use>
										</svg>
									  </span>
                                   </button>
                                </span>
                                {/if}
                                <span class="input-group-btn pr">
                                <button type="submit" name="wlAction" value="setPrivate" class="btn btn-default" title="{lang key="wishlistSetPrivate" section="login"}">
                                    <span class="img-ct icon">
										<svg>
										  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-hide"></use>
										</svg>
									</span> <span class="hidden-xs">{lang key="wishlistSetPrivate" section="login"}</span>
                                </button>
                                </span>
                        </div>
                    {else}
                        <button type="submit" name="wlAction" value="setPublic" class="btn btn-default">
                             <span class="img-ct icon">
								<svg>
								  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-show"></use>
								</svg>
							 </span> <span class="hidden-xs">{lang key="wishlistSetPublic" section="login"}</span>
                        </button>
                    {/if}
                {/block}
            </div>
            <div class="col-xs-12">
                <div class="btn-group">
                    <a href="{get_static_route id='jtl.php'}?wl={$CWunschliste->kWunschliste}&wlpah=1{if isset($wlsearch)}&wlsearch=1&cSuche={$wlsearch}{/if}" class="btn btn-primary submit" title="{lang key="wishlistAddAllToCart" section="login"}">{lang key="wishlistAddAllToCart" section="login"}</a>
                    <button type="submit" title="{lang key="wishlistUpdate" section="login"}" class="btn btn-default">
                        {lang key="wishlistUpdate" section="login"}
                    </button>
                    <a href="{get_static_route id='jtl.php'}?wl={$CWunschliste->kWunschliste}&wldl=1" class="btn btn-default submit" title="{lang key="wishlistDelAll" section="login"}">{lang key="wishlistDelAll" section="login"}</a>
                </div>
            </div>
        </div>
    {/if}


    {/block}
</form>