{if $Artikel->nIstVater == 1 && $Artikel->oVariationKombiKinderAssoc_arr|count > 0}
	<div class="variation-matrix matrix-list">
		{foreach name="variations" from=$Artikel->oVariationKombiKinderAssoc_arr item=child}
			{if $Einstellungen.artikeldetails.artikeldetails_warenkorbmatrix_lagerbeachten !== 'Y' ||
			($Einstellungen.artikeldetails.artikeldetails_warenkorbmatrix_lagerbeachten === 'Y' && $child->inWarenkorbLegbar == 1)}
				{assign var=cVariBox value=''}
				{foreach name="childvariations" from=$child->oVariationKombi_arr item=variation}
					{if $cVariBox|strlen > 0}
						{assign var=cVariBox value=$cVariBox|cat:'_'}
					{/if}
					{assign var=cVariBox value=$cVariBox|cat:$variation->kEigenschaft|cat:':'|cat:$variation->kEigenschaftWert}
				{/foreach}
				<div class="row">
					<div class="hidden-xs hidden-sm hidden-md col-xs-1 preload">
						<span class="image-content">							 
							<img class="img-responsive" src="{$snackysTemplate}img/preload/1x1.png" data-src="{$child->Bilder[0]->cPfadMini}" alt="{$child->Bilder[0]->cAltAttribut}">
						</span>
					</div>
					<div class="col-xs-6">
						<div >
							<a href="{$child->cSeo}"><span itemprop="name">{$child->cName}</span></a>
						</div>
						<div class="small">
							{if $child->nErscheinendesProdukt}
								{lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
								{if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $child->inWarenkorbLegbar == 1}
									({lang key="preorderPossible" section="global"})
								{/if}
							{/if}
							{include file="productdetails/stock.tpl" Artikel=$child tplscope="matrix"}
						</div>
					</div>
					<div class="col-xs-6 col-sm-5">
						<div class="flex{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError) && $smarty.session.variBoxAnzahl_arr[$cVariBox]->bError} has-error{/if}">
							{if $child->inWarenkorbLegbar == 1 && !$child->bHasKonfig && ($child->nVariationAnzahl == $child->nVariationOhneFreifeldAnzahl)}
									{if $child->cEinheit}
										<span class="input-group-addon unit hidden-xs">{$child->cEinheit}: </span>
									{/if}
									<input
										size="3" placeholder="0"
										class="form-control text-right"
										name="variBoxAnzahl[{$cVariBox}]"
										type="text"
										value="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl|replace_delim}{/if}">
							{/if}
							<span class="text-muted">&times;</span>	
							<div class="price">
								{include file="productdetails/price.tpl" Artikel=$child tplscope="matrix"}
							</div>
						</div>
					</div>
				</div>
			{/if}
		{/foreach}
	</div>
    <input type="hidden" name="variBox" value="1" />
    <input type="hidden" name="varimatrix" value="1" />
    <button name="inWarenkorb" type="submit" value="{lang key="addToCart" section="global"}" class="sn-addBasket submit btn btn-primary pull-right btn-lg">{lang key="addToCart" section="global"}</button>
{/if}