{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

<h1>{lang key="umfrage" section="umfrage"}</h1>

{if !empty($hinweis)}
    <div class="alert aler-info">{$hinweis}</div>
{/if}
{if !empty($fehler)}
    <div class="alert alert-danger">{$fehler}</div>
{/if}

{include file="snippets/extension.tpl"}

{if isset($oUmfrage_arr) && $oUmfrage_arr|@count > 0}
    <div id="voting_overview">
        {block name="poll-overview"}
        {foreach name=umfrageuebersicht from=$oUmfrage_arr item=oUmfrage}
            <h3 {if $smarty.foreach.umfrageuebersicht.first}class="nospacing"{/if}><a href="{$oUmfrage->cURL}">{$oUmfrage->cName}</a></h3>
            <p><small>{$oUmfrage->dGueltigVon_de} | {$oUmfrage->nAnzahlFragen} {if $oUmfrage->nAnzahlFragen == 1}{lang key="umfrageQ" section="umfrage"}{else}{lang key="umfrageQs" section="umfrage"}{/if}</small></p>
            <p>{$oUmfrage->cBeschreibung}</p>
        {/foreach}
        {/block}
    </div>
{/if}
