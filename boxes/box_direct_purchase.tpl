{if (isset($Boxen.Schnellkauf) && $Boxen.Schnellkauf->anzeigen === 'Y') || (isset($oBox->anzeigen) && $oBox->anzeigen)}
    <section class="panel panel-default box box-direct-purchase" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <h5 class="panel-title">{lang key='quickBuy'}</h5>
        </div>{* /panel-heading *}
        <div class="panel-body box-body">
            <form class="top10" action="{get_static_route id='warenkorb.php'}" method="post">
                {$jtl_token}
                <input type="hidden" name="schnellkauf" value="1">
                <div class="input-group">
                    <div class="form-group float-label-control">
                        <input aria-label="{lang key='quickBuy'}" type="text" placeholder="{lang key='productNoEAN'}" class="form-control" name="ean" id="quick-purchase">
                    </div>
                    <div class="input-group-btn preload">
                        <button type="submit" class="btn btn-default" title="{lang key='intoBasket'}">
						<span class="image-content icon">
							<svg>
							  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-cart-simple"></use>
							</svg>
						</span></button>
                    </div>
                </div>
            </form>
        </div>
    </section>
{/if}