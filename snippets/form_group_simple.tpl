{if !empty($options)}
    {assign var='inputType' value=$options[0]}
    {assign var='inputId' value=$options[1]}
    {assign var='inputName' value=$options[2]}
    {assign var='inputValue' value=$options[3]}
    {assign var='label' value=$options[4]}
    {if isset($options[5])}
        {assign var='required' value=$options[5]}
    {/if}
    {if isset($options[6])}
        {assign var='invalidReason' value=$options[6]}
    {/if}
{/if}

{if isset($required) && $required == 'Y'}
    {assign var='isRequired' value=true}
{else}
    {assign var='isRequired' value=false}
{/if}

{if isset($invalidReason) && $invalidReason|strlen > 0}
    {assign var='hasError' value=true}
{elseif !empty($fehlendeAngaben) && isset($fehlendeAngaben.{$inputName})}
    {assign var='hasError' value=true}
    {lang assign="invalidReason" key="fillOut" section="global"}
{else}
    {assign var='hasError' value=false}
{/if}


<div class="form-group{if $hasError} has-error{/if}{if $isRequired} required{/if}">
    <label for="{$inputId}" class="control-label">{$label}{* {if $isRequired}<span class="indication"></span>{else}<span class="indication">({lang section='checkout' key="conditionalFillOut"})</span>{/if} *}</label>
    <input type="{if isset($inputType)}{$inputType}{else}text{/if}" name="{$inputName}" value="{if isset($inputValue)}{$inputValue}{/if}" id="{$inputId}" class="form-control" placeholder="{if isset($placeholder)}{$placeholder}{else}{$label}{/if}"{if $isRequired} required{/if}>
    {if isset($invalidReason) && $invalidReason|strlen > 0}
        <div class="form-error-msg text-danger">{$invalidReason}</div>
    {/if}
</div>