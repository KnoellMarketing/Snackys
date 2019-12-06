<form action="navi.php" method="GET" class="input-group">
	<input name="qs" type="search" list="km-search-keys" class="form-control ac_input" placeholder="{lang key='search'}" autocomplete="off" aria-label="{lang key='search'}"/>
	<button type="submit" name="search" id="search-submit-button" aria-label="{lang key='search'}">
		<span class="img-ct icon">
			<svg class="">
			  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-search"></use>
			</svg>
		</span>
	</button>
</form>
<datalist id="km-search-keys">
	<option value="" />
</datalist>