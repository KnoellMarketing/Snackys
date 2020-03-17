{assign var='show_filters' value=false}
{if $Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab == 0 || $Suchergebnisse->GesamtanzahlArtikel >= $Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab || $NaviFilter->nAnzahlFilter > 0}
    {assign var='show_filters' value=true}
{/if}
<div id="result-options" class="panel-wrap {if !$show_filters} hidden-xs{/if}">
        <div class="row displayoptions form-inline hidden-xs">
            {block name="productlist-result-options-sort"}
            <div class="form-group col-xs-12">
                <select name="Sortierung" onchange="$('#improve_search').submit();" class="form-control form-small">
                    {if !isset($Suchergebnisse->Sortierung) || !$Suchergebnisse->Sortierung}
                        <option value="0">{lang key="sorting" section="productOverview"}</option>{/if}
                    <option value="100" {if isset($smarty.session.Usersortierung) && isset($Sort) && $smarty.session.Usersortierung==$Sort->value}selected="selected"{/if}>{lang key="standard" section="global"}</option>
                    {foreach name=sortierliste from=$Sortierliste item=Sort}
                        <option value="{$Sort->value}" {if $smarty.session.Usersortierung==$Sort->value}selected="selected"{/if}>{$Sort->angezeigterName}</option>
                    {/foreach}
                </select>
            </div>
            {*<div class="form-group col-xs-6 col-sm-4 col-md-4 col-lg-3">
                <select name="af" onchange="$('#improve_search').submit();" class="form-control form-small">
                    <option value="0"{if isset($smarty.session.ArtikelProSeite) && $smarty.session.ArtikelProSeite == 0} selected="selected"{/if}>{lang key="productsPerPage" section="productOverview"}</option>
                    <option value="9"{if isset($smarty.session.ArtikelProSeite) && $smarty.session.ArtikelProSeite == 9} selected="selected"{/if}>9 {lang key="productsPerPage" section="productOverview"}</option>
                    <option value="18"{if isset($smarty.session.ArtikelProSeite) && $smarty.session.ArtikelProSeite == 18} selected="selected"{/if}>18 {lang key="productsPerPage" section="productOverview"}</option>
                    <option value="30"{if isset($smarty.session.ArtikelProSeite) && $smarty.session.ArtikelProSeite == 30} selected="selected"{/if}>30 {lang key="productsPerPage" section="productOverview"}</option>
                    <option value="90"{if isset($smarty.session.ArtikelProSeite) && $smarty.session.ArtikelProSeite == 90} selected="selected"{/if}>90 {lang key="productsPerPage" section="productOverview"}</option>
                </select>
            </div>*}
            {/block}
        </div>
</div>
