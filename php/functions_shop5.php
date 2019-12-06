<?php
/**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *
 * @global \JTL\Smarty\JTLSmarty $smarty
 */

use Illuminate\Support\Collection;
use JTL\Catalog\Category\Kategorie;
use JTL\Catalog\Category\KategorieListe;
use JTL\Catalog\Product\Artikel;
use JTL\Catalog\Product\Preise;
use JTL\CheckBox;
use JTL\Filter\Config;
use JTL\Filter\ProductFilter;
use JTL\Helpers\Category;
use JTL\Helpers\Manufacturer;
use JTL\Helpers\Seo;
use JTL\Helpers\Tax;
use JTL\Media\Image;
use JTL\Media\Image\Product;
use JTL\Session\Frontend;
use JTL\Shop;
use JTL\Staat;
use scc\DefaultComponentRegistrator;
use sccbs3\Bs3sccRenderer;

$scc = new DefaultComponentRegistrator(new Bs3sccRenderer($smarty));
$scc->registerComponents();

$smarty->registerPlugin(Smarty::PLUGIN_FUNCTION, 'gibPreisStringLocalizedSmarty', 'gibPreisStringLocalizedSmarty')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getBoxesByPosition', 'getBoxesByPosition')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'has_boxes', 'has_boxes')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'imageTag', 'get_img_tag')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getCheckBoxForLocation', 'getCheckBoxForLocation')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'hasCheckBoxForLocation', 'hasCheckBoxForLocation')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'aaURLEncode', 'aaURLEncode')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_navigation', 'get_navigation')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'ts_data', 'get_trustedshops_data')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_category_array', 'get_category_array')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_category_parents', 'get_category_parents')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'prepare_image_details', 'prepare_image_details')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_manufacturers', 'get_manufacturers')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_cms_content', 'get_cms_content')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_static_route', 'get_static_route')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'hasOnlyListableVariations', 'hasOnlyListableVariations')
    ->registerPlugin(Smarty::PLUGIN_MODIFIER, 'has_trans', 'has_translation')
    ->registerPlugin(Smarty::PLUGIN_MODIFIER, 'trans', 'get_translation')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_product_list', 'get_product_list')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'captchaMarkup', 'captchaMarkup')
    ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getStates', 'getStates')
    ->registerPlugin(Smarty::PLUGIN_MODIFIER, 'seofy', 'seofy');

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return array|void
 */
function get_product_list($params, $smarty)
{
    $limit            = (int)($params['nLimit'] ?? 10);
    $sort             = (int)($params['nSortierung'] ?? 0);
    $cAssign          = (isset($params['cAssign']) && mb_strlen($params['cAssign']) > 0)
        ? $params['cAssign']
        : 'oCustomArtikel_arr';
    $characteristicFilters = isset($params['cMerkmalFilter'])
        ? ProductFilter::initCharacteristicFilter(explode(';', $params['cMerkmalFilter']))
        : [];
    $searchFilters    = isset($params['cSuchFilter'])
        ? ProductFilter::initSearchFilter(explode(';', $params['cSuchFilter']))
        : [];
    $params           = [
        'kKategorie'             => $params['kKategorie'] ?? null,
        'kHersteller'            => $params['kHersteller'] ?? null,
        'kArtikel'               => $params['kArtikel'] ?? null,
        'kVariKindArtikel'       => $params['kVariKindArtikel'] ?? null,
        'kSeite'                 => $params['kSeite'] ?? null,
        'kSuchanfrage'           => $params['kSuchanfrage'] ?? null,
        'kMerkmalWert'           => $params['kMerkmalWert'] ?? null,
        'kTag'                   => $params['kTag'] ?? null,
        'kSuchspecial'           => $params['kSuchspecial'] ?? null,
        'kKategorieFilter'       => $params['kKategorieFilter'] ?? null,
        'kHerstellerFilter'      => $params['kHerstellerFilter'] ?? null,
        'nBewertungSterneFilter' => $params['nBewertungSterneFilter'] ?? null,
        'cPreisspannenFilter'    => $params['cPreisspannenFilter'] ?? '',
        'kSuchspecialFilter'     => $params['kSuchspecialFilter'] ?? null,
        'nSortierung'            => $sort,
        'MerkmalFilter_arr'      => $characteristicFilters,
        'SuchFilter_arr'         => $searchFilters,
        'nArtikelProSeite'       => $params['nArtikelProSeite'] ?? null,
        'cSuche'                 => $params['cSuche'] ?? null,
        'seite'                  => $params['seite'] ?? null
    ];
    if ($params['kArtikel'] !== null) {
        $products = [];
        if (!is_array($params['kArtikel'])) {
            $params['kArtikel'] = [$params['kArtikel']];
        }
        foreach ($params['kArtikel'] as $productID) {
            $product    = new Artikel();
            $products[] = $product->fuelleArtikel($productID, Artikel::getDefaultOptions());
        }
    } else {
        $products = (new ProductFilter(
            Config::getDefault(),
            Shop::Container()->getDB(),
            Shop::Container()->getCache()
        ))
            ->initStates($params)
            ->generateSearchResults(null, true, $limit)
            ->getProducts()
            ->all();
    }

    $smarty->assign($cAssign, $products);

    if (isset($params['bReturn'])) {
        return $products;
    }
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return bool|string
 */
function get_static_route($params, $smarty)
{
    if (isset($params['id'])) {
        $full   = !isset($params['full']) || $params['full'] === true;
        $secure = isset($params['secure']) && $params['secure'] === true;
        $url    = Shop::Container()->getLinkService()->getStaticRoute($params['id'], $full, $secure);
        $qp     = isset($params['params'])
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
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return array
 */
function get_manufacturers($params, $smarty)
{
    $manufacturers = Manufacturer::getInstance()->getManufacturers();
    if (isset($params['assign'])) {
        $smarty->assign($params['assign'], $manufacturers);

        return;
    }

    return $manufacturers;
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return array|void
 */
function getBoxesByPosition($params, $smarty)
{
    if (isset($params['position'])) {
        $data  = Shop::Container()->getBoxService()->boxes;
        $boxes = $data[$params['position']] ?? [];
        if (isset($params['assign'])) {
            $smarty->assign($params['assign'], $boxes);
        } else {
            return $boxes;
        }
    }
}

/**
 * @param array                        $params - categoryId mainCategoryId. 0 for first level categories
 * @param Smarty_Internal_TemplateBase $smarty
 * @return array|void
 */
function get_category_array($params, $smarty)
{
    $id = isset($params['categoryId']) ? (int)$params['categoryId'] : 0;
    if ($id === 0) {
        $categories = Category::getInstance();
        $list       = $categories->combinedGetAll();
    } else {
        $categories = new KategorieListe();
        $list       = $categories->getAllCategoriesOnLevel($id);
    }

    if (isset($params['categoryBoxNumber']) && (int)$params['categoryBoxNumber'] > 0) {
        $list2 = [];
        foreach ($list as $key => $item) {
            if (isset($item->categoryFunctionAttributes[KAT_ATTRIBUT_KATEGORIEBOX])
                && $item->categoryFunctionAttributes[KAT_ATTRIBUT_KATEGORIEBOX] == $params['categoryBoxNumber']
            ) {
                $list2[$key] = $item;
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
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return array|void
 */
function get_category_parents($params, $smarty)
{
    $id         = isset($params['categoryId']) ? (int)$params['categoryId'] : 0;
    $categories = new KategorieListe();
    $list       = $categories->getOpenCategories(new Kategorie($id));

    array_shift($list);
    $list = array_reverse($list);

    if (isset($params['assign'])) {
        $smarty->assign($params['assign'], $list);

        return;
    }

    return $list;
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return string
 */
function get_img_tag($params, $smarty)
{
    if (empty($params['src'])) {
        return '';
    }
    $oImgSize = get_image_size($params['src']);

    $imageURL   = $params['src'];
    $imageID    = isset($params['id']) ? ' id="' . $params['id'] . '"' : '';
    $imageALT   = isset($params['alt']) ? ' alt="' . truncate($params['alt'], 75) . '"' : '';
    $imageTITLE = isset($params['title']) ? ' title="' . truncate($params['title'], 75) . '"' : '';
    $imageCLASS = isset($params['class']) ? ' class="' . truncate($params['class'], 75) . '"' : '';
    if (mb_strpos($imageURL, 'http') !== 0) {
        $imageURL = Shop::getImageBaseURL() . ltrim($imageURL, '/');
    }
    if ($oImgSize !== null && $oImgSize->size->width > 0 && $oImgSize->size->height > 0) {
        return '<img src="' . $imageURL . '" width="' . $oImgSize->size->width . '" height="' .
            $oImgSize->size->height . '"' . $imageID . $imageALT . $imageTITLE . $imageCLASS . ' />';
    }

    return '<img src="' . $imageURL . '"' . $imageID . $imageALT . $imageTITLE . $imageCLASS . ' />';
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 */
function has_boxes($params, $smarty)
{
    $boxData = $smarty->getTemplateVars('boxes');
    $smarty->assign($params['assign'], !empty($boxData[$params['position']]));
}

/**
 * @param string $text
 * @param int    $numb
 * @return string
 */
function truncate($text, $numb)
{
    if (mb_strlen($text) > $numb) {
        $text = mb_substr($text, 0, $numb);
        $text = mb_substr($text, 0, mb_strrpos($text, ' '));
        $text .= '...';
    }

    return $text;
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return mixed|string
 */
function gibPreisStringLocalizedSmarty($params, $smarty)
{
    $surcharge                     = new stdClass();
    $surcharge->cAufpreisLocalized = '';
    $surcharge->cPreisInklAufpreis = '';

    if ((float)$params['fAufpreisNetto'] != 0) {
        $fAufpreisNetto         = (float)$params['fAufpreisNetto'];
        $fVKNetto               = (float)$params['fVKNetto'];
        $kSteuerklasse          = (int)$params['kSteuerklasse'];
        $fVPEWert               = (float)$params['fVPEWert'];
        $cVPEEinheit            = $params['cVPEEinheit'];
        $funcAttributes = $params['FunktionsAttribute'];
        $precision           = (isset($funcAttributes[FKT_ATTRIBUT_GRUNDPREISGENAUIGKEIT])
            && (int)$funcAttributes[FKT_ATTRIBUT_GRUNDPREISGENAUIGKEIT] > 0)
            ? (int)$funcAttributes[FKT_ATTRIBUT_GRUNDPREISGENAUIGKEIT]
            : 2;

        if ((int)$params['nNettoPreise'] === 1) {
            $surcharge->cAufpreisLocalized = Preise::getLocalizedPriceString($fAufpreisNetto);
            $surcharge->cPreisInklAufpreis = Preise::getLocalizedPriceString($fAufpreisNetto + $fVKNetto);
            $surcharge->cAufpreisLocalized = ($fAufpreisNetto > 0)
                ? ('+ ' . $surcharge->cAufpreisLocalized)
                : str_replace('-', '- ', $surcharge->cAufpreisLocalized);

            if ($fVPEWert > 0) {
                $surcharge->cPreisVPEWertAufpreis     = Preise::getLocalizedPriceString(
                        $fAufpreisNetto / $fVPEWert,
                        Frontend::getCurrency()->getCode(),
                        true,
                        $precision
                    ) . ' ' . Shop::Lang()->get('vpePer') . ' ' . $cVPEEinheit;
                $surcharge->cPreisVPEWertInklAufpreis = Preise::getLocalizedPriceString(
                        ($fAufpreisNetto + $fVKNetto) / $fVPEWert,
                        Frontend::getCurrency()->getCode(),
                        true,
                        $precision
                    ) . ' ' . Shop::Lang()->get('vpePer') . ' ' . $cVPEEinheit;

                $surcharge->cAufpreisLocalized = $surcharge->cAufpreisLocalized . ', ' .
                    $surcharge->cPreisVPEWertAufpreis;
                $surcharge->cPreisInklAufpreis = $surcharge->cPreisInklAufpreis . ', ' .
                    $surcharge->cPreisVPEWertInklAufpreis;
            }
        } else {
            $surcharge->cAufpreisLocalized = Preise::getLocalizedPriceString(
                Tax::getGross($fAufpreisNetto, $_SESSION['Steuersatz'][$kSteuerklasse], 4)
            );
            $surcharge->cPreisInklAufpreis = Preise::getLocalizedPriceString(
                Tax::getGross($fAufpreisNetto + $fVKNetto, $_SESSION['Steuersatz'][$kSteuerklasse], 4)
            );
            $surcharge->cAufpreisLocalized = ($fAufpreisNetto > 0)
                ? ('+ ' . $surcharge->cAufpreisLocalized)
                : str_replace('-', '- ', $surcharge->cAufpreisLocalized);

            if ($fVPEWert > 0) {
                $surcharge->cPreisVPEWertAufpreis     = Preise::getLocalizedPriceString(
                        Tax::getGross($fAufpreisNetto / $fVPEWert, $_SESSION['Steuersatz'][$kSteuerklasse]),
                        Frontend::getCurrency()->getCode(),
                        true,
                        $precision
                    ) . ' ' . Shop::Lang()->get('vpePer') . ' ' . $cVPEEinheit;
                $surcharge->cPreisVPEWertInklAufpreis = Preise::getLocalizedPriceString(
                        Tax::getGross(
                            ($fAufpreisNetto + $fVKNetto) / $fVPEWert,
                            $_SESSION['Steuersatz'][$kSteuerklasse]
                        ),
                        Frontend::getCurrency()->getCode(),
                        true,
                        $precision
                    ) . ' ' . Shop::Lang()->get('vpePer') . ' ' . $cVPEEinheit;

                $surcharge->cAufpreisLocalized = $surcharge->cAufpreisLocalized .
                    ', ' . $surcharge->cPreisVPEWertAufpreis;
                $surcharge->cPreisInklAufpreis = $surcharge->cPreisInklAufpreis .
                    ', ' . $surcharge->cPreisVPEWertInklAufpreis;
            }
        }
    }

    return (isset($params['bAufpreise']) && (int)$params['bAufpreise'] > 0)
        ? $surcharge->cAufpreisLocalized
        : $surcharge->cPreisInklAufpreis;
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 */
function hasCheckBoxForLocation($params, $smarty)
{
    $smarty->assign(
        $params['bReturn'],
        count((new CheckBox())->getCheckBoxFrontend((int)$params['nAnzeigeOrt'], 0, true, true)) > 0
    );
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return string
 */
function getCheckBoxForLocation($params, $smarty)
{
    $langID     = Shop::getLanguageID();
    $cid        = 'cb_' . (int)$params['nAnzeigeOrt'] . '_' . $langID;
    $checkBoxes = Shop::has($cid)
        ? Shop::get($cid)
        : (new CheckBox())->getCheckBoxFrontend((int)$params['nAnzeigeOrt'], 0, true, true);
    if (count($checkBoxes) > 0) {
        foreach ($checkBoxes as $checkBox) {
            $linkURL                 = $checkBox->kLink > 0
                ? $checkBox->getLink()->getURL()
                : '';
            $error                   = isset($params['cPlausi_arr'][$checkBox->cID]);
            $post                    = $params['cPost_arr'];
            $checkBox->isActive      = isset($post[$checkBox->cID]);
            $checkBox->cName         = $checkBox->oCheckBoxSprache_arr[$langID]->cText;
            $checkBox->cLinkURL      = $linkURL;
            $checkBox->cLinkURLFull  = $linkURL;
            $checkBox->cBeschreibung = !empty($checkBox->oCheckBoxSprache_arr[$langID]->cBeschreibung)
                ? $checkBox->oCheckBoxSprache_arr[$langID]->cBeschreibung
                : '';
            $checkBox->cErrormsg     = $error
                ? Shop::Lang()->get('pleasyAccept', 'account data')
                : '';
        }
        Shop::set($cid, $checkBoxes);
        if (isset($params['assign'])) {
            $smarty->assign($params['assign'], $checkBoxes);
        }
    }
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return string
 */
function aaURLEncode($params, $smarty)
{
    $reset     = (isset($params['nReset']) && (int)$params['nReset'] === 1);
    $url       = $_SERVER['REQUEST_URI'];
    $params    = ['&aaParams', '?aaParams', '&aaReset', '?aaReset'];
    $containes = false;
    foreach ($params as $param) {
        $containes = mb_strpos($url, $param);
        if ($containes !== false) {
            $url = mb_substr($url, 0, $containes);
            break;
        }
        $containes = false;
    }
    if ($containes !== false) {
        $url = mb_substr($url, 0, $containes);
    }
    if (isset($params['bUrlOnly']) && (int)$params['bUrlOnly'] === 1) {
        return $url;
    }
    $cParams = '';
    unset($params['nReset']);
    if (is_array($params) && count($params) > 0) {
        foreach ($params as $key => $param) {
            $cParams .= $key . '=' . $param . ';';
        }
    }

    $sep = (mb_strpos($url, '?') === false) ? '?' : '&';

    return $url . $sep . ($reset ? 'aaReset=' : 'aaParams=') . base64_encode($cParams);
}

/**
 * @param array                        $params - ['type'] Templatename of link, ['assign'] array name to assign
 * @param Smarty_Internal_TemplateBase $smarty
 */
function get_navigation($params, $smarty)
{
    $linkgroupIdentifier = $params['linkgroupIdentifier'];
    $linkGroup           = null;
    if (mb_strlen($linkgroupIdentifier) > 0) {
        $linkGroups = Shop::Container()->getLinkService()->getVisibleLinkGroups();
        $linkGroup  = $linkGroups->getLinkgroupByTemplate($linkgroupIdentifier);
    }
    if (is_object($linkGroup)
        && isset($params['assign'])
        && $linkGroup->isAvailableInLanguage(Shop::getLanguageID())
    ) {
        $smarty->assign($params['assign'], build_navigation_subs($linkGroup));
    }
}

/**
 * @param \JTL\Link\LinkGroupInterface $linkGroup
 * @param int                          $parentLinkID
 * @return Collection
 */
function build_navigation_subs($linkGroup, int $parentLinkID = 0)
{
    $news = new Collection();
    if ($linkGroup->getTemplate() === 'hidden' || $linkGroup->getName() === 'hidden') {
        return $news;
    }
    foreach ($linkGroup->getLinks() as $link) {
        /** @var \JTL\Link\Link $link */
        if ($link->getParent() !== $parentLinkID) {
            continue;
        }
        $link->setChildLinks(build_navigation_subs($linkGroup, $link->getID()));
        $link->setIsActive($link->getIsActive() || (Shop::$kLink > 0 && Shop::$kLink === $link->getID()));
        $news->push($link);
    }

    return $news;
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @deprecated since 5.0.0
 */
function get_trustedshops_data($params, $smarty)
{
    trigger_error(__FUNCTION__ . ' is deprecated.', E_USER_DEPRECATED);
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return string|object|null
 */
function prepare_image_details($params, $smarty)
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
    $imageBaseURL = Shop::getImageBaseURL();
    foreach ($result as $size => $data) {
        if (isset($data->src) && mb_strpos($data->src, 'http') !== 0) {
            $data->src = $imageBaseURL . $data->src;
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
    if (mb_strpos($image, 'http') === 0) {
        return null;
    }
    $path = mb_strpos($image, PFAD_BILDER) === 0
        ? PFAD_ROOT . $image
        : $image;
    if (!file_exists($path)) {
        $req = Product::toRequest($path);

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
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return mixed
 */
function get_cms_content($params, $smarty)
{
    if (isset($params['kLink']) && (int)$params['kLink'] > 0) {
        $kLink   = (int)$params['kLink'];
        $link    = Shop::Container()->getLinkService()->getLinkByID($kLink);
        $content = $link !== null ? $link->getContent() : null;
        if (isset($params['assign'])) {
            $smarty->assign($params['assign'], $content);
        } else {
            return $content;
        }
    }

    return null;
}

/**
 * @param array                        $params - variationen, maxVariationCount, maxWerteCount
 * @param Smarty_Internal_TemplateBase $smarty
 * @return int - 0: no listable variations, 1: normal listable variations, 2: only child listable variations
 */
function hasOnlyListableVariations($params, $smarty)
{
    if (!isset($params['artikel']->Variationen)) {
        if (isset($params['assign'])) {
            $smarty->assign($params['assign'], 0);

            return null;
        }

        return 0;
    }

    $maxVariationCount = (int)($params['maxVariationCount'] ?? 1);
    $maxWerteCount     = (int)($params['maxWerteCount'] ?? 3);
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
        $result = $variationCheck(
            $params['artikel']->oVariationenNurKind_arr,
            $maxVariationCount,
            $maxWerteCount
        ) ? 2 : 0;
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
 * @param string|null  $to - locale
 * @return null|string
 */
function get_translation($mixed, $to = null)
{
    $to = $to ?: Shop::getLanguageCode();

    if (has_translation($mixed, $to)) {
        return is_string($mixed) ? $mixed : $mixed[$to];
    }

    return null;
}

/**
 * Has any translation
 *
 * @param string|array $mixed
 * @param string|null  $to - locale
 * @return bool
 */
function has_translation($mixed, $to = null)
{
    $to = $to ?: Shop::getLanguageCode();

    return is_string($mixed) ?: isset($mixed[$to]);
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return string
 */
function captchaMarkup($params, $smarty)
{
    if (isset($params['getBody']) && $params['getBody']) {
        return Shop::Container()->getCaptchaService()->getBodyMarkup($smarty);
    }

    return Shop::Container()->getCaptchaService()->getHeadMarkup($smarty);
}

/**
 * @param array                        $params
 * @param Smarty_Internal_TemplateBase $smarty
 * @return object|null
 */
function getStates($params, $smarty)
{
    $oStates = Staat::getRegions($params['cIso']);
    if (isset($params['assign'])) {
        $smarty->assign($params['assign'], $oStates);

        return;
    }

    return $oStates;
}

/**
 * prepares a string optimized for SEO
 * @param String $optStr
 * @return String SEO optimized String
 */
function seofy($optStr = '')
{
    return Seo::sanitizeSeoSlug($optStr);
}
