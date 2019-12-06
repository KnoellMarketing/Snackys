<div class="row">
	<button id="close-lightbox">X</button>
    {if $Artikel->Bilder|@count > 1}
    <div id="gallery-thumbs" class="hidden-sm col-md-2 col-lg-2 preload"> 
        {block name="product-image"}
        {foreach $Artikel->Bilder as $image name="thumbnails"}
            {strip}
                <div class="image-wrapper{if $smarty.foreach.thumbnails.first} active{/if}">
                    <div class="image-content">
                    <img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$image->cPfadKlein}" alt="{$image->cAltAttribut|escape:"html"}" data-list='{$image->galleryJSON|replace:"'":"&apos;"}' />
                    </div>
                </div>
            {/strip}
        {/foreach}
        {/block}
    </div>   
    {/if}

    <div id="gallery" class="preload {if $Artikel->Bilder|@count > 1}col-xs-12 col-md-10 col-lg-10{else}col-xs-12{/if}">
        {block name="product-image"}
        {foreach $Artikel->Bilder as $image}
            {strip}
			{assign var=bildGroessen value=$image->galleryJSON|json_decode:1}
                <a href="{$image->cPfadGross}">
                    <div class="image-content" data-src="{$image->cPfadGross}">
                        <img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$image->cPfadNormal}" alt="{$image->cAltAttribut|escape:"html"}" data-list='{$image->galleryJSON|replace:"'":"&apos;"}'
						{if $bildGroessen.lg.size.width > $bildGroessen.md.size.width}
						data-big="{$image->cPfadGross}"
						{/if}
						/>
                    </div>
                </a>
            {/strip}
        {/foreach}
        {/block}
    </div>                                                                                                                                
</div>
{*
<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">

    <div class="pswp__bg"></div>

    <div class="pswp__scroll-wrap">

        <div class="pswp__container">
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
        </div>

        <div class="pswp__ui pswp__ui--hidden">

            <div class="pswp__top-bar">

                <div class="pswp__counter"></div>

                <a class="pswp__button pswp__button--close" title="Close (Esc)"></a>

                <a class="pswp__button pswp__button--share" title="Share"></a>

                <a class="pswp__button pswp__button--fs" title="Toggle fullscreen"></a>

                <a class="pswp__button pswp__button--zoom" title="Zoom in/out"></a>

                <div class="pswp__preloader">
                    <div class="pswp__preloader__icn">
                        <div class="pswp__preloader__cut">
                            <div class="pswp__preloader__donut"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                <div class="pswp__share-tooltip"></div>
            </div>

            <a class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
            </a>

            <a class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
            </a>

            <div class="pswp__caption">
                <div class="pswp__caption__center"></div>
            </div>

        </div>
    </div>
</div>
*}