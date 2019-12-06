{if isset($oBox->oNewsMonatsUebersicht_arr) && $oBox->oNewsMonatsUebersicht_arr|@count > 0}
    <section class="panel panel-default box box-monthlynews" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <h5 class="panel-title">{lang key="newsBoxMonthOverview" section="global"}</h5>
        </div>
        <div class="box-body dropdown">
            <ul class="nav nav-list">
                {foreach name=news from=$oBox->oNewsMonatsUebersicht_arr item=oNewsMonatsUebersicht}
                    <li>
                        <a href="{$oNewsMonatsUebersicht->cURL}"  title="{$oNewsMonatsUebersicht->cName}">
                            <span class="value">
                                {$oNewsMonatsUebersicht->cName}
                                <span class="badge pull-right">{$oNewsMonatsUebersicht->nAnzahl}</span>
                            </span>
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </section>
{elseif isset($Boxen.News->oNewsMonatsUebersicht_arr) && $Boxen.News->oNewsMonatsUebersicht_arr|@count > 0}
    <section class="panel panel-default box box-monthlynews" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <h5 class="panel-title">{lang key="newsBoxMonthOverview" section="global"}</h5>
        </div>
        <div class="panel-body">
            <ul>
                {foreach name=news from=$Boxen.News->oNewsMonatsUebersicht_arr item=oNewsMonatsUebersicht}
                    <li>
                        <a class="tooltip" href="{$oNewsMonatsUebersicht->cURL}" title="{$oNewsMonatsUebersicht->cBeschreibung|escape:"html"}">
                            <span class="value">
                                {$oNewsMonatsUebersicht->cName}
                                <span class="badge pull-right">{$oNewsMonatsUebersicht->nAnzahl}</span>
                            </span>
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </section>
{/if}