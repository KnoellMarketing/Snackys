<ul class="social-icons list-inline">
{if !empty($Einstellungen.template.footer.facebook)}
	<li>
	<a href="{if $Einstellungen.template.footer.facebook|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.facebook}" class="image-content icon btn-facebook" title="Facebook" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-facebook"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($Einstellungen.template.footer.twitter)}
	<li>
	<a href="{if $Einstellungen.template.footer.twitter|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.twitter}" class="image-content icon btn-twitter" title="Twitter" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-twitter"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($Einstellungen.template.footer.googleplus)}
	<li>
	<a href="{if $Einstellungen.template.footer.googleplus|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.googleplus}" class="image-content icon btn-googleplus" title="Google+" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-google-plus"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($Einstellungen.template.footer.youtube)}
	<li>
	<a href="{if $Einstellungen.template.footer.youtube|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.youtube}" class="image-content icon btn-youtube" title="YouTube" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-youtube"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($Einstellungen.template.footer.vimeo)}
	<li>
	<a href="{if $Einstellungen.template.footer.vimeo|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.vimeo}" class="image-content icon btn-vimeo" title="Vimeo" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-vimeo"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($Einstellungen.template.footer.pinterest)}
	<li>
	<a href="{if $Einstellungen.template.footer.pinterest|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.pinterest}" class="image-content icon btn-pinterest" title="PInterest" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-pinterest"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($Einstellungen.template.footer.instagram)}
	<li>
	<a href="{if $Einstellungen.template.footer.instagram|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.instagram}" class="image-content icon btn-instagram" title="Instagram" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-instagram"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($Einstellungen.template.footer.skype)}
	<li>
	<a href="{if $Einstellungen.template.footer.skype|strpos:'skype:' !== 0}skype:{$Einstellungen.template.footer.skype}?add{else}{$Einstellungen.template.footer.skype}{/if}" class="image-content icon btn-skype" title="Skype" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-skype"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($Einstellungen.template.footer.xing)}
	<li>
	<a href="{if $Einstellungen.template.footer.xing|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.xing}" class="image-content icon btn-xing" title="Xing" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-xing"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($Einstellungen.template.footer.linkedin)}
	<li>
	<a href="{if $Einstellungen.template.footer.linkedin|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.linkedin}" class="image-content icon btn-linkedin" title="Linkedin" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-linkedin"></use>
		</svg>
	</a>
	</li>
{/if}
</ul>