<root>
	{if !empty($fehler)}
	<error>
		<fehler>{$fehler}</fehler>
	</error>
	{else if isset($Artikelhinweise) && count($Artikelhinweise) > 0}
	<error>
		{foreach from=$Artikelhinweise item="fehler"}
			<fehler>{$fehler}</fehler>
		{/foreach}
	</error>
	{else}
	<success>
		<kArtikel>{$Artikel->kArtikel}</kArtikel>
		<warenkorbAnzahl>{$WarenkorbArtikelPositionenanzahl}</warenkorbAnzahl>
		<warenkorb>{include file='checkout/inc_order_items.tpl' isSidebar="1" assign="warenkorb"}{$warenkorb|htmlspecialchars}</warenkorb>
	</success>
	{/if}
</root>