{if $Einstellungen.template.header.headerUsps == 1}
{assign "uspsCol" "12"}
{elseif $Einstellungen.template.header.headerUsps == 2}
{assign "uspsCol" "6"}
{elseif $Einstellungen.template.header.headerUsps == 3}
{assign "uspsCol" "4"}
{elseif $Einstellungen.template.header.headerUsps == 4}
{assign "uspsCol" "3"}
{/if}
<div id="usps-header" class="hidden-xs small nowrap{if $Einstellungen.template.header.uspsStyle == 1} theme-light{elseif $Einstellungen.template.header.uspsStyle == 2} theme-dark{/if}">
	<div class="mw-container text-center row">
		<div class="col-xs-{$uspsCol} css-check notextov">
			{lang key="headerBenefit1" section="custom"}
		</div>
		{if $Einstellungen.template.header.headerUsps >= 2}
			<div class="col-xs-{$uspsCol} css-check notextov">
				{lang key="headerBenefit2" section="custom"}
			</div>
			{if $Einstellungen.template.header.headerUsps >= 3}
				<div class="col-xs-{$uspsCol} css-check notextov">
					{lang key="headerBenefit3" section="custom"}
				</div>
				{if $Einstellungen.template.header.headerUsps >= 4}
					<div class="col-xs-{$uspsCol} css-check notextov">
						{lang key="headerBenefit4" section="custom"}
					</div>
				{/if}
			{/if}
		{/if}
	</div>
</div>