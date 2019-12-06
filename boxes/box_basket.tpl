<section class="panel panel-default box box-basket" id="sidebox{$oBox->kBox}">
    <div class="panel-heading">
        <h5 class="panel-title">{lang key="yourBasket" section="global"}<span id="basket_loader"></span></h5>
    </div>
    <div class="panel-body">
        <a href="{get_static_route id='warenkorb.php'}" class="basket {if $WarenkorbArtikelanzahl > 0}pushed{/if}" id="basket_drag_area">
            <span id="basket_text">{$Warenkorbtext}</span><br>
            <span class="basket_link">{lang key="gotoBasket"}</span>
        </a>
    </div>
</section>