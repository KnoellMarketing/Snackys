{if isset($oBox->globaleMerkmale) && $oBox->globaleMerkmale|@count > 0}
    {assign var=gmma value=$oBox->globaleMerkmale}
{elseif isset($Boxen.oGlobalMerkmal_arr) && $Boxen.oGlobalMerkmal_arr|@count > 0}
    {assign var=gmma value=$Boxen.oGlobalMerkmal_arr}
{else}
    {assign var=gmma value=""}
{/if}

{foreach name=globalemerkmale from=$gmma item=oMerkmal}
    {if !empty($oMerkmal)}
    <section class="panel panel-default box box-global-characteristics" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <h5 class="panel-title">
            {if !empty($oMerkmal->cBildpfadKlein) && $oMerkmal->cBildpfadKlein !== $BILD_KEIN_MERKMALBILD_VORHANDEN}
                <img src="{$oMerkmal->cBildpfadKlein}" alt="" class="vmiddle" />
            {/if}
            {$oMerkmal->cName}
            </h5>
        </div>
        <div class="box-body">
            {if ($oMerkmal->cTyp === 'SELECTBOX') && $oMerkmal->oMerkmalWert_arr|@count > 1}
                <div class="dropdown">
                    <button class="btn btn-default btn-block dropdown-toggle" type="button" id="dropdown-characteristics-{$oMerkmal->kMerkmal}" data-toggle="dropdown" aria-expanded="true">
                        {$oMerkmal->cName}
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdown-characteristics-{$oMerkmal->kMerkmal}">
                        {foreach name=merkmalwertfilter from=$oMerkmal->oMerkmalWert_arr item=oMerkmalWert}
                            <li role="presentation">
                                <a role="menuitem" tabindex="-1" href="{$oMerkmalWert->cSeo}">
                                    {if ($oMerkmal->cTyp === 'BILD' || $oMerkmal->cTyp === 'BILD-TEXT') && !empty($oMerkmalWert->cBildpfadKlein) && $oMerkmalWert->cBildpfadKlein !== 'gfx/keinBild_kl.gif'}
                                       <img src="{$oMerkmalWert->cBildpfadKlein}" alt="{$oMerkmalWert->cWert|escape:"quotes"}" />
                                    {/if}
                                    {if $oMerkmal->cTyp !== 'BILD'}
                                        {$oMerkmalWert->cWert}
                                    {/if}
                                </a>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            {else}
                <ul class="nav nav-list">
                    {foreach name=globalmerkmalwert from=$oMerkmal->oMerkmalWert_arr item=oMerkmalWert}
                        <li>
                            <a href="{$oMerkmalWert->cURL}"{if isset($NaviFilter->MerkmalWert->kMerkmalWert) && $NaviFilter->MerkmalWert->kMerkmalWert > 0 && isset($oMerkmalWert->kMerkmalWert) && $NaviFilter->MerkmalWert->kMerkmalWert == $oMerkmalWert->kMerkmalWert} class="active"{/if}>
                                {if ($oMerkmal->cTyp === 'BILD' || $oMerkmal->cTyp === 'BILD-TEXT') && !empty($oMerkmalWert->cBildpfadKlein) && $oMerkmalWert->cBildpfadKlein !== 'gfx/keinBild_kl.gif'}
                                   <img src="{$oMerkmalWert->cBildpfadKlein}" alt="{$oMerkmalWert->cWert|escape:"quotes"}" />
                                {/if}
                                {if $oMerkmal->cTyp !== 'BILD'}
                                    {$oMerkmalWert->cWert}
                                {/if}
                            </a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
        </div>
    </section>
    {/if}
{/foreach}