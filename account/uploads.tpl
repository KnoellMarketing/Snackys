{if !empty($Bestellung->oUpload_arr)}
    {* tiny left+right container optimized *}
    {assign var=nNameLength value=50}
    {assign var=nImageMaxWidth value=480}
    {assign var=nImageMaxHeight value=320}
    {assign var=nImagePreviewWidth value=35}
    <div id="uploads">
        <h3>{lang key="yourUploads" section="global"}</h3>
        <div class="table-responsive">
            <table class="table table-striped table-bordered" id="customerupload">
                <thead>
                <tr>
                    <th class="text-center">{lang key="uploadAdded" section="global"}</th>
                    <th class="text-center">{lang key="uploadFilesize" section="global"}</th>
                    <th class="text-center">{lang key="uploadFile" section="global"}</th>
                </tr>
                </thead>
                <tbody>
                {foreach from=$Bestellung->oUpload_arr item=oUpload}
                    <tr>
                        <td class="text-center vcenter">
                            <span class="infocur" title="{$oUpload->dErstellt|date_format:"%d.%m.%Y - %H:%M:%S"}">
                                {$oUpload->dErstellt|date_format:"%d.%m.%Y"}
                            </span>
                        </td>
                        <td class="text-center vcenter">{$oUpload->cGroesse}</td>
                        <td class="text-center">
                            <form method="post" action="{get_static_route id='jtl.php'}">
                                {$jtl_token}
                                <input name="kUpload" type="hidden" value="{$oUpload->kUpload}" />
                                <button class="btn btn-default btn-xs" name="{$oUpload->cName}"></button>
                            </form>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
{/if}