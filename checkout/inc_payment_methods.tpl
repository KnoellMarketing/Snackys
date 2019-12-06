{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}
{foreach name=paymentmethod from=$Zahlungsarten item=zahlungsart}
    <div id="{$zahlungsart->cModulId}" class="payship-option col-xs-12">
		<label for="payment{$zahlungsart->kZahlungsart}" class="dpflex-a-center m0 stc-radio">
			<span class="stc-input">
				<input name="Zahlungsart" value="{$zahlungsart->kZahlungsart}" class="radio-checkbox" type="radio" id="payment{$zahlungsart->kZahlungsart}"{if $AktiveZahlungsart === $zahlungsart->kZahlungsart || $Zahlungsarten|@count == 1} checked{/if}{if $smarty.foreach.paymentmethod.first} required{/if}>
				<span class="stc-radio-btn"></span>
			</span>
			{if $zahlungsart->cBild}
			<span class="payship-img">
				<span class="image-content icon">
					<img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$zahlungsart->cBild}" alt="{$zahlungsart->angezeigterName|trans}" >
				</span
			</span>
			{/if}
			<span class="payship-content">
				<strong class="block">
					{$zahlungsart->angezeigterName|trans}	
					{if $zahlungsart->fAufpreis != 0}
						<span class="badge small">
							{$zahlungsart->cPreisLocalized}
						</span>
					{/if}
				</strong>	
				{if $zahlungsart->cHinweisText|has_trans}
					<span class="block small">
						{$zahlungsart->cHinweisText|trans}
					</span>
				{/if}
			</span>
		</label>
    </div>
{/foreach}