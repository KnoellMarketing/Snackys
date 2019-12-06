{if isset($oAuswahlAssistent->oAuswahlAssistentFrage_arr) && $oAuswahlAssistent->oAuswahlAssistentFrage_arr|@count > 0}
    <hr />
    <script type="text/javascript">
        {literal}
        function aaDeleteSelectBTN() {
            var i;
            if (document.getElementsByName('aaLosBTN').length > 0) {
                for (i = 0; i < document.getElementsByName('aaLosBTN').length; i++) {
                    document.getElementsByName('aaLosBTN')[i].style.display = 'none';
                }
            }
        }
        /**
         * Auswahlassistent: xajax-callback on Selection
         */
        function setSelectionWizardAnswer(kMerkmalWert, kAuswahlAssistentFrage, nFrage, kKategorie) {
            var myCallback = xajax.callback.create(),
                data;
            myCallback.onComplete = function (obj) {
                data = obj.context.response;
            };
            xajax.call('setSelectionWizardAnswerAjax', {
                parameters: [kMerkmalWert, kAuswahlAssistentFrage, nFrage, kKategorie],
                callback:   myCallback,
                context:    this
            });
            return false;
        }
        /**
         * Auswahlassistent: xajax-callback on Reset
         */
        function resetSelectionWizardAnswer(nFrage, kKategorie) {
            var myCallback = xajax.callback.create(),
                data;
            myCallback.onComplete = function (obj) {
                data = obj.context.response;
            };
            xajax.call('resetSelectionWizardAnswerAjax', {
                parameters: [nFrage, kKategorie],
                callback:   myCallback,
                context:    this
            });
            return false;
        }
        {/literal}
    </script>
    {if !empty($NaviFilter->Kategorie->kKategorie)}
        {assign var=kKategorie value=$NaviFilter->Kategorie->kKategorie}
    {else}
        {assign var=kKategorie value=0}
    {/if}

    {if !empty($oAuswahlAssistent->cBeschreibung)}
        <div class="description"><p>{$oAuswahlAssistent->cBeschreibung}</p></div>
    {/if}
    <ul class="list-group">
        {foreach name=auswahlfrage from=$oAuswahlAssistent->oAuswahlAssistentFrage_arr key=nFrage item=oAuswahlAssistentFrage}
            <li id="question_{$oAuswahlAssistentFrage->kAuswahlAssistentFrage}" class="list-group-item{if $smarty.session.AuswahlAssistent->nFrage != $nFrage}{if $Einstellungen.auswahlassistent.auswahlassistent_allefragen === 'Y' || $smarty.session.AuswahlAssistent->nFrage > $nFrage} disabled{elseif $Einstellungen.auswahlassistent.auswahlassistent_allefragen === 'N' && $smarty.session.AuswahlAssistent->nFrage < $nFrage} closed{/if}{/if}">
                <h4 style="margin-bottom: 0;" class="question">{$oAuswahlAssistentFrage->cFrage}</h4>
                <div class="answers" id="answer_{$oAuswahlAssistentFrage->kAuswahlAssistentFrage}">
                    {if $smarty.session.AuswahlAssistent->nFrage > $nFrage}
                        {$smarty.session.AuswahlAssistent->oAuswahl_arr[$nFrage]->cWert}
                        <a href="{aaURLEncode nReset=1 nFrage=$nFrage kKategorie=$kKategorie}">
                            <span class='edit list-group-item-text' title="{lang key='edit' section='global'}" style="display: block;"></span>
                        </a>
                    {/if}
                    {if $Einstellungen.auswahlassistent.auswahlassistent_anzeigeformat === 'S'}
                    <form method="post" action="{aaURLEncode bUrlOnly=true}">
                        <input name="aaParams" type="hidden" value="1" />
                        <input name="kAuswahlAssistentFrage" type="hidden" value="{$oAuswahlAssistentFrage->kAuswahlAssistentFrage}" />
                        <input name="nFrage" type="hidden" value="{$nFrage}" />
                        <input name="kKategorie" type="hidden" value="{$kKategorie}" />
                        {/if}
                        <span>
                            {if $Einstellungen.auswahlassistent.auswahlassistent_anzeigeformat === 'S'}
                            <select {if $smarty.session.AuswahlAssistent->nFrage != $nFrage && ($Einstellungen.auswahlassistent.auswahlassistent_allefragen === 'Y' || $smarty.session.AuswahlAssistent->nFrage > $nFrage)}disabled="disabled"{/if} class="suche_improve_search" name="kMerkmalWert" onChange="return setSelectionWizardAnswer(this.options[this.selectedIndex].value, {$oAuswahlAssistentFrage->kAuswahlAssistentFrage}, {$nFrage}, {$kKategorie});">
                                <option value="-1">{lang key="pleaseChoose" section="global"}</option>
                            {/if}
                            {foreach name=auswahlmerkmalwerte from=$oAuswahlAssistentFrage->oMerkmal->oMerkmalWert_arr item=oMerkmalWert}
                                {if $Einstellungen.auswahlassistent.auswahlassistent_anzeigeformat === 'S'}
                                    <option value="{$oMerkmalWert->kMerkmalWert}">{$oMerkmalWert->cWert}{if $Einstellungen.auswahlassistent.auswahlassistent_anzahl_anzeigen === 'Y' && isset($oMerkmalWert->nAnzahl)} ({$oMerkmalWert->nAnzahl}){/if}</option>
                                {else}
                                    {if $smarty.session.AuswahlAssistent->nFrage != $nFrage && ($Einstellungen.auswahlassistent.auswahlassistent_allefragen === 'Y' || $smarty.session.AuswahlAssistent->nFrage > $nFrage)}
                                        <span>
                                    {else}
                                        <a href="{aaURLEncode kMerkmalWert=$oMerkmalWert->kMerkmalWert kAuswahlAssistentFrage=$oAuswahlAssistentFrage->kAuswahlAssistentFrage nFrage=$nFrage kKategorie=$kKategorie}" onclick="return setSelectionWizardAnswer({$oMerkmalWert->kMerkmalWert}, {$oAuswahlAssistentFrage->kAuswahlAssistentFrage}, {$nFrage}, {$kKategorie});" hidefocus="hidefocus">
                                    {/if}
                                    {if $Einstellungen.auswahlassistent.auswahlassistent_anzeigeformat === 'T'}
                                        {$oMerkmalWert->cWert|htmlentities}{if $Einstellungen.auswahlassistent.auswahlassistent_anzahl_anzeigen === 'Y' && isset($oMerkmalWert->nAnzahl)}
                                        <span class="badge">{$oMerkmalWert->nAnzahl}</span>{/if}
                                    {elseif $Einstellungen.auswahlassistent.auswahlassistent_anzeigeformat === 'B'}
                                        <img src="{$oMerkmalWert->cBildpfadKlein}" class="vmiddle" title="{$oMerkmalWert->cWert|htmlentities}" />
                                    {elseif $Einstellungen.auswahlassistent.auswahlassistent_anzeigeformat === 'BT'}
                                        <img src="{$oMerkmalWert->cBildpfadKlein}" class="vmiddle" title="{$oMerkmalWert->cWert|htmlentities}" />
											<span>{$oMerkmalWert->cWert|htmlentities}</span>{if $Einstellungen.auswahlassistent.auswahlassistent_anzahl_anzeigen === 'Y' && isset($oMerkmalWert->nAnzahl)}
                                        <span class="badge">{$oMerkmalWert->nAnzahl}</span>{/if}
                                    {/if}
                                    {if $smarty.session.AuswahlAssistent->nFrage != $nFrage && ($Einstellungen.auswahlassistent.auswahlassistent_allefragen === 'Y' || $smarty.session.AuswahlAssistent->nFrage > $nFrage)}
                                        </span>
                                    {else}
                                        </a>
                                    {/if}
                                {/if}
                            {/foreach}
                            {if $Einstellungen.auswahlassistent.auswahlassistent_anzeigeformat === 'S'}
                            </select>
                            {/if}
                        </span>
                        {if $Einstellungen.auswahlassistent.auswahlassistent_anzeigeformat === 'S'}
                            <button name="aaLosBTN" class="btn_select">{lang key="aaSelectBTN" section="global"}</button>
                    </form>
                    {/if}
                </div>
            </li>
        {/foreach}
    </ul>
    <script type="text/javascript">
        aaDeleteSelectBTN();
    </script>
{/if}
