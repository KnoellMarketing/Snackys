{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
{if isset($smarty.session.Kunde->kKunde) && isset($oBox->CWunschlistePos_arr) && $oBox->CWunschlistePos_arr|@count > 0}
    {assign var=wishlistItems value=$oBox->CWunschlistePos_arr}
{elseif isset($smarty.session.Kunde->kKunde) && isset($Boxen.Wunschliste->CWunschlistePos_arr) && $Boxen.Wunschliste->CWunschlistePos_arr|@count > 0}
    {assign var=wishlistItems value=$Boxen.Wunschliste->CWunschlistePos_arr}
{/if}

{if isset($wishlistItems)}
    <section class="panel panel-default box box-wishlist" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
				{lang key="wishlist" section="global"}
				{include file="snippets/careticon.tpl"}
			</span>
        </div>
        <div class="panel-body">
            {if isset($Boxen.Wunschliste->nAnzeigen)}
                {assign var=maxItems value=$Boxen.Wunschliste->nAnzeigen}
            {else}
                {assign var=maxItems value=$oBox->nAnzeigen}
            {/if}
            <ul class="comparelist small blanklist">
                {foreach name=wunschzettel from=$wishlistItems item=oWunschlistePos}
                    {if $smarty.foreach.wunschzettel.iteration <= $maxItems}
                        <li>
                            <a href="{$oWunschlistePos->Artikel->cURL}" title="{$oWunschlistePos->cArtikelName|escape:'quotes'}">
                                {if (isset($Boxen.Wunschliste->nBilderAnzeigen) && $Boxen.Wunschliste->nBilderAnzeigen === 'Y') || (isset($oBox) && $oBox->nBilderAnzeigen === 'Y')}
                                    <div class="img-ct icon"><img alt="{$oWunschlistePos->cArtikelName|truncate:25:"..."}" data-src="{$oWunschlistePos->Artikel->Bilder[0]->cPfadMini}" class="img-xs"></div>
                                {/if}
                                {$oWunschlistePos->fAnzahl|replace_delim} &times; {$oWunschlistePos->cArtikelName|truncate:25:"..."}
                            </a>
                            <a class="remove button" href="{$oWunschlistePos->cURL}">
							<div class="img-ct icon">
								<svg>
								  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
								</svg>
							</div> </a>
                        </li>
                    {/if}
                {/foreach}
            </ul>
            <hr>
            <a href="{get_static_route id='jtl.php'}?wl={if isset($Boxen.Wunschliste->CWunschlistePos_arr)}{$Boxen.Wunschliste->CWunschlistePos_arr[0]->kWunschliste}{else}{$oBox->CWunschlistePos_arr[0]->kWunschliste}{/if}" class="btn btn-default btn-block btn-sm">{lang key="goToWishlist" section="global"}</a>
        </div>
    </section>
{/if}  
{/if}  