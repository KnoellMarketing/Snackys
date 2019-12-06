{block name="account-orders"}
    <h1 class="menu-title">{block name="account-orders-title"}{lang key="yourOrders" section="login"}{/block}</h1>

    {if $Bestellungen|@count > 0}
        {block name="account-orders-body"}
            {assign var=bDownloads value=false}
            {foreach name=bestellungen from=$Bestellungen item=Bestellung}
                {if isset($Bestellung->bDownload) && $Bestellung->bDownload > 0}
                    {assign var=bDownloads value=true}
                {/if}
            {/foreach}

            {include file='snippets/pagination.tpl' oPagination=$orderPagination cThisUrl='jtl.php' cParam_arr=['bestellungen'=>1] parts=['pagi', 'label']}

            <table class="table table-striped">
                <thead class="hidden-xs">
                <tr>
                    <th>{lang key="orderNo" section="login"}</th>
                    <th>{lang key="value" section="login"}</th>
                    <th>{lang key="orderDate" section="login"}</th>
                    <th class="hidden-xs">{lang key="orderStatus" section="login"}</th>
                    {if $bDownloads}
                        <th class="hidden-xs">{lang key="downloads" section="global"}</th>
                    {/if}
                    <th>&nbsp;</th>
                </tr>
                </thead>
                <tbody class="small">
                {foreach name=bestellungen from=$orderPagination->getPageItems() item=Bestellung}
                    <tr>
                        <td>{$Bestellung->cBestellNr}</td>
                        <td>{$Bestellung->cBestellwertLocalized}</td>
                        <td>{$Bestellung->dBestelldatum}</td>
                        <td class="hidden-xs">{$Bestellung->Status}</td>
                        {if $bDownloads}
                            <td class="hidden-xs">
                                {if isset($Bestellung->bDownload) && $Bestellung->bDownload > 0}
                                    <div class="dl_active"></div>
                                {/if}
                            </td>
                        {/if}
                        <td class="text-right">
                            <a class="btn btn-default btn-xs" href="{get_static_route id='jtl.php'}?bestellung={$Bestellung->kBestellung}" title="{lang key="showOrder" section="login"}: {lang key="orderNo" section="login"} {$Bestellung->cBestellNr}">
                                <span>{lang key="showOrder" section="login"}</span>
                            </a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        {/block}
    {else}
        <div class="alert alert-info">{lang key='noEntriesAvailable' section='global'}</div>
    {/if}
{/block}
