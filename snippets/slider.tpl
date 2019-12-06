{if isset($oSlider) && count($oSlider->oSlide_arr) > 0}
    <div class=" slider-wrapper theme-{$oSlider->cTheme}{if $oSlider->bControlNav} control-nav{/if}{if $oSlider->bDirectionNav} direction-nav{/if}{if $oSlider->bThumbnail} thumbnail-nav{/if}">
        <div id="slider-{$oSlider->kSlider}" class="full-width-slider preload {if isset($oSlider) && count($oSlider->oSlide_arr) > 1}is--slider{/if}">
            {foreach from=$oSlider->oSlide_arr item=oSlide}
                {assign var="slideTitle" value=$oSlide->cTitel}
                {if !empty($oSlide->cText)}
                    {assign var="slideTitle" value="#slide_caption_{$oSlide->kSlide}"}
                {/if}
                {if !empty($oSlide->cLink)}
                    <a href="{$oSlide->cLink}" class="slide">
                {else}
                    <div class="slide">
                {/if}
				<div class="image-content">
					<img alt="{$oSlide->cTitel}" src="{$snackysTemplate}img/preload/1x1.png" data-src="mediafiles/{$oSlide->cBild}"{if !empty($oSlide->cThumbnail) && $oSlider->bThumbnail == '1'} data-thumb="mediafiles/{$oSlide->cThumbnail}"{/if}/>
                </div>
                        
                    {if !empty($oSlide->cText)}
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
        {if isset($oSlider) && count($oSlider->oSlide_arr) > 1}
        <div class="dots-wrapper"></div>
        {/if}
    </div>
	
	{getSizeBySrc src=$oSlider->oSlide_arr[0]->cBildAbsolut cAssign="sliderSize"}
	{if !empty($sliderSize.padding)}
	<style type="text/css">
	.full-width-slider .image-content:before {ldelim} padding-top: {$sliderSize.padding}%{rdelim}
	</style>
	{/if}
{/if}