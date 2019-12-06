{if isset($smarty.session.Vergleichsliste) && $smarty.session.Vergleichsliste->oArtikel_arr|count > 1}
    <div class="hidden-xs compare-list-menu">
        <a href="{get_static_route id='vergleichsliste.php'}" title="{lang key="compare" sektion="global"}"{if $Einstellungen.vergleichsliste.vergleichsliste_target === 'blank'} target="_blank"{/if} class="hidden-xs popup">
                <span class="img-ct icon icon-xl">
					<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
					  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-compare"></use>
					</svg>
                </span>
            <sup class="badge"><em>{$smarty.session.Vergleichsliste->oArtikel_arr|count}</em></sup>
		</a>
    </div>
{/if}
