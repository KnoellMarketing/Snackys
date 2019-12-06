{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

<h1>{lang key="umfrage" section="umfrage"}</h1>

{if !empty($hinweis)}
    <div class="alert alert-info successTip">
        {$hinweis}
    </div>
{/if}
{if !empty($fehler)}
    <div class="alert alert-danger errorTip">
        {$fehler}
    </div>
{/if}