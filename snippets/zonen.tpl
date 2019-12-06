{if $id}
	{snackys_content id=$id title=$title}
	{km_zone id=$id title=$title}
	{assign var="opc_id" value="opc_"|cat:$id}
	{opcMountPoint id=$opc_id title=$title}
	{if isset($dropperFound) && $dropperFound ==1}
		{* Muss in eine extra Datei, sonst will Smarty das parsen und bei inaktivem/nicht vorhandenem Dropper gibt es dann Fehler! *}
		{assign var="dropper_id" value="snackys."|cat:$id}
		{include file="snippets/dropper.tpl" id=$dropper_id title=$title name=$title}
	{/if}
{/if}