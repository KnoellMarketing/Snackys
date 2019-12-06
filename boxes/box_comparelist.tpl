{if isset($smarty.session.Vergleichsliste) && $smarty.session.Vergleichsliste->oArtikel_arr|@count > 0}
    {if isset($oBox->nAnzahl) && $oBox->nAnzahl > 0 && isset($oBox->Artikel)} {*3.50*}
        {assign var=from value=$oBox->Artikel}
        {assign var=nAnzahl value=$oBox->nAnzahl}
    {else}
        {assign var=from value=$smarty.session.Vergleichsliste->oArtikel_arr} {*3.50 compat mode*}
        {assign var=nAnzahl value=$smarty.session.Vergleichsliste->oArtikel_arr|@count}
    {/if}
    {if isset($from)}
        <section class="panel panel-default box box-compare" id="sidebox{if !empty($oBox->kBox)}{$oBox->kBox}{/if}">
            <div class="panel-heading">
                <h5 class="panel-title"> {lang key="compare" section="global"}</h5>
            </div>{* /panel-heading *}
            <div class="panel-body{if count($from) <= 1} hidden{/if}">
				<table class="table table-striped vtable">
					{foreach name=vergleich from=$from item=oArtikel}
						{if $smarty.foreach.vergleich.iteration <= $nAnzahl}
							<tr class="item" data-id="{$oArtikel->kArtikel}">
								<td>
									<a href="{$oArtikel->cURL}" class="image"><img src="{$oArtikel->Bilder[0]->cPfadMini}" alt="{$oArtikel->cName|strip_tags|truncate:60|escape:"html"}" class="img-xs" /></a><br>
								</td>
								<td>
									<a href="{$oArtikel->cURL}" class="name">{$oArtikel->cName|truncate:25:"..."}</a>
								</td>
								<td class="text-right">
									<a href="{$oArtikel->cURLDEL}" class="remove pull-right preload" data-name="Vergleichsliste.remove" data-toggle="product-actions" data-value='{ldelim}"a":{$oArtikel->kArtikel}{rdelim}'>
									<div class="image-content icon">
										<svg>
										  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-bin"></use>
										</svg>
									</div></a>
								</td>
							</tr>
						{/if}
					{/foreach}
				</table>
                <a class="btn btn-default btn-sm btn-block{if $Einstellungen.vergleichsliste.vergleichsliste_target === 'popup'} popup{/if}" href="{get_static_route id='vergleichsliste.php'}"{if $Einstellungen.vergleichsliste.vergleichsliste_target === 'blank'} target="_blank"{/if}>{lang key="gotToCompare" section="global"}</a>
            </div>
        </section>
    {/if}
{elseif isset($oBox->kBox)}
    <section class="hidden box-compare" id="sidebox{$oBox->kBox}"></section>
{/if}
