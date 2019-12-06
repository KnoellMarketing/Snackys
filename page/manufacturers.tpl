{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

<div class="row row-eq-height content-cats-small clearfix">
    {foreach name=hersteller from=$oHersteller_arr item=Hersteller}
        <div class="col-xs-6 col-md-4 col-lg-3">
            <div class="thumbnail">
                <div class="caption">
                    <a href="{$Hersteller->cURL}" class="text-center" title="{$Hersteller->cMetaTitle}">
                        <img src="{$Hersteller->cBildpfadNormal}" alt="{$Hersteller->cName}" />
                        {$Hersteller->cName}
                    </a>
                </div>
            </div>
        </div>
    {/foreach}
</div>
