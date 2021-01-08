{getSliderPerDevice cAssign="oSliderDevice"}
{if isset($oSliderDevice) && count($oSliderDevice->oSlide_arr) > 0}
	{include file="snippets/zonen.tpl" id="before_slider" title="before_slider"}
    <div class="sl-w panel-slider">
		{if isset($oSliderDevice) && count($oSliderDevice->oSlide_arr) > 1 && !$device->isMobile() && $oSliderDevice->nPauseTime<=300}
			<span class="sl-ar sl-pr btn inactive">
				<span class="ar ar-l"></span>
			</span>
		{/if}
        <div id="slider-{$oSliderDevice->kSlider}" class="fw-sl no-scrollbar"{if $oSliderDevice->nPauseTime>300} data-autoplay="{$oSliderDevice->nPauseTime}"{/if}>
            {foreach from=$oSliderDevice->oSlide_arr item=oSlide}
                {assign var="slideTitle" value=$oSlide->cTitel}
                {if !empty($oSlide->cText)}
                    {assign var="slideTitle" value="#slide_caption_{$oSlide->kSlide}"}
                {/if}
                {if !empty($oSlide->cLink)}
                    <a href="{$oSlide->cLink}" class="slide">
                {else}
                    <div class="slide">
                {/if}
				<div class="img-ct">
					<img alt="{if !empty($oSlide->cTitel)}{$oSlide->cTitel}{else}Slide{/if}" src="{$snackyConfig.preloadImage}" data-src="mediafiles/{$oSlide->cBild}"/>
                </div>
                    {if !empty($oSlide->cText) || !empty($oSlide->cTitel)}
                        <div id="slide_caption_{$oSlide->kSlide}" class="htmlcaption">
                            {if isset($oSlide->cTitel)}<strong class="title h4">{$oSlide->cTitel}</strong>{/if}
                            <p class="desc">{$oSlide->cText}</p>
                        </div>
                    {/if}

                {if !empty($oSlide->cLink)}
                    </a>
                {else}
                    </div>
                {/if}
            {/foreach}
        </div>
		{if isset($oSliderDevice) && count($oSliderDevice->oSlide_arr) > 1 && !$device->isMobile() && $oSliderDevice->nPauseTime<=300}
			<span class="sl-ar sl-nx btn">
				<span class="ar ar-r"></span>
			</span>
		{/if}
    </div>
	
	
	{getSizeBySrc src="mediafiles{$oSliderDevice->oSlide_arr[0]->cBild}" cAssign="sliderSize"}
	{if !empty($sliderSize.padding)}
	<style type="text/css">
	.fw-sl .img-ct:before {ldelim} padding-top: {$sliderSize.padding}%;{rdelim}
	</style>
	{/if}
{/if}