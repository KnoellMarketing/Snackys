{* if !empty($hinweis)}
    <div class="alert alert-info">
        {$hinweis}
    </div>
{/if}
{if !empty($fehler)}
    <div class="alert alert-danger">
        {$fehler}
    </div>
{/if *}

{if !empty($Artikel->oMedienDatei_arr)}
    {assign var=mp3List value=false}
    {assign var=titles value=false}
    <div class="row row-multi">
    {foreach name="mediendateien" from=$Artikel->oMedienDatei_arr item=oMedienDatei}
        {if ($cMedienTyp == $oMedienDatei->cMedienTyp
            && $oMedienDatei->cAttributTab|count_characters == 0)
            || ($oMedienDatei->cAttributTab|count_characters > 0
                && $cMedienTyp|@seofy == $oMedienDatei->cAttributTab|@seofy)}
            {if $oMedienDatei->nErreichbar == 0}
                <div class="col-xs-12">
                    <p class="box_error">
                        {lang key="noMediaFile" section="errorMessages"}
                    </p>
                </div>
            {else}
                {assign var=cName value=$oMedienDatei->cName}
                {assign var=titles value=$titles|cat:$cName}
                {if !$smarty.foreach.mediendateien.last}
                    {assign var=titles value=$titles|cat:'|'}
                {/if}

                {* Images *}
                {if $oMedienDatei->nMedienTyp == 1}
                    <div class="col-xs-12">
                        <div class="panel-wrap">
                            <div class="panel panel-default">
                                <div class="panel-heading">
									<h3 class="panel-title h4">{$oMedienDatei->cName}</h3>
								</div>
                                <div class="panel-body">
                                    {if isset($oMedienDatei->oMedienDateiAttribut_arr) && $oMedienDatei->oMedienDateiAttribut_arr|@count > 0}
                                        {foreach name="mediendateiattribute" from=$oMedienDatei->oMedienDateiAttribut_arr item=oAttribut}
                                            {if $oAttribut->cName == "img_alt"}
                                                {assign var=cMediaAltAttr value=$oAttribut->cWert}
                                            {/if}
                                        {/foreach}
                                    {/if}
                                    {if !empty($oMedienDatei->cPfad)}
                                        <img alt="{if isset($cMediaAltAttr)}{$cMediaAltAttr}{else}Mediafile{/if}" src="{$PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" class="img-responsive img-brd" />
                                    {elseif !empty($oMedienDatei->cURL)}
                                        <img alt="{if isset($cMediaAltAttr)}{$cMediaAltAttr}{else}Mediafile{/if}" src="{$oMedienDatei->cURL}" class="img-responsive img-brd" />
                                    {/if}
                                    <p>{$oMedienDatei->cBeschreibung}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    {* Audio *}
                {elseif $oMedienDatei->nMedienTyp == 2}
                    {if $oMedienDatei->cName|strlen > 1}
                        <div class="col-xs-12">
                            <div class="panel-wrap">
                                <div class="panel panel-default">
                                    <div class="panel-heading"><h3 class="panel-title h4">{$oMedienDatei->cName}</h3></div>
                                    <div class="panel-body">
                                        <p>{$oMedienDatei->cBeschreibung}</p>
                                        {* Music *}
                                        {if $oMedienDatei->cPfad|strlen > 1 || $oMedienDatei->cURL|strlen > 1}
                                            {assign var=audiosrc value=$oMedienDatei->cURL}
                                            {if $oMedienDatei->cPfad|strlen > 1}
                                                {assign var=audiosrc value=$PFAD_MEDIAFILES|cat:$oMedienDatei->cPfad}
                                            {/if}
                                            {if $audiosrc|strlen > 1}
                                                <audio controls>
                                                    <source src="{$audiosrc}" type="audio/mpeg">
                                                    Your browser does not support the audio element.
                                                </audio>
                                            {/if}
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                        {* Audio *}
                    {/if}

                    {* Video *}
                {elseif $oMedienDatei->nMedienTyp == 3}
                    {*<div class="col-xs-12">
                        <div class="panel-wrap">
                            <div class="panel panel-default">
                                <div class="panel-heading"><h3 class="panel-title">{$oMedienDatei->cName}</h3></div>
                                <div class="panel-body">
                                    <p>{$oMedienDatei->cBeschreibung}</p>
                                    {if !empty($oMedienDatei->cPfad)}
                                        <object type="application/x-shockwave-flash" data="{$PFAD_FLASHPLAYER}player_flv_multi.swf" width="320" height="240">
                                            <param name="movie" value="{$PFAD_FLASHPLAYER}player_flv_maxi.swf" />
                                            <param name="allowFullScreen" value="true" />
                                            <param name="FlashVars" value="flv={$PFAD_MEDIAFILES}{$oMedienDatei->cPfad}&width=320&height=240&showvolume=1&showtime=1&showfullscreen=1" />
                                        </object>
                                    {elseif !empty($oMedienDatei->cURL)}
                                        <object type="application/x-shockwave-flash" data="{$PFAD_FLASHPLAYER}player_flv_multi.swf" width="320" height="240">
                                            <param name="movie" value="{$PFAD_FLASHPLAYER}player_flv_maxi.swf" />
                                            <param name="allowFullScreen" value="true" />
                                            <param name="FlashVars" value="flv={$oMedienDatei->cURL}&width=320&height=240&showvolume=1&showtime=1&showfullscreen=1" />
                                        </object>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </div>*}
                    {* Sonstiges *}
                {elseif $oMedienDatei->nMedienTyp == 4}
                    <div class="col-xs-12">
                        <div class="panel-wrap">
                            <div class="panel panel-default">
                                <div class="panel-heading"><h3 class="panel-title h4">{$oMedienDatei->cName}</h3></div>
                                <div class="panel-body">
                                    <p>{$oMedienDatei->cBeschreibung}</p>
                                    {if $oMedienDatei->oEmbed->code}
                                        {$oMedienDatei->oEmbed->code}
                                    {/if}
                                    {if !empty($oMedienDatei->cPfad)}
										<a href="{$PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" target="_blank" class="dpflex-a-center">
                                    {elseif !empty($oMedienDatei->cURL)}
										<a href="{$oMedienDatei->cURL}" target="_blank" class="dpflex-a-center">
									{else}
										<a>
                                    {/if}
										<span class="img-ct icon icon-wt">
											<svg class="">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-link"></use>
											</svg>
										</span>
										<span class="text-brand">{$oMedienDatei->cName} </span> 
									</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    {* PDF *}
                {elseif $oMedienDatei->nMedienTyp == 5}
                    <div class="col-xs-12">
                        <div class="panel-wrap">
                            <div class="panel panel-default">
                                <div class="panel-heading"><h3 class="panel-title h4">{$oMedienDatei->cName}</h3></div>
                                <div class="panel-body">
                                    <p>{$oMedienDatei->cBeschreibung}</p>
									{if !empty($oMedienDatei->cPfad)}
									<a href="{$PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" target="_blank" class="dpflex-a-center">
									{elseif !empty($oMedienDatei->cURL)}
									<a href="{$oMedienDatei->cURL}" target="_blank" class="dpflex-a-center">
									{else}
									<a>
									{/if}
										<span class="img-ct icon icon-xl icon-wt">
											<svg class="">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-pdf"></use>
											</svg>
										</span>
										<span class="text-brand">{$oMedienDatei->cName} </span>                                   
									</a>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
            {/if}
        {/if}
    {/foreach}
    </div>{* /row *}
{/if}