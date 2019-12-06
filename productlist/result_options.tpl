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
        {if $show_filters}
            <div class="col-sm-4 col-sm-pull-8 filter-collapsible-control">
                <a class="btn btn-default" data-toggle="collapse" href="#filter-collapsible" aria-expanded="false" aria-controls="filter-collapsible">
                     {lang key='filterBy' section='global'}
                    <span class="caret"></span>
                </a>
            </div>
        {/if}{* /row *}
    {if $show_filters}
        <div id="filter-collapsible" class="collapse top10">
        <nav class="panel panel-default">
            <div id="navbar-filter" class="panel-body">
                <div class="form-inline">
                    {if $Einstellungen.navigationsfilter.allgemein_kategoriefilter_benutzen === 'Y' && (!empty($Suchergebnisse->Kategorieauswahl) && $Suchergebnisse->Kategorieauswahl|@count > 1)}
                        {block name="productlist-result-options-filter-category"}
                        <div class="form-group dropdown filter-type-category">
                            <a href="#" class="btn btn-default dropdown-toggle form-control" data-toggle="dropdown" role="button" aria-expanded="false">
                                {lang key="allCategories" section="global"} <span class="caret"></span>
                            </a>
                            {include file='snippets/filter/category.tpl' class="dropdown-menu"}
                        </div>
                        {/block}
                    {/if}

                    {if $Einstellungen.navigationsfilter.allgemein_herstellerfilter_benutzen === 'Y' &&
                        !isset($oExtendedJTLSearchResponse) &&
                        (!empty($Suchergebnisse->Herstellerauswahl) && $Suchergebnisse->Herstellerauswahl|@count > 1)}
                        {block name="productlist-result-options-filter-manufacturer"}
                        <div class="form-group dropdown filter-type-manufacturer">
                            <a href="#" class="btn btn-default dropdown-toggle form-control" data-toggle="dropdown" role="button" aria-expanded="false">
                                {lang key="allManufacturers" section="global"} <span class="caret"></span>
                            </a>
                            {include file='snippets/filter/manufacturer.tpl' class="dropdown-menu"}
                        </div>
                        {/block}
                    {/if}

                    {if $Einstellungen.navigationsfilter.merkmalfilter_verwenden === 'content' && $Suchergebnisse->MerkmalFilter|@count > 0 && $Suchergebnisse->Artikel->elemente|@count > 0}
                        {block name="productlist-result-options-filter-attributes"}
                        {foreach name=merkmalfilter from=$Suchergebnisse->MerkmalFilter item=Merkmal}
                            <div class="form-group dropdown filter-type-characteristic">
                                <a href="#" class="btn btn-default dropdown-toggle form-control" data-toggle="dropdown" role="button" aria-expanded="false">
                                    {$Merkmal->cName} <span class="caret"></span>
                                </a>
                                {include file='snippets/filter/characteristic.tpl' class="dropdown-menu" role="menu"}
                            </div>
                        {/foreach}
                        {/block}
                    {/if}{* /merkmalfilter *}
                    {if !empty($Suchergebnisse->Suchspecialauswahl)}
                        <div class="form-group dropdown filter-type-special">
                            <a href="#" class="btn btn-default dropdown-toggle form-control" data-toggle="dropdown" role="button" aria-expanded="false">
                                {lang key="specificProducts" section="global"} <span class="caret"></span>
                            </a>
                            {include file='snippets/filter/special.tpl' class="dropdown-menu"}
                        </div>
                    {/if}{* /suchspecials *}
                    {if $Einstellungen.navigationsfilter.preisspannenfilter_benutzen === 'content' && (empty($NaviFilter->PreisspannenFilter) && !empty($Suchergebnisse->Preisspanne))}
                        {block name="productlist-result-options-filter-price"}
                        <div class="form-group dropdown filter-type-pricerange">
                            <a href="#" class="btn btn-default dropdown-toggle form-control" data-toggle="dropdown" role="button" aria-expanded="false">
                                {lang key="rangeOfPrices" section="global"} <span class="caret"></span>
                            </a>
                            {include file='snippets/filter/pricerange.tpl' class="dropdown-menu"}
                        </div>
                        {/block}
                    {elseif isset($NaviFilter->PreisspannenFilter) && $NaviFilter->PreisspannenFilter->fBis > 0}
                        <input type="hidden" name="pf" value="{$NaviFilter->PreisspannenFilter->cWert}">
                    {/if}{* /preisspannenfilter *}

                    {if $Einstellungen.navigationsfilter.bewertungsfilter_benutzen === 'content' && (empty($NaviFilter->BewertungFilter) && !empty($Suchergebnisse->Bewertung))}
                        {block name="productlist-result-options-filter-rating"}
                        <div class="form-group dropdown filter-type-review">
                            <a href="#" class="btn btn-default dropdown-toggle form-control" data-toggle="dropdown" role="button" aria-expanded="false">
                                {lang key="Votes" section="global"} <span class="caret"></span>
                            </a>
                            {include file='snippets/filter/review.tpl' class="dropdown-menu"}
                        </div>
                        {/block}
                    {elseif isset($NaviFilter->BewertungFilter) && $NaviFilter->BewertungFilter->nSterne > 0}
                        <input type="hidden" name="bf" value="{$NaviFilter->BewertungFilter->nSterne}">
                    {/if}
                </div>{* /form-inline *}
            </div>
            <!-- /.navbar-collapse -->
        </nav>
        </div>{* /collapse *}
    {/if}
</div>
