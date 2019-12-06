{if isset($oBox->oNewsKategorie_arr) && $oBox->oNewsKategorie_arr|@count > 0}
    <section class="panel panel-default box box-newscategories" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <h5 class="panel-title">{lang key="newsBoxCatOverview" section="global"}</h5>
        </div>
        <div class="box-body dropdown">
            <ul class="nav nav-list">
                {foreach name=newskategorie from=$oBox->oNewsKategorie_arr item=oNewsKategorie}
                    <li>
                        <a href="{$oNewsKategorie->cURL}" title="{$oNewsKategorie->cName}">
                            <span class="value">
                                {$oNewsKategorie->cName} <span class="badge pull-right">{$oNewsKategorie->nAnzahlNews}</span>
                            </span>
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </section>
{elseif isset($Boxen.NewsKategorie->oNewsKategorie_arr) && $Boxen.NewsKategorie->oNewsKategorie_arr|@count > 0}
    <section class="panel panel-default box box-newscategories" id="sidebox{$oBox->kBox}">
       <div class="panel-heading">
           <h5 class="panel-title">{lang key="newsBoxCatOverview" section="global"}</h5>
       </div>{* /panel-heading *}
       <div class="panel-body">
          <ul>
          {foreach name=newskategorie from=$Boxen.NewsKategorie->oNewsKategorie_arr item=oNewsKategorie}
             <li>
                 <a href="{$oNewsKategorie->cURL}" title="{$oNewsKategorie->cBeschreibung|escape:"html"}" class="tooltip">
                     <span class="value">
                         {$oNewsKategorie->cName}
                         <span class="badge">{$oNewsKategorie->nAnzahlNews}</span>
                     </span>
                 </a>
             </li>
          {/foreach}
          </ul>
       </div>
    </section>
{/if}