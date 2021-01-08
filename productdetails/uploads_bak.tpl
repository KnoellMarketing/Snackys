{if !empty($oUploadSchema_arr)}
    <script type="text/javascript" src="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/fileinput.min.js"></script>
    {assign var=availableLocale value=array('ar', 'bg', 'cr', 'cz', 'da', 'de', 'el', 'es', 'fa', 'fr', 'hu', 'lt', 'nl', 'pl', 'pt', 'sk', 'uk')}
    {if isset($smarty.session.currentLanguage->cISO639) && $smarty.session.currentLanguage->cISO639|in_array:$availableLocale}
        {assign var=uploaderLang value=$smarty.session.currentLanguage->cISO639}
    {else}
        {assign var=uploaderLang value='en'}
    {/if}
    <script type="text/javascript" src="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/fileinput_locale_{$uploaderLang}.js"></script>

    <link href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}themes/base/fileinput.min.css" rel="stylesheet" type="text/css">
    <h3 class="section-heading">{lang key="uploadHeadline"}</h3>
    <div class="mb-spacer mb-small">{lang key="maxUploadSize"}: <strong>{$cMaxUploadSize}</strong></div>
    {foreach from=$oUploadSchema_arr item=oUploadSchema name=schema}
        <div class="panel panel-default mb-spacer mb-small">
            <div class="panel-heading">
                <span class="panel-title block m0">
                    {$oUploadSchema->cName}
                    {if !empty($oUploadSchema->WarenkorbPosEigenschaftArr)}
                            {foreach name=variationen from=$oUploadSchema->WarenkorbPosEigenschaftArr item=Variation}
                                - {$Variation->cEigenschaftName|trans}: {$Variation->cEigenschaftWertName|trans}
                            {/foreach}
                    {/if}
                </span>
            </div>
            <div class="panel-body">
                {foreach from=$oUploadSchema->oUpload_arr item=oUpload name=upload}
                <div class="wrapper">
                    <div class="row dpflex-a-center">
                        <div class="col-xs-9 dpflex-a-center">
                            {*
                            <span class="img-ct icon icon-wt fileicon">
                                <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-pdf"></use>
                                </svg>
                            </span>
                            *}
                            <div>
                                {if !empty($oUpload->cName)}
                                    <div class="upload_title block">{$oUpload->cName}</div>
                                {/if}
                                <div id="queue{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}" style="margin-bottom: 15px;" class="uploadifyMsg">
                                    <span class="current-upload small text-success">
                                        {if $oUpload->bVorhanden}
                                            {$oUpload->cDateiname} ({$oUpload->cDateigroesse})
                                        {/if}
                                    </span>
                                </div>
                                {if !empty($oUpload->cBeschreibung)}
                                    <div class="upload_desc small block text-muted">{$oUpload->cBeschreibung}</div>
                                {else}
                                    <div class="upload_desc small block text-muted">{lang key="missingFilesUpload" section="checkout"}</div>
                                {/if}
                            </div>
                        </div>
                        <div class="col-xs-3 kmps-s">
                            <div class="text-right dpflex-j-end
                                {if isset($smarty.get.fillOut) && $smarty.get.fillOut == 12 && ($oUpload->nPflicht
                                    && !$oUpload->bVorhanden)} upload-error{/if}"
                                 id="upload-{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}">
                                <input id="fileinput{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}"
                                    type="file" multiple class="file-upload file-loading" />
                                <div id="kv-error-{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}"
                                    style="margin-top:10px; display:none;"></div>
                                <label for="fileinput{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}" class="dpflex-a-center btn btn-default small">
                                    <span class="img-ct icon icon-wt">
                                        <svg class="">
                                          <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-addfile"></use>
                                        </svg>
                                    </span>
                                    {lang key="uploadBrowser"}
                                </label>
                            </div>
                            <script type="text/javascript">
                                $(function () {ldelim}
                                    $('#fileinput{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}').fileinput({
                                        uploadUrl:             '{$ShopURL}/{$PFAD_UPLOAD_CALLBACK}',
                                        uploadAsync:           true,
                                        showPreview:           false,
                                        showRemove:            false,
                                        allowedFileExtensions: [{$oUpload->cDateiListe|replace:'*.':'\''|replace:';':'\','|cat:'\''}],
                                        language:              '{$uploaderLang}',
                                        uploadExtraData:       {
                                            sid:        "{$cSessionID}",
                                            jtl_token:  "{$smarty.session.jtl_token}",
                                            uniquename: "{$oUpload->cUnique}",
                                            uploader:   "4.00",
                                            cname:      "{$oUploadSchema->cName|replace:" ":"_"}"
                                            {if !empty($oUploadSchema->WarenkorbPosEigenschaftArr)},
                                            variation:  "{strip}
                                            {foreach name=variationen from=$oUploadSchema->WarenkorbPosEigenschaftArr item=Variation}_{$Variation->cEigenschaftWertName|trans|replace:" ":"_"}{/foreach}
                                                "{/strip}
                                            {/if}
                                        },
                                        maxFileSize:           {$nMaxUploadSize/1024},
                                        elErrorContainer:      '#kv-error-{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}',
                                        maxFilesNum:           1
                                    }).on('fileuploaded', function(event, data) {
                                        var ip = $('#fileinput{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}'),
                                            msgField = $('#queue{$smarty.foreach.schema.index}{$smarty.foreach.upload.index} .current-upload'),
                                            uploadMsgField = $('.uploadifyMsg');
                                        if (typeof data.response !== 'undefined' && typeof data.response.cName !== 'undefined') {
                                            msgField.html('<i></i>' + data.response.cName + ' (' + data.response.cKB + ' KB)');
                                        } else {
                                            msgField.html('{lang key="uploadError"}');
                                        }
                                        $('#msgWarning').hide();
                                        uploadMsgField.find('.alert-danger').hide();
                                        $('#cart-form').find('.upload-error').removeClass('upload-error');
                                        ip.fileinput('reset');
                                        ip.fileinput('refresh');
                                        ip.fileinput('clear');
                                        ip.fileinput('enable');
                                    }).on('fileuploaderror', function() {
                                        $('#upload-{$smarty.foreach.schema.index}{$smarty.foreach.upload.index} .fileinput-upload').addClass('disabled');
                                    }).on('fileloaded', function() {
                                        $('#upload-{$smarty.foreach.schema.index}{$smarty.foreach.upload.index} .fileinput-upload').removeClass('disabled');
                                    });
                                    {rdelim});
                            </script>
                        </div>
                    </div>
                    </div>
                {/foreach}
            </div>
        </div>
    {/foreach}
{/if}
