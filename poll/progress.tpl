{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}
<h1>{lang key="umfrage" section="umfrage"}</h1>

{if !empty($hinweis)}
    <div class="alert alert-info">{$hinweis}</div>
{/if}
{if !empty($fehler)}
    <div class="alert alert-danger">{$fehler}</div>
{/if}

{if $oUmfrage->oUmfrageFrage_arr|@count > 0 && $oUmfrage->oUmfrageFrage_arr}
    <form method="post" action="{get_static_route id='umfrage.php'}" class="evo-validate">
        {$jtl_token}
        <input name="u" type="hidden" value="{$oUmfrage->kUmfrage}" />
        {foreach name=umfragefrage from=$oUmfrage->oUmfrageFrage_arr item=oUmfrageFrage}
            {assign var=kUmfrageFrage value=$oUmfrageFrage->kUmfrageFrage}
            <input name="kUmfrageFrage[]" type="hidden" value="{$oUmfrageFrage->kUmfrageFrage}">
            <div {if $oUmfrageFrage->nNotwendig == 1}class="required"{/if}>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">{$oUmfrageFrage->cName} {if $oUmfrageFrage->nNotwendig == 1} *{/if}</h3>
                    </div>
                    <div class="panel-body form-group">
                        {if $oUmfrageFrage->cBeschreibung}
                            <p>{$oUmfrageFrage->cBeschreibung}</p>
                            <hr>
                        {/if}

                        {if $oUmfrageFrage->cTyp === 'select_single'}
                            <tr>
                            <td valign="top" align="left">
                            <select name="{$oUmfrageFrage->kUmfrageFrage}[]" class="form-control"{if $oUmfrageFrage->nNotwendig == 1} required{/if}>
                                <option value="">{lang key="pleaseChoose"}</option>
                        {/if}

                        {if $oUmfrageFrage->cTyp === 'select_multi'}
                            <tr>
                            <td valign="top" align="left">
                            <select name="{$oUmfrageFrage->kUmfrageFrage}[]" multiple="multiple" class="form-control"{if $oUmfrageFrage->nNotwendig == 1} required{/if}>
                        {/if}

                        {if $oUmfrageFrage->cTyp === 'text_klein'}
                            <tr>
                                <td valign="top" align="left">
                                    <input name="{$oUmfrageFrage->kUmfrageFrage}[]"
                                           type="text"
                                           value="{if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr[0])}{$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr[0]}{/if}"
                                           class="form-control"{if $oUmfrageFrage->nNotwendig == 1} required{/if}>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        {/if}

                        {if $oUmfrageFrage->cTyp === 'text_gross'}
                            <tr>
                                <td valign="top" align="left">
                                    <textarea name="{$oUmfrageFrage->kUmfrageFrage}[]" rows="7" cols="60" class="form-control"{if $oUmfrageFrage->nNotwendig == 1} required{/if}>
                                        {if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr[0])}{$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr[0]}{/if}
                                    </textarea>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        {/if}

                    {if $oUmfrageFrage->cTyp === 'matrix_single'}
                        <tr>
                        <td>
                        <table class="table table-bordered">
                        <tr>
                            <td>&nbsp;</td>
                            {foreach name=umfragematrixoption from=$oUmfrageFrage->oUmfrageMatrixOption_arr item=oUmfrageMatrixOption}
                                <td>{$oUmfrageMatrixOption->cName}</td>
                            {/foreach}
                        </tr>
                    {/if}

                    {if $oUmfrageFrage->cTyp === 'matrix_multi'}
                        <tr>
                        <td>
                        <table class="table table-bordered">
                        <tr>
                            <td>&nbsp;</td>
                            {foreach name=umfragematrixoption from=$oUmfrageFrage->oUmfrageMatrixOption_arr item=oUmfrageMatrixOption}
                                <td>{$oUmfrageMatrixOption->cName}</td>
                            {/foreach}
                        </tr>
                    {/if}

                    {foreach name=umfragefrageantwort from=$oUmfrageFrage->oUmfrageFrageAntwort_arr item=oUmfrageFrageAntwort}
                        {math equation='x-y' x=$smarty.foreach.umfragefrageantwort.iteration y=1 assign='i'}

                        {if $oUmfrageFrage->cTyp === 'multiple_single'}
                            <tr>
                                <td valign="top" align="left">
                                    <label>
                                        <input name="{$oUmfrageFrage->kUmfrageFrage}[]"
                                               type="radio"
                                               value="{$oUmfrageFrageAntwort->kUmfrageFrageAntwort}" {if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr)}{foreach name="cumfragefrageantwort" from=$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr item=cUmfrageFrageAntwort}{if $cUmfrageFrageAntwort == $oUmfrageFrageAntwort->kUmfrageFrageAntwort} checked="checked"{/if}{/foreach}{/if} {if $oUmfrageFrage->nNotwendig == 1} required{/if}/>
                                        {$oUmfrageFrageAntwort->cName}
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>
                        {/if}

                        {if $oUmfrageFrage->cTyp === 'multiple_multi'}
                            <div class="checkbox">
                                <label>
                                    <input name="{$oUmfrageFrage->kUmfrageFrage}[]"
                                           type="checkbox"
                                           value="{$oUmfrageFrageAntwort->kUmfrageFrageAntwort}"
                                           {if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr)}{foreach name=cumfragefrageantwort from=$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr item=cUmfrageFrageAntwort}{if $cUmfrageFrageAntwort == $oUmfrageFrageAntwort->kUmfrageFrageAntwort} checked="checked"{/if}{/foreach}{/if}/> {$oUmfrageFrageAntwort->cName}
                                </label>
                            </div>
                        {/if}

                        {if $oUmfrageFrage->cTyp === 'select_single'}
                            <option value="{$oUmfrageFrageAntwort->kUmfrageFrageAntwort}"
                                    {if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr)}{foreach name=cumfragefrageantwort from=$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr item=cUmfrageFrageAntwort}{if $cUmfrageFrageAntwort == $oUmfrageFrageAntwort->kUmfrageFrageAntwort} selected{/if}{/foreach}{/if} > {$oUmfrageFrageAntwort->cName}
                            </option>
                        {/if}

                        {if $oUmfrageFrage->cTyp === 'select_multi'}
                            <option value="{$oUmfrageFrageAntwort->kUmfrageFrageAntwort}"
                                    {if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr)}{foreach name=cumfragefrageantwort from=$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr item=cUmfrageFrageAntwort}{if $cUmfrageFrageAntwort == $oUmfrageFrageAntwort->kUmfrageFrageAntwort} selected{/if}{/foreach}{/if} > {$oUmfrageFrageAntwort->cName}
                            </option>
                        {/if}

                        {if $oUmfrageFrage->cTyp === 'matrix_single'}
                            <tr>
                                <td>{$oUmfrageFrageAntwort->cName}</td>
                                {foreach name=umfragematrixoption from=$oUmfrageFrage->oUmfrageMatrixOption_arr item=oUmfrageMatrixOption}
                                    {math equation='x-y' x=$smarty.foreach.umfragefrageantwort.iteration y=1 assign='i'}
                                    <td>
                                        <div class="radio">
                                            <label><input name="{$oUmfrageFrage->kUmfrageFrage}_{$oUmfrageFrageAntwort->kUmfrageFrageAntwort}"
                                                          type="radio"
                                                          value="{$oUmfrageFrageAntwort->kUmfrageFrageAntwort}_{$oUmfrageMatrixOption->kUmfrageMatrixOption}"
                                                          {if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr)}{foreach name=cumfragefrageantwort from=$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr item=oUmfrageFrageAntwortTMP}{if $oUmfrageFrageAntwortTMP->kUmfrageFrageAntwort == $oUmfrageFrageAntwort->kUmfrageFrageAntwort && $oUmfrageMatrixOption->kUmfrageMatrixOption == $oUmfrageFrageAntwortTMP->kUmfrageMatrixOption} checked{/if}{/foreach}{/if} {if $oUmfrageFrage->nNotwendig == 1} required{/if}/>
                                            </label>
                                        </div>
                                    </td>
                                {/foreach}
                            </tr>
                        {/if}

                        {if $oUmfrageFrage->cTyp === 'matrix_multi'}
                            <tr>
                                <td>{$oUmfrageFrageAntwort->cName}</td>
                                {foreach name=umfragematrixoption from=$oUmfrageFrage->oUmfrageMatrixOption_arr item=oUmfrageMatrixOption}
                                    {math equation='x-y' x=$smarty.foreach.umfragefrageantwort.iteration y=1 assign='i'}
                                    <td>
                                        <input name="{$oUmfrageFrage->kUmfrageFrage}[]"
                                               type="checkbox"
                                               value="{$oUmfrageFrageAntwort->kUmfrageFrageAntwort}_{$oUmfrageMatrixOption->kUmfrageMatrixOption}"
                                               {if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr)}{foreach name=cumfragefrageantwort from=$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr item=oUmfrageFrageAntwortTMP}{if $oUmfrageFrageAntwortTMP->kUmfrageFrageAntwort == $oUmfrageFrageAntwort->kUmfrageFrageAntwort && $oUmfrageMatrixOption->kUmfrageMatrixOption == $oUmfrageFrageAntwortTMP->kUmfrageMatrixOption} checked{/if}{/foreach}{/if}/>
                                    </td>
                                {/foreach}
                            </tr>
                        {/if}

                    {/foreach}
                    {if $oUmfrageFrage->cTyp === 'select_single'}
                        </select>
                        </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                    {/if}

                    {if $oUmfrageFrage->cTyp === 'select_multi'}
                        </select>
                        </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                    {/if}

                        {if $oUmfrageFrage->cTyp === 'matrix_single'}
                                                 </table>
                                              </td>
                                           <tr>
                                              <td>&nbsp;</td>
                                           </tr>
                                           </tr>
                                        {/if}

                        {if $oUmfrageFrage->cTyp === 'matrix_multi'}
                                                 </table>
                                              </td>
                                           <tr>
                                              <td>&nbsp;</td>
                                           </tr>
                                           </tr>
                                        {/if}

                        {if $oUmfrageFrage->nFreifeld == 1}
                            {if $oUmfrageFrage->cTyp === 'multiple_single'}
                                <tr>
                                    <td valign="top" align="left">
                                        <div class="radio">
                                            <label><input name="{$oUmfrageFrage->kUmfrageFrage}[]" type="radio" value="-1"
                                                          {if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr)}{foreach name=cumfragefrageantwort from=$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr item=cUmfrageFrageAntwort}{if $cUmfrageFrageAntwort === '-1'} checked{/if}{/foreach}{/if} {if $oUmfrageFrage->nNotwendig == 1} required{/if}/>
                                                <input
                                                    name="{$oUmfrageFrage->kUmfrageFrage}[]"
                                                    type="text" class="form-control"
                                                    value="{if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr[1])}{$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr[1]}{/if}"/>
                                            </label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                </tr>
                            {elseif $oUmfrageFrage->cTyp === 'multiple_multi'}
                                <tr>
                                    <td valign="top" align="left">
                                        <input name="{$oUmfrageFrage->kUmfrageFrage}[]"
                                               type="checkbox"
                                               value="-1"
                                               {if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr)}{foreach name=cumfragefrageantwort from=$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr item=cUmfrageFrageAntwort}{if $cUmfrageFrageAntwort === '-1'} checked{/if}{/foreach}{/if}/>
                                        <input name="{$oUmfrageFrage->kUmfrageFrage}[]" type="text" class="form-control" value="{if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr[1])}{$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr[1]}{/if}" />
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                </tr>
                            {else}
                                <tr>
                                    <td valign="top" align="left">
                                        <input name="{$oUmfrageFrage->kUmfrageFrage}[]"
                                               type="text" class="form-control"
                                               value="{if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr[1])}{$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr[1]}{/if}"
                                               {if !empty($nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr)}{foreach name=cumfragefrageantwort from=$nSessionFragenWerte_arr[$kUmfrageFrage]->cUmfrageFrageAntwort_arr item=cUmfrageFrageAntwort}{if $cUmfrageFrageAntwort === '-1'} checked{/if}{/foreach}{/if} />
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                </tr>
                            {/if}
                        {/if}
                    </div>{* /panel-body *}
                </div>{* /panel *}
            </div>{* /well *}
        {/foreach}
        <div class="row">
            <div class="col-xs-4">
                {if $nAktuelleSeite <= $nAnzahlSeiten && $nAktuelleSeite != 1}
                    <button class="btn btn-default pull-left" name="back" type="submit" value="back">
                        <span>&laquo; {lang key="umfrageBack" section="umfrage"}</span>
                    </button>
                {/if}
            </div>
            <div class="col-xs-4 text-center">
                <b>{lang key="umfrageQPage" section="umfrage"} {$nAktuelleSeite}</b> {lang key="from" section="product rating"} {$nAnzahlSeiten}
            </div>
            <div class="col-xs-4">
                {if $nAktuelleSeite > 0 && $nAktuelleSeite < $nAnzahlSeiten}
                    <button class="btn btn-default pull-right" name="next" type="submit" value="next">
                        <span>{lang key="umfrageNext" section="umfrage"}</span>
                    </button>
                {/if}
            </div>
        </div>

        <input name="s" type="hidden" value="{$nAktuelleSeite}" />
        {if $nAktuelleSeite == $nAnzahlSeiten}
            <input name="end" type="submit" value="{lang key="umfrageSubmit" section="umfrage"}" class="btn btn-primary submit top17" />
        {/if}
    </form>
{/if}