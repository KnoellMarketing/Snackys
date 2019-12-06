{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}
<div id="download-preview">
    <div class="download-title">
        <h1>{$oDownload->oDownloadSprache->getName()}</h1>
    </div>
    <div class="download-body">
        <p>{$oDownload->oDownloadSprache->getBeschreibung()}</p>
        {assign var="height" value=71}
        {if $oDownload->getPreviewType() === 'video'}
            {assign var="height" value=300}
        {/if}
        <object id="mediaplayer" width="100%" height="{$height}" classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701" standby="Lade Player-Plugins..." type="application/x-oleobject">
            <param name="URL" value="{$oDownload->getPreview()}" />
            <param name="Autostart" value="true" />
            <param name="ControlType" value="2" />
            <param name="AnimationatStart" value="false" />
            <param name="TransparentAtStart" value="true" />
            <param name="ShowControls" value="true" />
            <param name="ShowDisplay" value="false" />
            <param name="ShowCaptioning" value="false" />
            <param name="ShowStatusbar" value="false" />
            <param name="ShowTrackbar" value="false" />
            <param name="autosize" value="false" />
            <embed name="mediaplayer" width="100%" height="{$height}" type="application/x-mplayer2" src="{$oDownload->getPreview()}" autostart="true" showstatusbar="1"></embed>
        </object>
    </div>
    <div id="popup_close">
        <button type="button" class="submit" onclick="window.close()">Fenster schlie�en</button>
    </div>
</div>