{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
{if isset($oBox->oNewsKategorie_arr) && $oBox->oNewsKategorie_arr|@count > 0}
    <section class="panel panel-default box box-newscategories" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
				{lang key="newsBoxCatOverview" section="global"}
				{include file="snippets/careticon.tpl"}
			</span>
        </div>
        <div class="box-body dropdown">
            <ul class="nav nav-list blanklist">
                {foreach name=newskategorie from=$oBox->oNewsKategorie_arr item=oNewsKategorie}
                    <li>
                        <a href="{$oNewsKategorie->cURL}" title="{$oNewsKategorie->cName}">
                            <span class="value dpflex-j-between w100">
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
           <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
			    {lang key="newsBoxCatOverview" section="global"}
				{include file="snippets/careticon.tpl"}
		   </span>
       </div>{* /panel-heading *}
       <div class="panel-body">
          <ul class="blanklist">
          {foreach name=newskategorie from=$Boxen.NewsKategorie->oNewsKategorie_arr item=oNewsKategorie}
             <li>
                 <a href="{$oNewsKategorie->cURL}" title="{$oNewsKategorie->cBeschreibung|escape:"html"}" class="tooltip">
                     <span class="value dpflex-j-between w100">
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
{/if}