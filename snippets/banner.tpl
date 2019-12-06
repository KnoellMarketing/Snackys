{if isset($oImageMap)}
    <div class="banner">
        {block name="banner-map"}
            <img alt="{$oImageMap->cTitel}" src="{$snackysTemplate}img/preload/1x1.png" data-src="{$oImageMap->cBildPfad}" class="img-responsive" />
            {foreach from=$oImageMap->oArea_arr item=oImageMapArea}
                {strip}
                <a href="{$oImageMapArea->cUrl}" class="area {$oImageMapArea->cStyle}" style="left:{math equation="100/bWidth*posX" bWidth=$oImageMap->fWidth posX=$oImageMapArea->oCoords->x}%;top:{math equation="100/bHeight*posY" bHeight=$oImageMap->fHeight posY=$oImageMapArea->oCoords->y}%;width:{math equation="100/bWidth*aWidth" bWidth=$oImageMap->fWidth aWidth=$oImageMapArea->oCoords->w}%;height:{math equation="100/bHeight*aHeight" bHeight=$oImageMap->fHeight aHeight=$oImageMapArea->oCoords->h}%" title="{$oImageMapArea->cTitel|strip_tags|escape:"html"|escape:"quotes"}">
                    {if $oImageMapArea->oArtikel || $oImageMapArea->cBeschreibung|@strlen > 0}
                        {assign var="oArtikel" value=$oImageMapArea->oArtikel}
                        <div class="area-desc">
							<div class="header">
								<span></span>
							</div>
							<div class="inside text-center preload">
								{if $oImageMapArea->cTitel|strip_tags|escape:"html"|escape:"quotes"|@strlen > 0}
								 <h4>{$oImageMapArea->cTitel|strip_tags|escape:"html"|escape:"quotes"}</h4>
								{/if}
								{if $oImageMapArea->oArtikel}
									<div class="image-content">
										<img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$oArtikel->cVorschaubild}" alt="{$oArtikel->cName|strip_tags|escape:"quotes"|truncate:60}" class="img-responsive center-block" />
									</div>
								{/if}
								{if $oImageMapArea->oArtikel}
									{include file="productdetails/price.tpl" Artikel=$oArtikel tplscope="box"}
								{/if}
								{if $oImageMapArea->cBeschreibung|@strlen > 0}
									<p>
										{$oImageMapArea->cBeschreibung}
									</p>
								{/if}
							</div>
                        </div>
                    {/if}
                </a>
                {/strip}
            {/foreach}
        {/block}
    </div>
{/if}
