{if !empty($oAuswahlAssistent->kAuswahlAssistentGruppe)}
    {$xajax_javascript}
    <div id="selection_wizard">
        {include file="productwizard/form.tpl"}
    </div>
{elseif isset($AWA)}
    {include file="selectionwizard/index.tpl"}
{/if}