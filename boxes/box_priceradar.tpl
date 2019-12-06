{if isset($oBox->Artikel->elemente) && $oBox->Artikel->elemente|@count > 0}
    <section class="panel panel-default box box-priceradar" id="sidebox{$oBox->kBox}">
        <div class="panel-heading"><h5 class="panel-title">{lang key="priceRadar" section="global"}</h5></div>{* /panel-heading *}
        <div class="panel-body text-center">
            {if $BoxenEinstellungen.boxen.boxen_preisradar_scrollbar > 0}
            <marquee behavior="scroll" direction="{if $BoxenEinstellungen.boxen.boxen_preisradar_scrollbar == 1}down{else}up{/if}" onmouseover="this.stop()" onmouseout="this.start()" scrollamount="2" scrolldelay="70">
                {/if}
                <ul class="list-unstyled">
                    {foreach name=sonderangebote from=$oBox->Artikel->elemente item=oArtikel}
                        <li>
                            <div class="text-center clearall">
                                <p><a href="{$oArtikel->cURL}"><img src="{$oArtikel->cVorschaubild}" alt="{$oArtikel->cName|strip_tags|escape:"quotes"|truncate:60}" class="image" /></a></p>
                                <p><a href="{$oArtikel->cURL}">{$oArtikel->cName}</a></p>

                                {lang key="oldPrice" section="global"}: <del>{$oArtikel->oPreisradar->fOldVKLocalized[$NettoPreise]}</del>
                                {include file="productdetails/price.tpl" price_image=$oArtikel->Preise->strPreisGrafik_Sonderbox Artikel=$oArtikel tplscope="box"}
                            </div>
                        </li>
                    {/foreach}
                </ul>

                {if $BoxenEinstellungen.boxen.boxen_preisradar_scrollbar > 0}
            </marquee>
            {/if}
        </div>
    </section>
{elseif isset($Boxen.Preisradar->Artikel->elemente) && $Boxen.Preisradar->Artikel->elemente|@count > 0}
    <section class="panel panel-default box box-priceradar" id="sidebox{$oBox->kBox}">
        <div class="panel-heading"><h5 class="panel-title">{lang key="priceRadar" section="global"}</h5></div>{* /panel-heading *}
        <div class="panel-body text-center">
        {if $BoxenEinstellungen.boxen.boxen_preisradar_scrollbar > 0}
            <marquee behavior="scroll" direction="{if $BoxenEinstellungen.boxen.boxen_preisradar_scrollbar == 1}down{else}up{/if}" onmouseover="this.stop()" onmouseout="this.start()" scrollamount="2" scrolldelay="70">
        {/if}
            <ul class="list-unstyled">
            {foreach name=sonderangebote from=$Boxen.Preisradar->Artikel->elemente item=oArtikel}
                <li>
                    <div class="text-center clearall">
                        <p><a href="{$oArtikel->cURL}"><img src="{$oArtikel->cVorschaubild}" alt="{$oArtikel->cName|strip_tags|escape:"quotes"|truncate:60}" class="image" /></a></p>
                        <p><a href="{$oArtikel->cURL}">{$oArtikel->cName}</a></p>

                        {lang key="oldPrice" section="global"}: <del>{$oArtikel->oPreisradar->fOldVKLocalized[$NettoPreise]}</del>
                        {include file="productdetails/price.tpl" price_image=$oArtikel->Preise->strPreisGrafik_Sonderbox Artikel=$oArtikel tplscope="box"}
                    </div>
                </li>
            {/foreach}
            </ul>

        {if $BoxenEinstellungen.boxen.boxen_preisradar_scrollbar > 0}
            </marquee>
        {/if}
        </div>
    </section>
{/if}