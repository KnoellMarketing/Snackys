<form method="post" action="{if !empty($Artikel->cURLFull)}{$Artikel->cURLFull}{else}index.php{/if}" class="form">
    {$jtl_token}
    {if count($ProduktTagging) > 0}
        <h4 class="no-margin">{lang key="productTagsDesc" section="productDetails"}</h4>
        {if $ProduktTagging|@count > 0}
            <div class="panel">
                <div class="panel-body">
                    {foreach name=produktTaggings from=$ProduktTagging item=produktTagging}
                        <a href="{$produktTagging->cURL}" title="{$produktTagging->cName}" class="btn btn-xs"><span class="badge">{$produktTagging->cName}</span></a>
                    {/foreach}
                </div>
            </div>
        {/if}
    {/if}

    {if $Einstellungen.artikeldetails.tagging_freischaltung !== 'N'}
        <input type="hidden" name="a" value="{$Artikel->kArtikel}" />
        <input type="hidden" name="produktTag" value="1" />
        {if ($Einstellungen.artikeldetails.tagging_freischaltung === 'Y' && !empty($smarty.session.Kunde->kKunde)) || $Einstellungen.artikeldetails.tagging_freischaltung === 'O'}
            <div class="row">
                <div class="col-xs-12">
                    <label class="sr-only" for="add-tag">{lang key="addTag" section="productDetails"}</label>
                    <div class="input-group">
                        <input id="add-tag" placeholder="{lang key="addTag" section="productDetails"}" name="tag" type="text" class="form-control">
                        <span class="input-group-btn">
                            <button name="submit" type="submit" class="btn btn-default preload">
								<div class="image-content icon">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-save"></use>
									</svg>
								</div>
							</button>
                        </span>
                    </div>
                </div>
            </div>
        {else}
            <p>{lang key="tagloginnow" section="productDetails"}</p>
            <input name="einloggen" type="submit" class="btn btn-default btn-sm" value="{lang key="taglogin" section="productDetails"}" />
        {/if}
    {/if}
</form>