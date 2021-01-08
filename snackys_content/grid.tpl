<div class="row row-multi">
{foreach from=$entry->subs item="sub"}
	<div class="{if $sub->xs == 0}hidden-xs{else}col-xs-{$sub->xs}{/if} {if $sub->sm == 0}hidden-sm{else}col-sm-{$sub->sm}{/if} {if $sub->md == 0}hidden-md{else}col-md-{$sub->md}{/if} {if $sub->lg == 0}hidden-lg{else}col-lg-{$sub->lg}{/if}">
		{$sub->rendered}
	</div>
{/foreach}
</div>