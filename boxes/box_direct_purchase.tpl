{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
{if (isset($Boxen.Schnellkauf) && $Boxen.Schnellkauf->anzeigen === 'Y') || (isset($oBox->anzeigen) && $oBox->anzeigen)}
    <section class="panel panel-default box box-direct-purchase" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
				{lang key='quickBuy'}
				{include file="snippets/careticon.tpl"}
			</span>
        </div>{* /panel-heading *}
        <div class="panel-body box-body">
            <form class="top10" action="{get_static_route id='warenkorb.php'}" method="post">
                {$jtl_token}
                <input type="hidden" name="schnellkauf" value="1">
                <div class="input-group">
                    <div class="form-group float-label-control">
                        <input aria-label="{lang key='quickBuy'}" type="text" placeholder="{lang key='productNoEAN'}" class="form-control" name="ean" id="quick-purchase">
                    </div>
                    <div class="input-group-btn pr">
                        <button type="submit" class="btn btn-default" title="{lang key='intoBasket'}">
						<span class="img-ct icon">
							<svg>
							  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-cart-simple"></use>
							</svg>
						</span></button>
                    </div>
                </div>
            </form>
        </div>
    </section>
{/if}
{/if}