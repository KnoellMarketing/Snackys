<script type="text/javascript" data-inline="1">

{* Add this data to GTM - by Knoell Marketing *}
window.dataLayer = window.dataLayer || [];
dataLayer.push({ldelim}
	{if $nSeitenTyp == 18}
		{* Startseite *}
		ecomm_prodid: '',
		ecomm_pagetype: 'home',
		ecomm_totalvalue: 0.00
	{elseif $nSeitenTyp == 1}
		{* Artikel *}
		ecomm_prodid: '{$Artikel->cArtNr}',
		ecomm_pagetype: 'product',
		ecomm_totalvalue: {$Artikel->Preise->fVKBrutto}
	{elseif $nSeitenTyp == 2 && $NaviFilter->Suche->cSuche|strlen > 0}
		{* Suche *}
		ecomm_prodid: [{foreach from=$Suchergebnisse->Artikel->elemente item="prodid" name="prodid"}{if !$smarty.foreach.prodid.first},{/if}"{$prodid->cArtNr}"{/foreach}],
		ecomm_pagetype: 'searchresults',
		ecomm_totalvalue: [{foreach from=$Suchergebnisse->Artikel->elemente item="totalvalue" name="totalvalue"}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->Preise->fVKBrutto}{/foreach}]
	{elseif $nSeitenTyp == 2}
		{* Artikelliste *}
		ecomm_prodid: [{foreach from=$Suchergebnisse->Artikel->elemente item="prodid" name="prodid"}{if !$smarty.foreach.prodid.first},{/if}"{$prodid->cArtNr}"{/foreach}],
		ecomm_pagetype: 'category',
		ecomm_totalvalue: [{foreach from=$Suchergebnisse->Artikel->elemente item="totalvalue" name="totalvalue"}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->Preise->fVKBrutto}{/foreach}]
	{elseif $nSeitenTyp == 33 && $Bestellung->Positionen|count > 0}
		{* Bestellbestätigung *}
		ecomm_prodid: [{foreach from=$Bestellung->Positionen item="prodid" name="prodid"}{if !$smarty.foreach.prodid.first},{/if}"{$prodid->Artikel->cArtNr}"{/foreach}],
		ecomm_pagetype: 'purchase',
		ecomm_totalvalue: [{foreach from=$Bestellung->Positionen item="totalvalue" name="totalvalue"}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->Artikel->Preise->fVKBrutto}{/foreach}],
		transactionTotal: {$Bestellung->fWarensummeNetto},
		transactionId: '{$Bestellung->cBestellNr}'
	{elseif $nSeitenTyp == 3}
		{* Warenkorb *}
		ecomm_prodid: [{foreach from=$smarty.session.Warenkorb->PositionenArr item="prodid" name="prodid"}{if !$smarty.foreach.prodid.first},{/if}"{$prodid->Artikel->cArtNr}"{/foreach}],
		ecomm_pagetype: 'cart',
		ecomm_totalvalue: [{foreach from=$smarty.session.Warenkorb->PositionenArr item="totalvalue" name="totalvalue"}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->Artikel->Preise->fVKBrutto}{/foreach}]
	{else}
		{* Content *}
		ecomm_prodid: '',
		ecomm_pagetype: 'other',
		ecomm_totalvalue: 0.00
	{/if}
{rdelim});
</script>