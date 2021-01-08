<div class="accordeon  {$entry->cClass}" id="accordeon-{$entry-id}">
	{foreach from=$entry->subs item="sub" name="accordeon"}
	<div class="card">
		<div class="card-header"> 
			<a class="card-link" 
			data-toggle="collapse"
			href="#accordeon-{$entry-id}-{$smarty.foreach.accordeon.iteration}">  
				{$sub->cNamePanel}
			</a> 
		</div> 

		<div id="accordeon-{$entry-id}-{$smarty.foreach.accordeon.iteration}" 
		class="collapse{if $smarty.foreach.accordeon.iteration == 1} in{/if}" 
		data-parent="#accordeon-{$entry-id}"> 
			<div class="card-body"> 
				{$sub->cContent}
			</div> 
		</div>
	</div>
	{/foreach}
</div>