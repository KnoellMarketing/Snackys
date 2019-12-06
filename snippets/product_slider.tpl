{strip}
{if $productlist|@count > 0}
    {if !isset($tplscope)}
        {assign var='tplscope' value='slider'}
    {/if}
    <section class="panel{if $title|strlen > 0} panel-default{/if} panel-slider{if $tplscope === 'box'} box box-slider{/if}{if isset($class) && $class|strlen > 0} {$class}{/if}{if $nSeitenTyp === 18} mb-spacer{/if}"{if isset($id) && $id|strlen > 0} id="{$id}"{/if}>
        <div class="panel-heading">
            {if $title|strlen > 0}
                <div class="panel-title">
                   <h5 {if !isset($isBox)}class="h2"{/if}> {$title}</h5>
                    <div class="right">
                        <div class="arrow-container btn-group"></div>
                        {if !empty($moreLink)}
                            <a class="btn btn-primary{if isset($isBox)} btn-xs{/if}" href="{$moreLink}" title="{$moreTitle}" data-toggle="tooltip" data-placement="auto right" aria-label="{$moreTitle}">
                                {lang key="showAll" section="global"}
                            </a>
                        {/if}
                    </div>
                </div>
				{assign var="gtagTitle" value="PSlider - {$title|escape}"}
			{else}
				{assign var="gtagTitle" value="Produkt Slider"}
            {/if}
        </div>
        <div{if $title|strlen > 0} class="panel-body"{/if}>
            <div class="arrow-container-box"></div>
            <div class="row product-slider{if isset($isBox)} sidebar{/if}"
				gtag-type="start" gtag-event="view_item_list" gtag-p-value="" gtag-p-currency="{$smarty.session.Waehrung->cISO}" gtag-p-items='[{foreach name=artikel from=$productlist item=Artikel}{if !$smarty.foreach.artikel.first},{/if}{ldelim}"id":"{if $Einstellungen.template.analytics.artnr == "id"}{$Artikel->kArtikel}{else}{$Artikel->cArtNr}{/if}","category":"{$gtagTitle}","name":"{$Artikel->cName|escape}","price":"{$Artikel->Preise->fVKNetto}"{rdelim}{/foreach}]'
			>
                {foreach name="sliderproducts" from=$productlist item='product'}
                    <div class="col-lg-2 product-wrapper{if isset($style)} {$style}{/if}">
                        {include file='productlist/item_slider.tpl' Artikel=$product tplscope=$tplscope class=''}
                    </div>
                {/foreach}
            </div>
        </div>
    </section>{* /panel *}
{/if}
{/strip}