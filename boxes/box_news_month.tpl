{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
{if isset($oBox->oNewsMonatsUebersicht_arr) && $oBox->oNewsMonatsUebersicht_arr|@count > 0}
    <section class="panel panel-default box box-monthlynews" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
				{lang key="newsBoxMonthOverview" section="global"}
				{include file="snippets/careticon.tpl"}
			</span>
        </div>
        <div class="box-body dropdown">
            <ul class="nav nav-list blanklist">
                {foreach name=news from=$oBox->oNewsMonatsUebersicht_arr item=oNewsMonatsUebersicht}
                    <li>
                        <a href="{$oNewsMonatsUebersicht->cURL}"  title="{$oNewsMonatsUebersicht->cName}">
                            <span class="value dpflex-j-between w100">
                                {$oNewsMonatsUebersicht->cName}
                                <span class="badge">{$oNewsMonatsUebersicht->nAnzahl}</span>
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
            <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
				{lang key="newsBoxMonthOverview" section="global"}
				{include file="snippets/careticon.tpl"}
			</span>
        </div>
        <div class="panel-body">
            <ul class="blanklist">
                {foreach name=news from=$Boxen.News->oNewsMonatsUebersicht_arr item=oNewsMonatsUebersicht}
                    <li>
                        <a class="tooltip" href="{$oNewsMonatsUebersicht->cURL}" title="{$oNewsMonatsUebersicht->cBeschreibung|escape:"html"}">
                            <span class="value dpflex-j-between w100">
                                {$oNewsMonatsUebersicht->cName}
                                <span class="badge">{$oNewsMonatsUebersicht->nAnzahl}</span>
                            </span>
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </section>
{/if}
{/if}