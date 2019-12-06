{strip}
{if $productlist|@count > 0}
    {if !isset($tplscope)}
        {assign var='tplscope' value='slider'}
    {/if}
    <section class="related-list panel{if $title|strlen > 0} panel-default{/if} panel-slider{if $tplscope === 'box'} box box-slider{/if}{if isset($class) && $class|strlen > 0} {$class}{/if}"{if isset($id) && $id|strlen > 0} id="{$id}"{/if}>
        <div class="panel-heading">
            {if $title|strlen > 0}
                <h5 class="panel-title {if !isset($isBox)}h3{/if}">
                    {$slidertitle}
                </h5>
            {/if}
        </div>
        <div{if $title|strlen > 0} class="panel-body"{/if}>
                {foreach name="sliderproducts" from=$productlist item='product'}
                <div class="item-related">
                    <div class="product-wrapper{if isset($style)} {$style}{/if}">
                        {include file='productlist/item_related.tpl' Artikel=$product tplscope=$tplscope class=''}
                    </div>
                </div>
                {/foreach}
        </div>
    </section>{* /panel *}
{/if}
{/strip}