{zone id="snackys.{$id}" info="Snackys Template" name=$title ghost=true}
	{if isset($smarty.get.zonePicker)}
		<div class="dropper-box">Dropper-Zone: {$id}</div>
	{/if}
{/zone}