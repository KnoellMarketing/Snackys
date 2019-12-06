<div class="table-responsive">
    <table class="table table-striped table-bordered">
        <thead>
        <tr>
            <th></th>
            <th>{lang section="productDownloads" key="downloadName"}</th>
            <th>{lang section="productDownloads" key="downloadDescription" }</th>
            <th>{lang section="productDownloads" key="downloadFileType"}</th>
            <th>{lang section="productDownloads" key="downloadPreview"}</th>
        </tr>
        </thead>
        <tbody>
        {foreach name=downloads from=$Artikel->oDownload_arr item=oDownload}
            {if isset($oDownload->oDownloadSprache)}
                <tr>
                    <td>{$smarty.foreach.downloads.index+1}.</td>
                    <td>{$oDownload->oDownloadSprache->getName()}</td>
                    <td>{$oDownload->oDownloadSprache->getBeschreibung()}</td>
                    <td>{$oDownload->getExtension()}</td>
                    <td>
                        {if $oDownload->hasPreview()}
                            {if $oDownload->getPreviewType() === 'music'}
                                <audio controls preload="none">
                                    <source src="{PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}" >
                                    Your browser does not support the audio element.
                                </audio>
                            {elseif $oDownload->getPreviewType() === 'video'}
                                <video width="320" height="240" controls preload="none">
                                    <source src="{PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}" >
                                    Your browser does not support the video tag.
                                </video>
                            {elseif $oDownload->getPreviewType() === 'image'}
                                <img src="{PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}"
                                     class="img-responsive" alt="{$oDownload->oDownloadSprache->getBeschreibung()}">
                            {else}
                                <a href="{PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}"
                                   title="{$oDownload->oDownloadSprache->getName()}" target="_blank">
                                    {$oDownload->oDownloadSprache->getName()}
                                </a>
                            {/if}
                        {/if}
                    </td>
                </tr>
            {/if}
        {/foreach}
        </tbody>
    </table>
</div>
