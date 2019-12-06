{if $snackyConfig.headerUsps == 1}
{assign "uspsCol" "12"}
{elseif $snackyConfig.headerUsps == 2}
{assign "uspsCol" "6"}
{elseif $snackyConfig.headerUsps == 3}
{assign "uspsCol" "4"}
{elseif $snackyConfig.headerUsps == 4}
{assign "uspsCol" "3"}
{/if}
<div id="h-us" class="hidden-xs small nowrap{if $snackyConfig.uspsStyle == 1} th-l{elseif $snackyConfig.uspsStyle == 2} th-d{/if}">
	<div class="mw-container text-center row">
		<span class="col-xs-{$uspsCol} css-check notextov">
			{lang key="headerBenefit1" section="custom"}
		</span>
		{if $snackyConfig.headerUsps >= 2}
			<span class="col-xs-{$uspsCol} css-check notextov">
				{lang key="headerBenefit2" section="custom"}
			</span>
			{if $snackyConfig.headerUsps >= 3}
				<span class="col-xs-{$uspsCol} css-check notextov">
					{lang key="headerBenefit3" section="custom"}
				</span>
				{if $snackyConfig.headerUsps >= 4}
					<span class="col-xs-{$uspsCol} css-check notextov">
						{lang key="headerBenefit4" section="custom"}
					</span>
				{/if}
			{/if}
		{/if}
	</div>
</div>