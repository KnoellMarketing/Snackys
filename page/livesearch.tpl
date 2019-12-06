{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

{if count($LivesucheTop) === 0 && count($LivesucheLast) === 0}
<div class="alert alert-warning">
    {lang key="noDataAvailable" section="global"}
</div>
{else}
<div class="row" id="livesearch">
    <div class="col-xs-6">
        <div class="panel panel-default">
            <div class="panel-heading"><h4 class="panel-title">{lang key="topsearch" section="global"}{$Einstellungen.sonstiges.sonstiges_livesuche_all_top_count}</h4></div>
            <div class="panel-body">
                <ul class=list-unstyled>
                    {if count($LivesucheTop) > 0}
                        {foreach name=livesuchen from=$LivesucheTop item=suche}
                            <li class="tag">
                                <a href="{$suche->cURL}">{$suche->cSuche}</a>
                                <span class="badge">{$suche->nAnzahlTreffer}</span>
                            </li>
                        {/foreach}
                    {else}
                        <li>{lang key="noDataAvailable" section="global"}</li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>

    <div class="col-xs-6">
        <div class="panel panel-default">
            <div class="panel-heading"><h4 class="panel-title">{lang key="lastsearch" section="global"}</h4></div>
            <div class="panel-body">
                <ul class="list-unstyled">
                    {if count($LivesucheLast) > 0}
                        {foreach name=livesuchen from=$LivesucheLast item=suche}
                            <li class="tag">
                                <a href="{$suche->cURL}">{$suche->cSuche}</a>
                                <span class="badge">{$suche->nAnzahlTreffer}</span>
                            </li>
                        {/foreach}
                    {else}
                        <li>{lang key="noDataAvailable" section="global"}</li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>
</div>
{/if}