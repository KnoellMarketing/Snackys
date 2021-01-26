{if isset($Artikel->oKonfig_arr) && $Artikel->oKonfig_arr|@count > 0}
	{assign var="configRequired" value=false}
    <div class="product-configuration top10">
        <div class="modal modal-dialog blanklist in" tabindex="-1" id="config-popup">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-title block h5">
                        {lang key="yourConfiguration" section="global"}
                    </span>
                    <button type="button" class="close-btn" data-dismiss="modal" aria-label="Close" id="close-configmodal"></button>
                </div>
                <div class="modal-body">
                    <div class="">
            <div id="cfg-container">
                {foreach from=$Artikel->oKonfig_arr item=oGruppe}
                    {if $oGruppe->getItemCount() > 0}
                        {assign var=oSprache value=$oGruppe->getSprache()}
                        {assign var=cBildPfad value=$oGruppe->getBildPfad()}
                        {assign var=kKonfiggruppe value=$oGruppe->getKonfiggruppe()}
                        <div class="cfg-group panel panel-default{if $oGruppe->getMin() > 0} required{assign var="configRequired" value=true}{/if}" data-id="{$kKonfiggruppe}">
                            <div class="panel-heading">
                                <h5 class="panel-title">{$oSprache->getName()}</h5>
                            </div>
                            <div class="group panel-body">
                                <div class="group-description">
                                    {if !empty($aKonfigerror_arr[$kKonfiggruppe])}
                                        <div class="actions">
                                            <div class="alert alert-danger">{$aKonfigerror_arr[$kKonfiggruppe]}</div>
                                        </div>
                                    {/if}
                                    {if $oSprache->hatBeschreibung()}
                                        <p class="desc">{$oSprache->getBeschreibung()}</p>
                                    {/if}
                                </div>
                                <div class="row">
                                    {if !empty($cBildPfad)}
                                        <div class="col-md-2 visible-md-block visible-lg-block group-image">
                                            <span class="img-ct">
                                                <img src="{$snackyConfig.preloadImage}" data-src="{$cBildPfad}" alt="{$oSprache->getName()}" id="img{$kKonfiggruppe}" class="img-responsive" />
                                            </span>
                                        </div>
                                    {/if}
                                    <div class="col-md-{if empty($cBildPfad)}12{else}10{/if} group-items">
                                        <ul class="list-group blanklist">
                                            {foreach from=$oGruppe->oItem_arr item=oItem name=konfigitem}
                                                <li class="list-group-item {if $oItem->getEmpfohlen()}highlighted{/if}" data-id="{$oItem->getKonfigitem()}">
                                                    {assign var=kKonfigitem value=$oItem->getKonfigitem()}
                                                    {assign var=cKurzBeschreibung value=$oItem->getKurzBeschreibung()}
                                                    {if !empty($cKurzBeschreibung)}
                                                        {assign var=cBeschreibung value=$oItem->getKurzBeschreibung()}
                                                    {else}
                                                        {assign var=cBeschreibung value=$oItem->getBeschreibung()}
                                                    {/if}
                                                    {if $smarty.foreach.konfigitem.first}
                                                        {if $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN || $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN_MULTI}
                                                        <div class="item clearfix form-group{if isset($aKonfigitemerror_arr[$kKonfigitem]) && $aKonfigitemerror_arr[$kKonfigitem]} error{/if}">
                                                            <select class="form-control" name="item[{$kKonfiggruppe}][]"
                                                                {if $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN_MULTI} multiple="multiple" size="4"{/if} ref="{$kKonfiggruppe}"{if $oGruppe->getMin() > 0} required{assign var="configRequired" value=true}{/if}>
                                                                {if $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN}
                                                                    <option value="">{lang key="pleaseChoose"}</option>
                                                                {/if}
                                                        {/if}
                                                    {/if}
                                                    {if $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_CHECKBOX || $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_RADIO}
                                                        <div class="form-group{if $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_CHECKBOX} checkbox{else} radio{/if}" >
                                                            <label class="btn-block">
                                                                <input type="{if $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_CHECKBOX}checkbox{else}radio{/if}"
                                                                       name="item[{$kKonfiggruppe}][]"
                                                                       id="item{$oItem->getKonfigitem()}"
                                                                       value="{$oItem->getKonfigitem()}"
                                                                       {if isset($nKonfigitem_arr)} data-selected="{if in_array($oItem->getKonfigitem(), $nKonfigitem_arr)}true{else}false{/if}"{else}
                                                                       {if (!empty($aKonfigerror_arr) && isset($smarty.post.item) && isset($smarty.post.item[$kKonfiggruppe]) && $oItem->getKonfigitem()|in_array:$smarty.post.item[$kKonfiggruppe]) || ($oItem->getSelektiert() && (!isset($aKonfigerror_arr) || !$aKonfigerror_arr))} checked="checked"{/if}{/if} />
                                                                {if $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_CHECKBOX}{$oItem->getInitial()}x {/if}
                                                                {$oItem->getName()}
                                                                {if $smarty.session.Kundengruppe->darfPreiseSehen}
                                                                    <span class="badge">{if $oItem->hasRabatt() && $oItem->showRabatt()}
                                                                    <span class="discount">{$oItem->getRabattLocalized()} {lang key="discount"}</span>{elseif $oItem->hasZuschlag() && $oItem->showZuschlag()}
                                                                    <span class="additional">{$oItem->getZuschlagLocalized()} {lang key="additionalCharge"}</span>{/if}{$oItem->getPreisLocalized()}</span>
                                                                {/if}
                                                                {if !empty($cBeschreibung)}
                                                                    <br>
                                                                    <a class="small filter-collapsible-control" data-toggle="collapse" href="#filter-collapsible_checkdio_{$oItem->getKonfigitem()}" aria-expanded="false" aria-controls="filter-collapsible">
                                                                        {lang key="showDescription"} <i class="caret"></i>
                                                                    </a>
                                                                {/if}
                                                            </label>
                                                        </div>
                                                    {elseif $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN || $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN_MULTI}
                                                        <option value="{$oItem->getKonfigitem()}"
                                                                id="item{$oItem->getKonfigitem()}"
                                                                {if isset($nKonfigitem_arr)} data-selected="{if in_array($oItem->getKonfigitem(), $nKonfigitem_arr)}true{else}false{/if}"
                                                                {else}{if $oItem->getSelektiert() && (!isset($aKonfigerror_arr) || !$aKonfigerror_arr)}selected="selected"{/if}{/if}>
                                                            {if $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN_MULTI}{$oItem->getInitial()} &times; {/if}
                                                            {$oItem->getName()}
                                                            {if $smarty.session.Kundengruppe->darfPreiseSehen}
                                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                                {if $oItem->hasRabatt() && $oItem->showRabatt()}({$oItem->getRabattLocalized()} {lang key="discount"})&nbsp;{elseif $oItem->hasZuschlag() && $oItem->showZuschlag()}({$oItem->getZuschlagLocalized()} {lang key="additionalCharge"})&nbsp;{/if}
                                                                {$oItem->getPreisLocalized()}
                                                            {/if}
                                                        </option>
                                                    {/if}
                                                    {if $smarty.foreach.konfigitem.last}
                                                        {if $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN || $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN_MULTI}
                                                            </select>
                                                            {if !empty($cBeschreibung) && $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN}
                                                                <a class="small filter-collapsible-control{if empty($cBeschreibung)} hidden{/if}" data-toggle="collapse" href="#filter-collapsible_dropdown_{$kKonfiggruppe}" aria-expanded="false" aria-controls="filter-collapsible">
                                                                    {lang key="showDescription"} <i class="caret"></i>
                                                                </a>
                                                            {/if}
                                                        </div>
                                                        {/if}
                                                    {/if}
                                                    {if isset($aKonfigitemerror_arr[$kKonfigitem]) && $aKonfigitemerror_arr[$kKonfigitem]}
                                                        <p class="box_error alert alert-danger">{$aKonfigitemerror_arr[$kKonfigitem]}</p>
                                                    {/if}

                                                    {if !empty($cBeschreibung) && $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN}
                                                    <div class="panel-collapse">
                                                        <div id="filter-collapsible_dropdown_{$kKonfiggruppe}" class="collapse top10 panel-body{if empty($cBeschreibung)} hidden{/if}">
                                                            {$cBeschreibung}
                                                        </div>
                                                    </div>
                                                    {elseif !empty($cBeschreibung) && ($oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_CHECKBOX || $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_RADIO)}
                                                        <div class="panel-collapse">
                                                            <div id="filter-collapsible_checkdio_{$oItem->getKonfigitem()}" class="collapse top10 panel-body">
                                                                {$cBeschreibung}
                                                            </div>
                                                        </div>
                                                    {/if}
                                                </li>
                                            {/foreach}
                                        </ul>
                                        {if ($oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_RADIO || $oGruppe->getAnzeigeTyp() == $KONFIG_ANZEIGE_TYP_DROPDOWN)}
                                            {assign var=quantity value=$oGruppe->getInitQuantity()}
                                            {if isset($nKonfiggruppeAnzahl_arr) && array_key_exists($kKonfiggruppe, $nKonfiggruppeAnzahl_arr)}
                                                {assign var=quantity value=$nKonfiggruppeAnzahl_arr[$kKonfiggruppe]}
                                            {/if}

                                            {if !$oGruppe->quantityEquals()}
                                                <div class="quantity form-inline" data-id="{$kKonfiggruppe}" style="display:none">
                                                    <label for="quantity{$kKonfiggruppe}">{lang key="quantity" section="global"}:</label>

                                                    <div class="input-group">
                                                        <input class="form-control" size="2" type="number"
                                                               id="quantity{$kKonfiggruppe}"
                                                               name="quantity[{$kKonfiggruppe}]"
                                                               value="{$quantity}" autocomplete="off"
                                                               min="{$oGruppe->getMin()}" max="{$oGruppe->getMax()}" />
                                                    </div>
                                                </div>
                                            {else}
                                                <div class="quantity">
                                                    <input type="hidden" id="quantity{$kKonfiggruppe}"
                                                           name="quantity[{$kKonfiggruppe}]"
                                                           value="{$quantity}" />
                                                </div>
                                            {/if}
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/if}
                {/foreach}
                <label for="close-configmodal" class="btn btn-primary btn-lg w100 text-center pointer">{lang key="configSet" section="custom"}</label>
            </div>
        </div>
                </div>
            </div>
        </div>
        
            <div id="product-configuration-sidebar">
                <div class="panel panel-primary no-margin">
                    {*<div class="panel-heading">
                        <h5 class="panel-title">{lang key="yourConfiguration" section="global"}</h5>
                    </div>*}
                    <table class="table table-striped m0">
                        <tbody class="summary"></tbody>
                        <tfoot>
                        <tr>
                            <td colspan="3" class="text-right word-break">
                                <strong class="price"></strong>
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                    <div class="panel-footer">         
        <a href="#" data-toggle="modal" data-target="#config-popup" title="Anmelden" class="btn btn-block btn-info btn-lg btn-config">
            {lang key="configButton" section="custom" printf=$Artikel->oKonfig_arr|@count}
        </a>
          <hr class="hr-sm invisible">
                        
                        {if $Artikel->inWarenkorbLegbar == 1}
							{* Prüfen ob in Warenkorb legbar *}
							{assign var="configRequired" value=false}
							{foreach from=$Artikel->oKonfig_arr item=oGruppe}
								{assign var="curGroup" value=$oGruppe->getMin()}
								{foreach from=$oGruppe->oItem_arr item=oItem name=konfigitem}
									{if $oItem->getSelektiert()}
										{assign var="curGroup" value=$curGroup-1}
									{/if}
								{/foreach}
								{if $curGroup>0}
									{assign var="configRequired" value=true}
								{/if}
							{/foreach}
							
							
							
                            <div id="quantity-grp" class="choose_quantity">
                                <input type="number"{if $Artikel->fAbnahmeintervall > 0} required step="{$Artikel->fAbnahmeintervall}"{/if} id="quantity"
                                       class="quantity form-control text-right" name="anzahl"
                                       value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{elseif isset($fAnzahl)}{$fAnzahl}{else}1{/if}" />
                                
                                    <button name="inWarenkorb" type="submit" value="{lang key="addToCart" section="global"}"
                                            class="submit btn btn-primary btn-block{if $configRequired} config-required{/if}"
											{if $configRequired} disabled{/if}>
                                        {if isset($kEditKonfig)}
                                            {lang key="applyChanges" section="global"}
                                        {else}
                                            {lang key="addToCart" section="global"}
                                        {/if}
										{if $configRequired}
											<span class="config-required-info">{lang key="configRequiredInfo" section="custom"}</span>
										{/if}
                                    </button>
                            </div>
                            {if $Artikel->kVariKindArtikel > 0}
                                <input type="hidden" name="a2" value="{$Artikel->kVariKindArtikel}"/>
                            {/if}
                            {if isset($kEditKonfig)}
                                <input type="hidden" name="kEditKonfig" value="{$kEditKonfig}"/>
                            {/if}
                        {/if}
                    </div>
                </div>
            </div>
    </div>
{/if}