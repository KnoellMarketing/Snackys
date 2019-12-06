{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

<ul class="list-unstyled">
    {foreach name=tagging from=$Tagging item=tag}
        <li class="tag"><a href="{$tag->cURL}">{$tag->cName}</a> <span class="badge">{$tag->Anzahl}</span></li>
    {/foreach}
</ul>