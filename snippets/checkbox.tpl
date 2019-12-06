{if empty($cPost_arr)}
    {assign var='cPost_arr' value=null}
{/if}

{if empty($cPost_arr)}
    {assign var='cPost_arr' value=$smarty.post}
{/if}

{getCheckBoxForLocation nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$cPlausi_arr cPost_arr=$cPost_arr assign='checkboxes'}

{if !empty($checkboxes)}
    {foreach name="checkboxes" from=$checkboxes item='cb'}
        <div class="form-group{if !empty($cb->cErrormsg)} has-error{/if}{if $cb->nPflicht == 1} required{/if}">
            <div class="checkbox">
                <label class="control-label" for="{if isset($cIDPrefix)}{$cIDPrefix}_{/if}{$cb->cID}">
                    <input type="checkbox"
                           name="{$cb->cID}"
                            {if $cb->nPflicht == 1}
                                required
                            {/if}
                           value="Y" id="{if isset($cIDPrefix)}{$cIDPrefix}_{/if}{$cb->cID}"
                            {if $cb->isActive}
                                checked
                            {/if}
                            >
                    {$cb->cName}
                    {if !empty($cb->cLinkURL)}
                        <span class="moreinfo">(<a href="{$cb->cLinkURL}" class="popup checkbox-popup">{lang key="read" section="account data"}</a>)</span>
                    {/if}
                </label>
            </div>
            {if !empty($cb->cBeschreibung)}
                <p class="description text-muted small">
                    {$cb->cBeschreibung}
                </p>
            {/if}
        </div>
    {/foreach}
{/if}