{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
<section class="panel panel-default box box-basket" id="sidebox{$oBox->kBox}">
    <div class="panel-heading">
        <span class="panel-title h5 dpflex-a-start m0 dpflex-a-center dpflex-j-between">
			{lang key="yourBasket" section="global"}
			{include file="snippets/careticon.tpl"} 
		</span>
    </div>
    <div class="panel-body">
        <a href="{get_static_route id='warenkorb.php'}" class="basket {if $WarenkorbArtikelanzahl > 0}pushed{/if}" id="basket_drag_area">
            <span id="basket_text">{$Warenkorbtext}</span><br>
            <span class="basket_link">{lang key="gotoBasket"}</span>
        </a>
    </div>
</section>
{/if}