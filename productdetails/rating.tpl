{if $stars > 0}
    {assign var=filename1 value='rate'}
    {assign var=filename3 value='.png'}
    {if isset($total) && $total > 1}
        {lang key='averageProductRating' section='product rating' assign='ratingLabelText'}
    {else}
        {lang key='productRating' section='product rating' assign='ratingLabelText'}
    {/if}
    {block name="productdetails-rating"}
    <span class="rating preload" title="{$ratingLabelText}: {$stars}/5">
    {strip}
        {if $stars >= 5}
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
        {elseif $stars >= 4}
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            {if $stars > 4}
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-half"></use>
</svg></div>
            </i>
            {else}
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
            {/if}
        {elseif $stars >= 3}
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            {if $stars > 3}
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-half"></use>
</svg></div>
                </i>   
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
            {else}
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
            {/if}
        {elseif $stars >= 2}
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            {if $stars > 2}
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-half"></use>
</svg></div>
                </i>
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
            {else}
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
            {/if}
        {elseif $stars >= 1}
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-full"></use>
</svg></div>
            </i>
            {if $stars > 1}
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-half"></use>
</svg></div>
                </i>
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
            {else}
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
                <i>
                    <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
                </i>
            {/if}
        {elseif $stars > 0}
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star-half"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
            </i>
            <i>
                <div class="image-content icon"><svg><use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-star"></use>
</svg></div>
            </i>
        {/if}
    {/strip}
    </span>
    {/block}
{/if}