<div class="row">
	<span id="close-lightbox" class="close-btn dpflex-j-center"></span>
    {if $Artikel->Bilder|@count > 1 && !$device->isMobile()}
    <div id="gallery-thumbs" class="col-xs-12 col-md-2 col-lg-2{if $Artikel->Bilder|@count > 5} two-cols dpflex-j-between dpflex-wrap{/if}"> 
        {block name="product-image"}
        {foreach $Artikel->Bilder as $image name="thumbnails"}
            {strip}
                <div class="img-w{if $smarty.foreach.thumbnails.first} active{/if}">
                    <div class="img-ct">
                    <img src="{$snackyConfig.preloadImage}" data-src="{$image->cPfadKlein}" alt="{$image->cAltAttribut|escape:"html"}" data-list='{$image->galleryJSON|replace:"'":"&apos;"}' />
                    </div>
                </div>
            {/strip}
        {/foreach}
        {/block}
    </div>   
    {/if}

    <div id="gallery" class="{if $Artikel->Bilder|@count > 1 && !$device->isMobile()}col-xs-12 col-md-10 col-lg-10{else}col-xs-12{/if}">
		{if $Artikel->Bilder|@count > 1 && $device->isMobile()}
			<div id="gallery-prev" class="sl-ar sl-pr">
				<div class="ar ar-l"></div>
			</div>
		{/if}
		<div class="inner">
        {block name="product-image"}
        {foreach $Artikel->Bilder as $image name="gallery"}
			{if $smarty.foreach.gallery.first}<meta itemprop="image" content="{$image->cPfadGross}">{/if}
            {strip}
			{assign var=bildGroessen value=$image->galleryJSON|json_decode:1}
                <a href="{$image->cPfadGross}"{if $smarty.foreach.gallery.first} class="active"{/if}>
                    <div class="img-ct" data-src="{$image->cPfadGross}">
                        <img {if $smarty.foreach.gallery.first}src="{$image->cPfadNormal}"{else}src="{$snackyConfig.preloadImage}" data-src="{$image->cPfadNormal}"{/if} alt="{$image->cAltAttribut|escape:"html"}" data-list='{$image->galleryJSON|replace:"'":"&apos;"}'
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
		{if $Artikel->Bilder|@count > 1 && $device->isMobile()}
			<div id="gallery-next" class=" sl-ar sl-nx">
				<div class="ar ar-r"></div>
			</div>
		{/if}   
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