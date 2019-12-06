<ul class="social-icons list-inline">
{if !empty($snackyConfig.facebook)}
	<li>
	<a href="{if $snackyConfig.facebook|strpos:'http' !== 0}https://{/if}{$snackyConfig.facebook}" class="img-ct icon btn-facebook" title="Facebook" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-facebook"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.twitter)}
	<li>
	<a href="{if $snackyConfig.twitter|strpos:'http' !== 0}https://{/if}{$snackyConfig.twitter}" class="img-ct icon btn-twitter" title="Twitter" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-twitter"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.googleplus)}
	<li>
	<a href="{if $snackyConfig.googleplus|strpos:'http' !== 0}https://{/if}{$snackyConfig.googleplus}" class="img-ct icon btn-googleplus" title="Google+" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-google-plus"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.youtube)}
	<li>
	<a href="{if $snackyConfig.youtube|strpos:'http' !== 0}https://{/if}{$snackyConfig.youtube}" class="img-ct icon btn-youtube" title="YouTube" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-youtube"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.vimeo)}
	<li>
	<a href="{if $snackyConfig.vimeo|strpos:'http' !== 0}https://{/if}{$snackyConfig.vimeo}" class="img-ct icon btn-vimeo" title="Vimeo" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-vimeo"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.pinterest)}
	<li>
	<a href="{if $snackyConfig.pinterest|strpos:'http' !== 0}https://{/if}{$snackyConfig.pinterest}" class="img-ct icon btn-pinterest" title="PInterest" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-pinterest"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.instagram)}
	<li>
	<a href="{if $snackyConfig.instagram|strpos:'http' !== 0}https://{/if}{$snackyConfig.instagram}" class="img-ct icon btn-instagram" title="Instagram" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-instagram"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.skype)}
	<li>
	<a href="{if $snackyConfig.skype|strpos:'skype:' !== 0}skype:{$snackyConfig.skype}?add{else}{$snackyConfig.skype}{/if}" class="img-ct icon btn-skype" title="Skype" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-skype"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.xing)}
	<li>
	<a href="{if $snackyConfig.xing|strpos:'http' !== 0}https://{/if}{$snackyConfig.xing}" class="img-ct icon btn-xing" title="Xing" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-xing"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.linkedin)}
	<li>
	<a href="{if $snackyConfig.linkedin|strpos:'http' !== 0}https://{/if}{$snackyConfig.linkedin}" class="img-ct icon btn-linkedin" title="Linkedin" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-linkedin"></use>
		</svg>
	</a>
	</li>
{/if}
</ul>