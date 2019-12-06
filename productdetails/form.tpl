{if $Artikel->kArtikelVariKombi > 0}
    <input type="hidden" name="aK" value="{$Artikel->kArtikelVariKombi}" />
{/if}
{if isset($Artikel->kVariKindArtikel)}
    <input type="hidden" name="VariKindArtikel" value="{$Artikel->kVariKindArtikel}"/>
{/if}
{if isset($smarty.get.ek)}
    <input type="hidden" name="ek" value="{$smarty.get.ek|intval}" />
{/if}
<input type="hidden" id="AktuellerkArtikelForm"  class="current_article" name="a" value="{$Artikel->kArtikel}" />
<input type="hidden" name="wke" value="1" />
<input type="hidden" name="show" value="1" />
<input type="hidden" name="kKundengruppe" value="{$smarty.session.Kundengruppe->kKundengruppe}" />
<input type="hidden" name="kSprache" value="{$smarty.session.kSprache}" />
{$jtl_token}