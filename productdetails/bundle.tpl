{if !empty($Products)}
    <form action="{if !empty($ProductMain->cURLFull)}{$ProductMain->cURLFull}{else}index.php{/if}" method="post" id="form_bundles" class="evo-validate">
        <div class="panel panel-default panel-slider">
            <input type="hidden" name="a" value="{$ProductMain->kArtikel}" />
            <input type="hidden" name="addproductbundle" value="1" />
            <input type="hidden" name="aBundle" value="{$ProductKey}" />
            {block name="productdetails-bundle"}{* for additional hidden inputs use block prepend *}
			<hr class="invisible">
            <div class="panel-heading">
				<div class="panel-title mb-spacer mb-small">
                	<h5 class="h2">{lang key="buyProductBundle" section="productDetails"}</h5>
				</div>
            </div>
			<div class="panel-body">
				<div id="p-l" class="row row-multi gallery">
					{foreach name=bundles from=$Products item=Product}
						<div class="col-lg-2 p-w">
							<div class="p-c">
								<a class="img-w block" href="{$Product->cURL}">
									<span class="img-ct">
										<img src="{$snackyConfig.preloadImage}" data-src="{if $Product->Bilder[0]->cPfadKlein}{$Product->Bilder[0]->cPfadKlein}{else}{$BILD_KEIN_ARTIKELBILD_VORHANDEN}{/if}" alt="{$Product->cName}" title="{$Product->cName}" />
									</span>
								</a>
								<div class="caption">
									<span class="title word-break h4 m0">
										{foreach from=$ProductMain->oStueckliste_arr item=bundleProduct}
                                    		{if $bundleProduct->kArtikel == $Product->kArtikel}
												<span class="article-bundle-info">
													<span class="bundle-amount">{$bundleProduct->fAnzahl_stueckliste}</span> <span class="bundle-times">x</span>
												</span>
												{break}
                                    		{/if}
                                		{/foreach}
                                		<a href="{$Product->cURL}">{$Product->cName}</a>
									</span>
									<div class="price_wrapper">
										<strong class="price text-nowrap"><span>{$Product->Preise->cVKLocalized[0]}</span> *</strong>
									</div>
								</div>
							</div>
						</div>
					{/foreach}
				</div>
			</div>
			{if $smarty.session.Kundengruppe->darfPreiseSehen}
			<hr>
				<div class="dpflex-a-center">
					<div class="bundle-price h4">
						<span class="price-sum">{lang key="priceForAll" section="productDetails"}:
						<strong class="price price-sm">{$ProduktBundle->cPriceLocalized[$NettoPreise]} *</strong>
						</span>
						{if $ProduktBundle->fPriceDiff > 0}
							<br />
							<span class="label label-warning">{lang key="youSave" section="productDetails"}: <span class="color-brand">{$ProduktBundle->cPriceDiffLocalized[$NettoPreise]}</span></span>
						{/if}
						{if $ProductMain->cLocalizedVPE}
							<b class="label">{lang key="basePrice" section="global"}: </b>
							<span class="value">{$ProductMain->cLocalizedVPE[$NettoPreise]}</span>
						{/if}
					</div>
					<button name="inWarenkorb" type="submit" value="{lang key="addAllToCart" section="global"}" class="submit btn btn-primary btn-lg">{lang key="addAllToCart" section="global"}</button>
				</div>
			{/if}
            {/block}
        </div>
    </form>
{/if}