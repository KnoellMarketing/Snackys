{if !isset($smarty.get.quickView) || $smarty.get.quickView != 1}
    <div id="product-actions" class="btn-group btn-group-md product-actions hidden-print" role="group">
        {assign var=kArtikel value=$Artikel->kArtikel}

        {if $Artikel->kArtikelVariKombi > 0}
            {assign var=kArtikel value=$Artikel->kArtikelVariKombi}
        {/if}
        {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
            <button gtag-event="add_to_wishlist" 
				gtag-type="click" gtag-event="add_to_wishlist" gtag-p-value="{$Artikel->Preise->fVKNetto}" gtag-p-currency="{$smarty.session.Waehrung->cISO}" gtag-p-items='[{ldelim}"id":"{$Artikel->cArtNr}","category":"{$cate|htmlspecialchars}","name":"{$Artikel->cName|htmlspecialchars}","price":"{$Artikel->Preise->fVKNetto}","quantity":"selectorval:#quantity"{rdelim}]'
				name="Wunschliste" type="submit" class="preload btn btn-default btn-secondary wishlist" title="{lang key='addToWishlist' section='productDetails'}">
                <span class="image-content icon">
					<svg>
					  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-heart"></use>
					</svg>
                </span>
                <span class="hidden-sm hidden-xs">{lang key='wishlist'}</span>
            </button>
        {/if}
        {if $Einstellungen.artikeldetails.artikeldetails_vergleichsliste_anzeigen === 'Y'}
            <button name="Vergleichsliste" type="submit" class="preload btn btn-default btn-secondary compare" title="{lang key='addToCompare' section='productDetails'}">
                <span class="image-content icon">
					<svg>
					  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-compare"></use>
					</svg>
                </span>
                <span class="hidden-sm hidden-xs">{lang key='compare'}</span>
            </button>
        {/if}
        {if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
            <button type="button" id="z{$kArtikel}" class="preload btn btn-default btn-secondary popup-dep question" title="{lang key='productQuestion' section='productDetails'}" data-toggle="modal" data-target="#pp-question_on_item">
                <span class="image-content icon">
					<svg>
					  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-question"></use>
					</svg>
                </span>
                <span class="hidden-sm hidden-xs">{lang key='productQuestion' section='productDetails'}</span>
            </button>
        {/if}
        {if ($verfuegbarkeitsBenachrichtigung == 2 || $verfuegbarkeitsBenachrichtigung == 3) && $Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull !== 'Y'}
            <button type="button" id="n{$kArtikel}" class="preload btn btn-default btn-secondary popup-dep notification" title="{lang key='requestNotification'}" data-toggle="modal" data-target="#pp-availability_notification">
                <span class="image-content icon">
					<svg>
					  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-bell"></use>
					</svg>
                </span>
                <span class="hidden-sm hidden-xs">{lang key='requestNotification'}</span>
            </button>
        {/if}
    </div>
    <div class="visible-xs clearfix hidden-print">
        <hr>
    </div>
{/if}

