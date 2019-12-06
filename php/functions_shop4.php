<?php
/**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *
 * @global JTLSmarty $smarty
 */
$smarty->registerPlugin('function', 'gibPreisStringLocalizedSmarty', 'gibPreisStringLocalizedSmarty')
       ->registerPlugin('function', 'load_boxes', 'load_boxes')
       ->registerPlugin('function', 'load_boxes_raw', 'load_boxes_raw')
       ->registerPlugin('function', 'has_boxes', 'has_boxes')
       ->registerPlugin('function', 'image', 'get_img_tag')
       ->registerPlugin('function', 'getCheckBoxForLocation', 'getCheckBoxForLocation')
       ->registerPlugin('function', 'hasCheckBoxForLocation', 'hasCheckBoxForLocation')
       ->registerPlugin('function', 'aaURLEncode', 'aaURLEncode')
       ->registerPlugin('function', 'get_navigation', 'get_navigation')
       ->registerPlugin('function', 'ts_data', 'get_trustedshops_data')
       ->registerPlugin('function', 'get_category_array', 'get_category_array')
       ->registerPlugin('function', 'get_category_parents', 'get_category_parents')
       ->registerPlugin('function', 'prepare_image_details', 'prepare_image_details')
       ->registerPlugin('function', 'get_manufacturers', 'get_manufacturers')
       ->registerPlugin('function', 'get_cms_content', 'get_cms_content')
       ->registerPlugin('function', 'get_static_route', 'get_static_route')
       ->registerPlugin('function', 'hasOnlyListableVariations', 'hasOnlyListableVariations')
       ->registerPlugin('modifier', 'has_trans', 'has_translation')
       ->registerPlugin('modifier', 'trans', 'get_translation')
       ->registerPlugin('function', 'get_product_list', 'get_product_list')
	   ->registerPlugin('modifier', 'seofy', 'seofy');


/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return array
 */
function get_product_list($params, &$smarty)
{
    $nLimit             = isset($params['nLimit'])
        ? (int)$params['nLimit']
        : 10;
    $nSortierung        = isset($params['nSortierung'])
        ? (int)$params['nSortierung']
        : 0;
    $cAssign            = (isset($params['cAssign']) && strlen($params['cAssign']) > 0)
        ? $params['cAssign']
        : 'oCustomArtikel_arr';
    $cMerkmalFilter_arr = isset($params['cMerkmalFilter'])
        ? setzeMerkmalFilter(explode(';', $params['cMerkmalFilter']))
        : null;
    $cSuchFilter_arr    = isset($params['cSuchFilter'])
        ? setzeSuchFilter(explode(';', $params['cSuchFilter']))
        : null;
    $cTagFilter_arr     = isset($params['cTagFilter'])
        ? setzeTagFilter(explode(';', $params['cTagFilter']))
        : null;
    $cParameter_arr     = [
        'kKategorie'             => isset($params['kKategorie']) ? $params['kKategorie'] : null,
        'kHersteller'            => isset($params['kHersteller']) ? $params['kHersteller'] : null,
        'kArtikel'               => isset($params['kArtikel']) ? $params['kArtikel'] : null,
        'kVariKindArtikel'       => isset($params['kVariKindArtikel']) ? $params['kVariKindArtikel'] : null,
        'kSeite'                 => isset($params['kSeite']) ? $params['kSeite'] : null,
        'kSuchanfrage'           => isset($params['kSuchanfrage']) ? $params['kSuchanfrage'] : null,
        'kMerkmalWert'           => isset($params['kMerkmalWert']) ? $params['kMerkmalWert'] : null,
        'kTag'                   => isset($params['kTag']) ? $params['kTag'] : null,
        'kSuchspecial'           => isset($params['kSuchspecial']) ? $params['kSuchspecial'] : null,
        'kKategorieFilter'       => isset($params['kKategorieFilter']) ? $params['kKategorieFilter'] : null,
        'kHerstellerFilter'      => isset($params['kHerstellerFilter']) ? $params['kHerstellerFilter'] : null,
        'nBewertungSterneFilter' => isset($params['nBewertungSterneFilter']) ? $params['nBewertungSterneFilter'] : null,
        'cPreisspannenFilter'    => isset($params['cPreisspannenFilter']) ? $params['cPreisspannenFilter'] : null,
        'kSuchspecialFilter'     => isset($params['kSuchspecialFilter']) ? $params['kSuchspecialFilter'] : null,
        'nSortierung'            => $nSortierung,
        'MerkmalFilter_arr'      => $cMerkmalFilter_arr,
        'TagFilter_arr'          => $cTagFilter_arr,
        'SuchFilter_arr'         => $cSuchFilter_arr,
        'nArtikelProSeite'       => isset($params['nArtikelProSeite']) ? $params['nArtikelProSeite'] : null,
        'cSuche'                 => isset($params['cSuche']) ? $params['cSuche'] : null,
        'seite'                  => isset($params['seite']) ? $params['seite'] : null
    ];
    if ($cParameter_arr['kArtikel'] !== null) {
        $oArtikel_arr = [];
        if (!is_array($cParameter_arr['kArtikel'])) {
            $cParameter_arr['kArtikel'] = [$cParameter_arr['kArtikel']];
        }
        foreach ($cParameter_arr['kArtikel'] as $kArtikel) {
            $article = new Artikel();
            $article->fuelleArtikel($kArtikel, Artikel::getDefaultOptions());
            $oArtikel_arr[] = $article;
        }
    } else {
        // Filter
        $NaviFilter = Shop::buildNaviFilter($cParameter_arr);
        if (isset($NaviFilter->Suche->cSuche) && strlen($NaviFilter->Suche->cSuche) > 0) {
            $NaviFilter->Suche->cSuche     = StringHandler::filterXSS($NaviFilter->Suche->cSuche, 1);
            $NaviFilter->Suche->kSuchCache = bearbeiteSuchCache($NaviFilter);
        }
        // Artikelattribut
        if (isset($cParameter_arr['cArtAttrib']) && strlen($cParameter_arr['cArtAttrib']) > 0) {
            $NaviFilter->ArtikelAttributFilter->cArtAttrib = $cParameter_arr['cArtAttrib'];
        }
        //Filter SQLs Objekte
        $FilterSQL = bauFilterSQL($NaviFilter);
        // Artikelliste
        $oArtikel_arr = gibArtikelKeys($FilterSQL, $nLimit, $NaviFilter, true, null);
    }

    $smarty->assign($cAssign, $oArtikel_arr);

    if (isset($params['bReturn'])) {
        return $oArtikel_arr;
    }
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return bool|string
 */
function get_static_route($params, &$smarty)
{
    if (isset($params['id'])) {
        $full   = !isset($params['full']) || $params['full'] === true;
        $secure = isset($params['secure']) && $params['secure'] === true;

        $url = LinkHelper::getInstance()->getStaticRoute($params['id'], $full, $secure);

        $qp = isset($params['params'])
            ? (array)$params['params']
            : [];

        if (count($qp) > 0) {
            $url = $url . (parse_url($url, PHP_URL_QUERY) ? '&' : '?') . http_build_query($qp, '', '&');
        }
        if (isset($params['assign'])) {
            $smarty->assign($params['assign'], $url);
        } else {
            return $url;
        }
    }

    return false;
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return array
 */
function get_manufacturers($params, &$smarty)
{
    $helper        = HerstellerHelper::getInstance();
    $manufacturers = $helper->getManufacturers();
    if (isset($params['assign'])) {
        $smarty->assign($params['assign'], $manufacturers);
        return;
    }

    return $manufacturers;
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return string
 */
function load_boxes_raw($params, &$smarty)
{
    if (isset($params['array'], $params['assign']) && $params['array'] === true) {
        $rawData = Boxen::getInstance()->getRawData();
        $smarty->assign($params['assign'], (isset($rawData[$params['type']]) ? $rawData[$params['type']] : null));
    }
}

/**
 * @param array     $params - categoryId mainCategoryId. 0 for first level categories
 * @param JTLSmarty $smarty
 * @return array|void
 */
function get_category_array($params, &$smarty)
{
    $id = isset($params['categoryId']) ? (int)$params['categoryId'] : 0;
    if ($id === 0) {
        $categories = KategorieHelper::getInstance();
        $list       = $categories->combinedGetAll();
    } else {
        $categories = new KategorieListe();
        $list       = $categories->getAllCategoriesOnLevel($id);
    }

    if (isset($params['categoryBoxNumber']) && (int)$params['categoryBoxNumber'] > 0) {
        $list2 = [];
        foreach ($list as $key => $oList) {
            if (isset($oList->categoryFunctionAttributes[KAT_ATTRIBUT_KATEGORIEBOX]) &&
                $oList->categoryFunctionAttributes[KAT_ATTRIBUT_KATEGORIEBOX] == $params['categoryBoxNumber']
            ) {
                $list2[$key] = $oList;
            }
        }
        $list = $list2;
    }

    if (isset($params['assign'])) {
        $smarty->assign($params['assign'], $list);
        return;
    }

    return $list;
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return array|void
 */
function get_category_parents($params, &$smarty)
{
    $id         = isset($params['categoryId']) ? (int)$params['categoryId'] : 0;
    $category   = new Kategorie($id);
    $categories = new KategorieListe();
    $list       = $categories->getOpenCategories($category);

    array_shift($list);
    $list = array_reverse($list);

    if (isset($params['assign'])) {
        $smarty->assign($params['assign'], $list);
        return;
    }

    return $list;
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return string
 */
function get_img_tag($params, &$smarty)
{
    if (empty($params['src'])) {
        return '';
    }
    $oImgSize = get_image_size($params['src']);

    $imageURL      = $params['src'];
    $imageID       = isset($params['id']) ? ' id="' . $params['id'] . '"' : '';
    $imageALT      = isset($params['alt']) ? ' alt="' . truncate($params['alt'], 75) . '"' : '';
    $imageTITLE    = isset($params['title']) ? ' title="' . truncate($params['title'], 75) . '"' : '';
    $imageCLASS    = isset($params['class']) ? ' class="' . truncate($params['class'], 75) . '"' : '';
    if ($oImgSize !== null && $oImgSize->size->width > 0 && $oImgSize->size->height > 0) {
        return '<img src="' . $imageURL . '" width="' . $oImgSize->size->width . '" height="' .
            $oImgSize->size->height . '"' . $imageID . $imageALT . $imageTITLE . $imageCLASS . ' />';
    }

    return '<img src="' . $imageURL . '"' . $imageID . $imageALT . $imageTITLE . $imageCLASS . ' />';
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return string
 */
function load_boxes($params, &$smarty)
{
    $cTplData     = '';
    $cOldTplDir   = '';
    $boxes        = Boxen::getInstance();
    $oBoxen_arr   = $boxes->compatGet();
    $cTemplateDir = $smarty->getTemplateDir($smarty->context);
		$smarty->assign('boxesPosition',$params['type']);
		echo "ich mache boxen!";
    if (is_array($oBoxen_arr) && isset($params['type'])) {
        $cType   = $params['type'];
        $_sBoxes = $smarty->getTemplateVars('boxes');
        if (isset($_sBoxes[$cType], $oBoxen_arr[$cType]) && is_array($oBoxen_arr[$cType])) {
            foreach ($oBoxen_arr[$cType] as $oBox) {
                $oPluginVar = '';
                $cTemplate  = 'tpl_inc/boxes/' . $oBox->cTemplate;
                if ($oBox->eTyp === 'plugin') {
                    $oPlugin = new Plugin($oBox->kCustomID);
                    if ($oPlugin->kPlugin > 0 && $oPlugin->nStatus == 2) {
                        $cTemplate    = $oBox->cTemplate;
                        $cOldTplDir   = $cTemplateDir;
                        $cTemplateDir = $oPlugin->cFrontendPfad . PFAD_PLUGIN_BOXEN;
                        $oPluginVar   = 'oPlugin' . $oBox->kBox;
                        $smarty->assign($oPluginVar, $oPlugin);
                    }
                } elseif ($oBox->eTyp === 'link') {
                    foreach (LinkHelper::getInstance()->getLinkGroups() as $oLinkTpl) {
                        if ($oLinkTpl->kLinkgruppe == $oBox->kCustomID) {
                            $oBox->oLinkGruppeTemplate = $oLinkTpl;
                            $oBox->oLinkGruppe         = $oLinkTpl;
                        }
                    }
                }
                if (file_exists($cTemplateDir . '/' . $cTemplate)) {
                    $oBoxVar = 'oBox' . $oBox->kBox;
                    $smarty->assign($oBoxVar, $oBox);
                    // Custom Template
                    global $Einstellungen;
                    if ($Einstellungen['template']['general']['use_customtpl'] === 'Y') {
                        $cTemplatePath   = pathinfo($cTemplate);
                        $cCustomTemplate = $cTemplatePath['dirname'] . '/' . $cTemplatePath['filename'] . '_custom.tpl';
                        if (file_exists($cTemplateDir . '/' . $cCustomTemplate)) {
                            $cTemplate = $cCustomTemplate;
                        }
                    }
                    $cTemplatePath = $cTemplateDir . '/' . $cTemplate;
                    if ($oBox->eTyp === 'plugin') {
                        $cTplData .= "{include file='" . $cTemplatePath . "' oBox=\$$oBoxVar oPlugin=\$$oPluginVar}";
                    } else {
                        $cTplData .= "{include file='" . $cTemplatePath . "' oBox=\$$oBoxVar}";
                    }

                    if (strlen($cOldTplDir)) {
                        $cTemplateDir = $cOldTplDir;
                    }
                }
            }
        }
    }
    if (isset($params['assign'])) {
        $smarty->assign($params['assign'], $cTplData);
        return;
    }

    return $cTplData;
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 */
function has_boxes($params, &$smarty)
{
    $boxes = Boxen::getInstance();
    $smarty->assign($params['assign'], isset($boxes->boxes[$params['position']]));
}

/**
 * @param string $text
 * @param int    $numb
 * @return string
 */
function truncate($text, $numb)
{
    if (strlen($text) > $numb) {
        $text = substr($text, 0, $numb);
        $text = substr($text, 0, strrpos($text, ' '));
        $text .= '...';
    }

    return $text;
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return mixed|string
 */
function gibPreisStringLocalizedSmarty($params, &$smarty)
{
    $oAufpreis = new stdClass();
    if ((float)$params['fAufpreisNetto'] != 0) {
        $fAufpreisNetto         = (float)$params['fAufpreisNetto'];
        $fVKNetto               = (float)$params['fVKNetto'];
        $kSteuerklasse          = (int)$params['kSteuerklasse'];
        $fVPEWert               = (float)$params['fVPEWert'];
        $cVPEEinheit            = $params['cVPEEinheit'];
        $FunktionsAttribute_arr = $params['FunktionsAttribute'];
        $nGenauigkeit = (isset($FunktionsAttribute_arr[FKT_ATTRIBUT_GRUNDPREISGENAUIGKEIT]) &&
                (int)$FunktionsAttribute_arr[FKT_ATTRIBUT_GRUNDPREISGENAUIGKEIT] > 0)
            ? (int)$FunktionsAttribute_arr[FKT_ATTRIBUT_GRUNDPREISGENAUIGKEIT]
            : 2;

        if ((int)$params['nNettoPreise'] === 1) {
            $oAufpreis->cAufpreisLocalized = gibPreisStringLocalized($fAufpreisNetto);
            $oAufpreis->cPreisInklAufpreis = gibPreisStringLocalized($fAufpreisNetto + $fVKNetto);
            $oAufpreis->cAufpreisLocalized = ($fAufpreisNetto > 0)
                ? ('+ ' . $oAufpreis->cAufpreisLocalized)
                : str_replace('-', '- ', $oAufpreis->cAufpreisLocalized);

            if ($fVPEWert > 0) {
                $oAufpreis->cPreisVPEWertAufpreis = gibPreisStringLocalized(
                        $fAufpreisNetto / $fVPEWert,
                        $_SESSION['Waehrung'],
                        1,
                        $nGenauigkeit
                    ) . ' ' . Shop::Lang()->get('vpePer', 'global') . ' ' . $cVPEEinheit;
                $oAufpreis->cPreisVPEWertInklAufpreis = gibPreisStringLocalized(
                        ($fAufpreisNetto + $fVKNetto) / $fVPEWert,
                        $_SESSION['Waehrung'],
                        1,
                        $nGenauigkeit
                    ) . ' ' . Shop::Lang()->get('vpePer', 'global') . ' ' . $cVPEEinheit;

                $oAufpreis->cAufpreisLocalized = $oAufpreis->cAufpreisLocalized . ', ' . $oAufpreis->cPreisVPEWertAufpreis;
                $oAufpreis->cPreisInklAufpreis = $oAufpreis->cPreisInklAufpreis . ', ' . $oAufpreis->cPreisVPEWertInklAufpreis;
            }
        } else {
            $oAufpreis->cAufpreisLocalized = gibPreisStringLocalized(berechneBrutto($fAufpreisNetto, $_SESSION['Steuersatz'][$kSteuerklasse]));
            $oAufpreis->cPreisInklAufpreis = gibPreisStringLocalized(berechneBrutto($fAufpreisNetto + $fVKNetto, $_SESSION['Steuersatz'][$kSteuerklasse]));
            $oAufpreis->cAufpreisLocalized = ($fAufpreisNetto > 0)
                ? ('+ ' . $oAufpreis->cAufpreisLocalized)
                : str_replace('-', '- ', $oAufpreis->cAufpreisLocalized);

            if ($fVPEWert > 0) {
                $oAufpreis->cPreisVPEWertAufpreis = gibPreisStringLocalized(
                        berechneBrutto($fAufpreisNetto / $fVPEWert, $_SESSION['Steuersatz'][$kSteuerklasse]),
                        $_SESSION['Waehrung'],
                        1, $nGenauigkeit
                    ) . ' ' . Shop::Lang()->get('vpePer', 'global') . ' ' . $cVPEEinheit;
                $oAufpreis->cPreisVPEWertInklAufpreis = gibPreisStringLocalized(
                        berechneBrutto(
                            ($fAufpreisNetto + $fVKNetto) / $fVPEWert,
                            $_SESSION['Steuersatz'][$kSteuerklasse]
                        ),
                        $_SESSION['Waehrung'],
                        1,
                        $nGenauigkeit
                    ) . ' ' . Shop::Lang()->get('vpePer', 'global') . ' ' . $cVPEEinheit;

                $oAufpreis->cAufpreisLocalized = $oAufpreis->cAufpreisLocalized . ', ' . $oAufpreis->cPreisVPEWertAufpreis;
                $oAufpreis->cPreisInklAufpreis = $oAufpreis->cPreisInklAufpreis . ', ' . $oAufpreis->cPreisVPEWertInklAufpreis;
            }
        }
    }

    return (isset($params['bAufpreise']) && (int)$params['bAufpreise'] > 0)
        ? $oAufpreis->cAufpreisLocalized
        : $oAufpreis->cPreisInklAufpreis;
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 */
function hasCheckBoxForLocation($params, &$smarty)
{
    require_once PFAD_ROOT . PFAD_CLASSES . 'class.JTL-Shop.CheckBox.php';

    $oCheckBox     = new CheckBox();
    $oCheckBox_arr = $oCheckBox->getCheckBoxFrontend((int)$params['nAnzeigeOrt'], 0, true, true);

    $smarty->assign($params['bReturn'], count($oCheckBox_arr) > 0);
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return string
 */
function getCheckBoxForLocation($params, &$smarty)
{
    $cid = 'cb_' . (int)$params['nAnzeigeOrt'] . '_' . (int)$_SESSION['kSprache'];
    if (Shop::has($cid)) {
        $oCheckBox_arr = Shop::get($cid);
    } else {
        $oCheckBox     = new CheckBox();
        $oCheckBox_arr = $oCheckBox->getCheckBoxFrontend((int)$params['nAnzeigeOrt'], 0, true, true);
    }
    if (count($oCheckBox_arr) > 0) {
        $linkHelper = LinkHelper::getInstance();
        foreach ($oCheckBox_arr as $oCheckBox) {
            // Link URL bauen
            $cLinkURL     = '';
            $cLinkURLFull = '';
            if ($oCheckBox->kLink > 0) {
                $page = $linkHelper->findCMSLinkInSession($oCheckBox->oLink->kLink);
                if (!empty($page->URL)) {
                    $cLinkURL     = $page->URL;
                    $cLinkURLFull = $page->cURLFull;
                } else {
                    $cLinkURL = baueURL($oCheckBox->oLink, URLART_SEITE);
                }
            }
            // Fehlende Angaben
            $bError              = isset($params['cPlausi_arr'][$oCheckBox->cID]);
            $cPost_arr           = $params['cPost_arr'];
            $oCheckBox->isActive = false;
            if (isset($cPost_arr[$oCheckBox->cID])) {
                $oCheckBox->isActive = true;
            }

            $oCheckBox->cName = $oCheckBox->oCheckBoxSprache_arr[$_SESSION['kSprache']]->cText;

            if (strlen($cLinkURL) > 0) {
                $oCheckBox->cLinkURL = $cLinkURL;
            }
            $oCheckBox->cLinkURLFull = $cLinkURLFull;
            if (isset($oCheckBox->oCheckBoxSprache_arr[$_SESSION['kSprache']]->cBeschreibung) &&
                strlen($oCheckBox->oCheckBoxSprache_arr[$_SESSION['kSprache']]->cBeschreibung) > 0) {
                $oCheckBox->cBeschreibung = $oCheckBox->oCheckBoxSprache_arr[$_SESSION['kSprache']]->cBeschreibung;
            }
            if ($bError) {
                $oCheckBox->cErrormsg = Shop::Lang()->get('pleasyAccept', 'account data');
            }
        }
        Shop::set($cid, $oCheckBox_arr);
        if (isset($params['assign'])) {
            $smarty->assign($params['assign'], $oCheckBox_arr);
        }
    }
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return string
 */
function aaURLEncode($params, &$smarty)
{
    $bReset         = (isset($params['nReset']) && (int)$params['nReset'] === 1);
    $cURL           = $_SERVER['REQUEST_URI'];
    $cParameter_arr = ['&aaParams', '?aaParams', '&aaReset', '?aaReset'];
    $aaEnthalten    = false;
    foreach ($cParameter_arr as $cParameter) {
        $aaEnthalten = strpos($cURL, $cParameter);
        if ($aaEnthalten !== false) {
            $cURL = substr($cURL, 0, $aaEnthalten);
            break;
        }

        $aaEnthalten = false;
    }
    if ($aaEnthalten !== false) {
        $cURL = substr($cURL, 0, $aaEnthalten);
    }
    if (isset($params['bUrlOnly']) && (int)$params['bUrlOnly'] === 1) {
        return $cURL;
    }
    $cParams = '';
    unset($params['nReset']);
    if (is_array($params) && count($params) > 0) {
        foreach ($params as $key => $param) {
            $cParams .= $key . '=' . $param . ';';
        }
    }

    if (strpos($cURL, '?') !== false) {
        $cURL .= $bReset ? '&aaReset=' : '&aaParams=';
    } else {
        $cURL .= $bReset ? '?aaReset=' : '?aaParams=';
    }

    return $cURL . base64_encode($cParams);
}

/**
 * @param array $params - ['type'] Templatename of link, ['assign'] array name to assign
 * @param JTLSmarty $smarty
 */
function get_navigation($params, &$smarty)
{
    $linkgroupIdentifier = $params['linkgroupIdentifier'];
    $oLinkGruppe         = null;
    if (strlen($linkgroupIdentifier) > 0) {
        $linkGroups  = LinkHelper::getInstance()->getLinkGroups();
        $oLinkGruppe = isset($linkGroups->{$linkgroupIdentifier})
            ? $linkGroups->{$linkgroupIdentifier}
            : null;
    }

    if (is_object($oLinkGruppe) && isset($params['assign'])) {
        $smarty->assign($params['assign'], build_navigation_subs($oLinkGruppe));
    }
}

/**
 * @param object $oLink_arr
 * @param int   $kVaterLink
 * @return array
 */
function build_navigation_subs($oLink_arr, $kVaterLink = 0)
{
    $oNew_arr = [];
    if ($oLink_arr->cName !== 'hidden') {
        $cISO = $_SESSION['cISOSprache'];
        foreach ($oLink_arr->Links as &$oLink) {
            if ($oLink->kVaterLink == $kVaterLink) {
                $oLink->oSub_arr = build_navigation_subs($oLink_arr, $oLink->kLink);
                //append bIsActive property
                $oLink->bIsActive = false;
                if (isset($GLOBALS['kLink']) && $GLOBALS['kLink'] == $oLink->kLink) {
                    $oLink->bIsActive = true;
                }
                //append cTitle property
                $cTitle = '';
                if (isset($oLink->cLocalizedTitle[$cISO]) && $oLink->cLocalizedTitle[$cISO] != $oLink->cLocalizedName[$cISO]) {
                    $cTitle = StringHandler::htmlentities($oLink->cLocalizedTitle[$cISO], ENT_QUOTES);
                }
                $oLink->cTitle = $cTitle;
                $oNew_arr[]    = $oLink;
            }
        }
    }

    return $oNew_arr;
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 */
function get_trustedshops_data($params, &$smarty)
{
    require_once PFAD_ROOT . PFAD_CLASSES . 'class.JTL-Shop.TrustedShops.php';
    $oTrustedShops   = new TrustedShops(-1, StringHandler::convertISO2ISO639($_SESSION['cISOSprache']));
    $value['tsId']   = $oTrustedShops->tsId;
    $value['nAktiv'] = $oTrustedShops->nAktiv;

    $smarty->assign($params['assign'], $value);
}

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return string|object|null
 */
function prepare_image_details($params, &$smarty)
{
    if (!isset($params['item'])) {
        return null;
    }

    $result = [
        'xs' => get_image_size($params['item']->cPfadMini),
        'sm' => get_image_size($params['item']->cPfadKlein),
        'md' => get_image_size($params['item']->cPfadNormal),
        'lg' => get_image_size($params['item']->cPfadGross)
    ];

    if (isset($params['type'])) {
        $type = $params['type'];
        if (isset($result[$type])) {
            $result = $result[$type];
        }
    }

    $result = (object)$result;

    return (isset($params['json']) && $params['json'])
        ? json_encode($result, JSON_FORCE_OBJECT)
        : $result;
}

/**
 * @param string $image
 * @return object|null
 */
function get_image_size($image)
{
    $path = (strpos($image, PFAD_BILDER) === 0)
        ? PFAD_ROOT . $image
        : $image;
    if (!file_exists($path)) {
        $req = MediaImage::toRequest($path);

        if (!is_object($req)) {
            return null;
        }

        $settings = Image::getSettings();
        $refImage = $req->getRaw();
        if ($refImage === null) {
            return null;
        }

        list($width, $height, $type, $attr) = getimagesize($refImage);

        $size       = $settings['size'][$req->getSizeType()];
        $max_width  = $size['width'];
        $max_height = $size['height'];
        $old_width  = $width;
        $old_height = $height;

        $scale  = min($max_width / $old_width, $max_height / $old_height);
        $width  = ceil($scale * $old_width);
        $height = ceil($scale * $old_height);
    } else {
        list($width, $height, $type, $attr) = getimagesize($path);
    }

    return (object)[
        'src'  => $image,
        'size' => (object)[
            'width'  => $width,
            'height' => $height
        ],
        'type' => $type
    ];
}

/**
 * @param array $params
 * @param JTLSmarty $smarty
 * @return mixed
 */
function get_cms_content($params, &$smarty)
{
    if (isset($params['kLink']) && (int)$params['kLink'] > 0) {
        $kLink          = (int)$params['kLink'];
        $linkHelper     = LinkHelper::getInstance();
        $oLink          = $linkHelper->getPageLink($kLink);
        $oLink->Sprache = $linkHelper->getPageLinkLanguage($oLink->kLink);
        if (isset($params['assign'])) {
            $smarty->assign($params['assign'], $oLink->Sprache->cContent);
        } else {
            return $oLink->Sprache->cContent;
        }
    }

    return null;
}

/**
 * @param array $params - variationen, maxVariationCount, maxWerteCount
 * @param JTLSmarty $smarty
 * @return int - 0: no listable variations, 1: normal listable variations, 2: only child listable variations
 */
function hasOnlyListableVariations($params, &$smarty)
{
    if (!isset($params['artikel']->Variationen)) {
        if (isset($params['assign'])) {
            $smarty->assign($params['assign'], 0);

            return null;
        }

        return 0;
    }

    $maxVariationCount = isset($params['maxVariationCount']) ? (int)$params['maxVariationCount'] : 1;
    $maxWerteCount     = isset($params['maxWerteCount']) ? (int)$params['maxWerteCount'] : 3;
    $variationCheck    = function ($Variationen, $maxVariationCount, $maxWerteCount) {
        $result   = true;
        $varCount = is_array($Variationen) ? count($Variationen) : 0;

        if ($varCount > 0 && $varCount <= $maxVariationCount) {
            foreach ($Variationen as $oVariation) {
                if ($oVariation->cTyp !== 'SELECTBOX'
                    && (!in_array($oVariation->cTyp, ['TEXTSWATCHES', 'IMGSWATCHES', 'RADIO'], true)
                        || count($oVariation->Werte) > $maxWerteCount)) {
                    $result = false;
                    break;
                }
            }
        } else {
            $result = false;
        }

        return $result;
    };

    $result = $variationCheck($params['artikel']->Variationen, $maxVariationCount, $maxWerteCount) ? 1 : 0;
    if ($result === 0 && $params['artikel']->kVaterArtikel > 0) {
        // Hat das Kind evtl. mehr Variationen als der Vater?
        $result = $variationCheck($params['artikel']->oVariationenNurKind_arr, $maxVariationCount, $maxWerteCount) ? 2 : 0;
    }

    if (isset($params['assign'])) {
        $smarty->assign($params['assign'], $result);

        return null;
    }

    return $result;
}

/**
 * Input: ['ger' => 'Titel', 'eng' => 'Title']
 *
 * @param string|array $mixed
 * @param string|null $to - locale
 * @return null|string
 */
function get_translation($mixed, $to = null)
{
    $to = $to ?: Shop::getLanguage(true);

    if (has_translation($mixed, $to)) {
        return is_string($mixed) ? $mixed : $mixed[$to];
    }

    return null;
}

/**
 * Has any translation
 *
 * @param string|array $mixed
 * @param string|null $to - locale
 * @return bool
 */
function has_translation($mixed, $to = null)
{
    $to = $to ?: Shop::getLanguage(true);

    return is_string($mixed) ?: isset($mixed[$to]);
}

/**
 * prepares a string optimized for SEO
 * @param String $optStr
 * @return String SEO optimized String
 */
function seofy ($optStr = '')
{
    $optStr = StringHandler::convertUTF8($optStr);
    $optStr = preg_replace('/[^\\pL\d_]+/u', '-', $optStr);
    $optStr = trim($optStr, '-');
    if (function_exists('transliterator_transliterate')) {
        $optStr = transliterator_transliterate('Latin-ASCII;', $optStr);
    } else {
        $optStr = StringHandler::remove_accent($optStr);
    }
    $optStr = strtolower($optStr);
    $optStr = preg_replace('/[^-a-z0-9_]+/', '', $optStr);

    return $optStr;
}
