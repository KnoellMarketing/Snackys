<section class="panel panel-default mb-spacer"{if isset($id) && $id|strlen > 0} id="{$id}"{/if}>
	<div class="panel-heading">
			<div class="panel-title{if !isset($isBox)} dpflex-a-center dpflex-j-between mb-spacer mb-small{/if}{if $tplscope == 'box'} h5 m0 dpflex-a-center dpflex-j-between{/if}">
			   <span class="{if !isset($isBox)}h2 m0 block{else}h5 block{/if}"> {$title}</span>
			</div>
        </div>
	<div class="panel-body">
		<div id="p-l" class="row row-multi gallery">
			{foreach name="sliderproducts" from=$productlist item='product'}
				<div class="col-lg-2 p-w{if isset($style)} {$style}{/if}">
					{include file='productlist/item_slider.tpl' Artikel=$product tplscope=$tplscope class=''}
				</div>
			{/foreach}
		</div>
	</div>
</section>