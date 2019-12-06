{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

{if $Lieferadresse->cFirma}
    {$Lieferadresse->cFirma}
    <br />
{/if}
{if $Lieferadresse->cZusatz}
    {$Lieferadresse->cZusatz}
    <br />
{/if}
{if $Lieferadresse->cAnrede === 'w'}{$Anrede_w}{elseif $Lieferadresse->cAnrede === 'm'}{$Anrede_m}{/if} {$Lieferadresse->cTitel} {$Lieferadresse->cVorname} {$Lieferadresse->cNachname}
<br />{$Lieferadresse->cStrasse} {$Lieferadresse->cHausnummer}
<br />{if $Lieferadresse->cAdressZusatz}{$Lieferadresse->cAdressZusatz}<br />{/if}
{$Lieferadresse->cPLZ} {$Lieferadresse->cOrt}<br />{if $Lieferadresse->cBundesland}{$Lieferadresse->cBundesland}
    <br />
{/if}
{if $Lieferadresse->angezeigtesLand}{$Lieferadresse->angezeigtesLand}<br /><br />{/if}
{if $Lieferadresse->cTel}{lang key="tel" section="account data"}: {$Lieferadresse->cTel}<br />{/if}
{if $Lieferadresse->cFax}{lang key="fax" section="account data"}: {$Lieferadresse->cFax}<br />{/if}
{if $Lieferadresse->cMobil}{lang key="mobile" section="account data"}: {$Lieferadresse->cMobil}<br />{/if}
{if $Lieferadresse->cMail}{$Lieferadresse->cMail}<br />{/if}