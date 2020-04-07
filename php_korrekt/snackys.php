<?php
//Is Snackys installed? Relevant to use this Template!
$snackys = Shop::DB()->query('SELECT nStatus FROM tplugin WHERE cVerzeichnis=\'km_snackys\'',1);
if(!$snackys || !isset($snackys->nStatus) || $snackys->nStatus != 2)
	die('<html><head><title>Sorry</title><link
href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600,700" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
<style type="text/css">
body {font-family:\'Source Sans Pro\',\'Helvetica Neue\',\'Helvetica\',\'Arial\',sans-serif;}
#box {max-width: 900px; margin: 0 auto;margin-top: 80px;width:80%;}
h2 {background: linear-gradient( 90deg, rgb(255,94,77) 0%, rgb(255,131,77) 0%, rgb(255,154,86) 0%, rgb(248,85,88) 100%); color: #fff;margin:0;padding: 20px 50px;}
p {padding: 50px; background: #f0f0f0;margin:0;}
</style></head><body><div id="box"><h2>Sorry.</h2><p>Plugin::Snackys is missing.</p></div></body></html>');


function loadConfigsSnackysTemplate()
{
	$configs = Shop::DB()->query('SELECT * FROM xplugin_km_snackys_config',2);
	$return = array();
	foreach($configs as $conf)
		$return[$conf->nKey] = $conf->nValue;
		
	return $return;
}
$smarty->assign('snackyConfig',loadConfigsSnackysTemplate());



	//3 Funktionen die Pluginabhängig im Template sind:
	if(!isset($smarty->registered_plugins['function']['km_zone']))
	{
		$smarty->registerPlugin('function', 'km_zone', 'km_empty_zone');
	}

	//Auf Dropper prüfen, da das keine Funktion, sondern eine Smarty Zone ist
	try
	{
		$plugin = Plugin::getPluginById('kk_dropper');

		if(!empty($plugin) && $plugin->nStatus == 2) $smarty->assign('dropperFound',1);
	}catch(Exception  $e){}

	function km_empty_zone($params,&$smarty){}
	
	
	$smarty->registerPlugin('function', 'getSliderPerDevice', 'getSliderPerDevice');
	//Slider auf Mobile/Desktop beschraenken!
	function getSliderPerDevice($params, &$smarty)
	{
		$oSlider = $smarty->get_template_vars('oSlider');
		
		if(defined("APPLICATION_VERSION") && version_compare(APPLICATION_VERSION, 500) < 0)
		{
			$smarty->assign($params['cAssign'],$oSlider);
			return false;
		}
		
		if($oSlider)
		{
			$nSeitenTyp = $smarty->get_template_vars('nSeitenTyp');
			$device = $smarty->get_template_vars('device');
			$kKundengruppe = (isset($_SESSION['Kunde']->kKundengruppe) && $_SESSION['Kunde']->kKundengruppe > 0)
				? $_SESSION['Kunde']->kKundengruppe
				: $_SESSION['Kundengruppe']->kKundengruppe;
				
			$slider_arr = Shop::DB()->query(
				"SELECT kInitial FROM textensionpoint
					WHERE
					 (kSprache = '".Shop::getLanguage()."' OR kSprache = 0)
						AND
					 (kKundengruppe = '".$kKundengruppe."' OR kKundengruppe = 0)
						AND
					 (nSeite = '".$nSeitenTyp."' OR nSeite = 0)
						AND
					cClass='Slider'", 2
			);
			
			foreach($slider_arr as $slider)
			{
				$nSeitenTyp = $smarty->get_template_vars('nSeitenTyp');
				$check = Shop::DB()->query('SELECT kSlider FROM tslider WHERE bAktiv=1 AND cName NOT LIKE "%#'.(($device->isMobile()) ? 'desktop' : 'mobile').'%" AND kSlider='.(int)$slider->kInitial,1);
				if($check)
				{
					$xSlider = new Slider();
					$xSlider->init((int)$slider->kInitial);
					$smarty->assign($params['cAssign'],$xSlider);
					break;
				}
			}
		}
	}



$smarty->registerPlugin('function', 'loadCSS', 'loadCSS');
$smarty->registerPlugin('function', 'imagePreloadLogo', 'imagePreloadLogo');
$smarty->registerPlugin('function', 'getSizeBySrc', 'getSizeBySrc');
$smarty->registerPlugin('function', 'readJs', 'readJs');
$smarty->registerPlugin('function', 'getZahlungsarten', 'getZahlungsarten');
$smarty->registerPlugin('modifier', 'checkCopyfree', 'checkCopyfree');
$smarty->registerPlugin('modifier', 'optimize', 'optimize');
$smarty->registerPlugin('function', 'checkShowMatrix', 'checkShowMatrix');
$smarty->registerPlugin('function', 'snackys_content', 'snackys_content');
$smarty->registerPlugin('function', 'readSVG', 'readSVG');

function readSVG($params,&$smarty)
{
   if(empty($params['file']))
   {
      $smarty->trigger_error('Missing file name to read within the template.', E_USER_ERROR);
   }

   $file = '';
   if(file_exists($params['file']))
   {
      $file = readfile($params['file']);
   }

   return($file);

}

function snackys_content($params,&$smarty)
{
	
	$Einstellungen = Shop::Smarty()->get_template_vars('snackyConfig'); 
	if($Einstellungen['show_content_ids'] == 'Y' && $params['id'] == 'html_body_start')
		echo '<div class="dropper-box">Snackys Selektor: html_head_start<br>Snackys Selektor: html_head_end</div>';
	if($Einstellungen['show_content_ids'] == 'Y' && substr($params['id'],0,10) != 'html_head_')
		echo "<div class=\"dropper-box\"><strong>Content Box ID</strong><br>Snackys Selektor: ".$params['id']."<br>Dropper Selector: @snackys.".$params['id']."<br>OPC Mount Point: opc_".$params['id']."</div>"; //Aktuell entfernt: Individual Code Select: ".$params['id']."<br>
	
	//Jetzt die Zoneninhalte laden!
	$where = 'WHERE `nZone`=\''.trim($params['id']).'\'';
	
	$nSeitenTyp = $smarty->get_template_vars('nSeitenTyp');
	$device = $smarty->get_template_vars('device');
	$cUrl = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
	//Device
		$where .= ' AND (nDevice=0 OR nDevice='.( ($device->isMobile()) ? 1 : 2).')';
	//PageType
		$where .= ' AND (nPagetype=0 OR nPagetype='.$nSeitenTyp.')';
	//URL
		$where .= ' AND (nUrl=\'\' OR nUrl=\''.$cUrl.'\')';
		
	//echo $where;
	$entries = Shop::DB()->query('SELECT nType,nPHPIf,cClass,cContent FROM `xplugin_km_snackys_content` '.$where.' ORDER BY nSort ASC,cName ASC',2);
	if($entries)
	{
		foreach($entries as $entry)
		{
			$showIt = true;
			if(trim($entry->nPHPIf) != '')
			{
				try{
					//PHP Funktion aufrufen a la $showIt = PHPGHOSTFUNCTION();
					eval('$phpFunc = function(){'.$entry->nPHPIf.'};');
					$showIt = $phpFunc();
				} catch(Exception $e){$showIt = false;}
			}
			if($showIt)
			{
				$code = '';
				switch($entry->nType)
				{
					case 1:
						if($Einstellungen['optimize_content'] == 'Y')
							$entry->cContent = optimize($entry->cContent);
						$code = Shop::Smarty()->fetch('string:'.$entry->cContent);
						break;
					case 2:
						$data = json_decode($entry->cContent);
						if(!isset($defaultOptions))
							$defaultOptions = Artikel::getDefaultOptions();
						if($data)
						{
							$products = explode(";",$data->products);
							$productList = array();
							foreach($products as $product)
							{
								//Suche nach kArtikel
								$kArtikel = Shop::DB()->query('SELECT kArtikel FROM tartikel WHERE cArtNr=\''.trim($product).'\' LIMIT 1',1);
								if($kArtikel)
								{
									$artikel = new Artikel();
									$artikel->fuelleArtikel($kArtikel->kArtikel, $defaultOptions);
									$productList[] = $artikel;
								}
							}
							$sliderTitle = $data->title;
							Shop::Smarty()->assign('tempProducts',$productList);
							Shop::Smarty()->assign('tempTitle',$sliderTitle);
							$code = '<div class="snackys-content '.$entry->cClass.'">'.Shop::Smarty()->fetch('string:{include file=\'snippets/product_slider.tpl\' productlist=$tempProducts title=$tempTitle hideOverlays=true}').'</div>';
						}
						break;
					default:
						$code = '<div class="snackys-content '.$entry->cClass.'">'.$entry->cContent.'</div>';
						break;
				}
				
				//Jetzt ausgeben
				echo $code;
			}
		}
	}
}


function checkShowMatrix($params,&$smarty)
{
	
	$showMatrix = $smarty->getTemplateVars('showMatrix');
	if(isset($params['kundengruppen']) && isset($_SESSION['Kundengruppe']) && isset($_SESSION['Kundengruppe']->kKundengruppe) && $_SESSION['Kundengruppe']->kKundengruppe > 0)
	{
		$gruppen = explode(';',$params['kundengruppen']);
		foreach($gruppen as $gruppe)
		{
			if(intval(trim($gruppe)) == $_SESSION['Kundengruppe']->kKundengruppe)
				$showMatrix = true;
		}
	}
	if($showMatrix == true)
	{

		//Prüfen ob Atrikel Matrixfähig ist!
		$Artikel = $smarty->getTemplateVars('Artikel');
		$conf = Shop::getSettings([CONF_ARTIKELDETAILS]);
        if (verifyGPCDataInteger('quickView') === 0 && !$Artikel->kArtikelVariKombi && !$Artikel->kVariKindArtikel && !$Artikel->nErscheinendesProdukt) {
            $conf = Shop::getSettings([CONF_ARTIKELDETAILS]);
			if (is_array($Artikel->Variationen) &&
				($Artikel->nVariationOhneFreifeldAnzahl === 2 || $Artikel->nVariationOhneFreifeldAnzahl === 1 ||
					($conf['artikeldetails']['artikeldetails_warenkorbmatrix_anzeigeformat'] === 'L' &&
						$Artikel->nVariationOhneFreifeldAnzahl > 1))
			) {
				//the cart matrix cannot deal with those different kinds of variations..
				//so if we got "freifeldvariationen" in combination with normal ones, we have to disable the matrix
				$gesamt_anz = 1;
				foreach ($Artikel->Variationen as $_variation) {
					if ($_variation->cTyp === 'FREIFELD' || $_variation->cTyp === 'PFLICHT-FREIFELD') {
						return;
					}
					$gesamt_anz *= $_variation->nLieferbareVariationswerte;
				}
				foreach ($Artikel->oKonfig_arr as $_oKonfig) {
					if (isset($_oKonfig)) {
						return;
					}
				}

				if($gesamt_anz <= ART_MATRIX_MAX)
					$smarty->assign('showMatrix',true);
			}
        }
	}
}


function optimize($str)
{
	//Iframes nachladen
	$muster = '/\<iframe(.*)>/i';
	$str = preg_replace_callback($muster,function($match){
		if(strpos($match[0],'data-src'))
			return $match[0];
		else
		{
			$snackyConfig = Shop::Smarty()->get_template_vars('snackyConfig');
			return str_replace('src=','src="'.$snackyConfig['preloadImage'].'" data-src=',$match[0]);
		}
	},$str);
	
	//Bilder nachladen
	$muster = '/\<img(.*)>/i';
	$str = preg_replace_callback($muster,function($match){
		if(strpos($match[0],'data-src'))
			return $match[0];
		else
		{
			$snackyConfig = Shop::Smarty()->get_template_vars('snackyConfig');
			return str_replace('src=','src="'.$snackyConfig['preloadImage'].'" data-src=',$match[0]);
		}
	},$str);
	
	return $str;
}
if(file_exists(PFAD_ROOT.'/includes/libs/minify/lib/CSSmin.php'))
	require_once(PFAD_ROOT.'/includes/libs/minify/lib/CSSmin.php');

function getZahlungsarten($params, &$smarty)
{
	if(isset($params['cAssign']))
	{
		$payments = array();
		$payIds = Shop::DB()->query('SELECT kZahlungsart FROM tversandartzahlungsart GROUP BY kZahlungsart',2);
		//print_r($payIds);
		foreach($payIds as $id)
		{
			$temp = new Zahlungsart();
			$temp->load($id->kZahlungsart);
			$payments[] = $temp;
		}
		$smarty->assign($params['cAssign'],$payments);
	}
	
	return false;
}

function readJs($params, &$smarty)
{
	if(empty($params['file'])) 
	{ 
		$smarty->trigger_error('Missing file name to read within the template.', E_USER_ERROR); 
	} 

	$file = ''; 
	if($smarty->template_exists($params['file'])) 
	{ 
		# template_dir will have a trailing slash ( / ) already in its config. 
		if(file_exists($smarty->template_dir['frontend'].$params['file']))
			$file = readfile($smarty->template_dir['frontend'].$params['file']); 
		else
			$file = readfile(PFAD_ROOT.'templates/snackys/'.$params['file']); 
	} 

   return($file);
}

function checkCopyfree($str)
{
	return $str!='XcUxIycWrh5GYSL5vg22WaluNKCiZgDN';
}
function loadCSS($params, &$smarty)
{
	$cssArr = array();
	if(is_array($params['css1'])) $cssArr = array_merge($cssArr,$params['css1']);
	if(is_array($params['css2'])) $cssArr = array_merge($cssArr,$params['css2']);
	if(is_array($params['css3'])) $cssArr = array_merge($cssArr,$params['css3']);
	elseif(!empty($params['css3'])) $cssArr[] = $params['css3'];
	$cTemplateDir = $smarty->get_template_vars('currentTemplateDir');
	$parentTemplateDir = $smarty->get_template_vars('parentTemplateDir');
	$Einstellungen = $smarty->get_template_vars('Einstellungen'); //template.theme.theme_default
	$Einstellungen2 = $smarty->get_template_vars('snackyConfig'); //template.theme.theme_default
	//print_r($Einstellungen);
	$tpl = new Template();
	$xml = $tpl->leseXML();
	$cssNachPageTypes = $xml->CSSPageTypes;
	if(!$cssNachPageTypes)
	{
		$xml = $tpl->leseXML($tpl->getFrontendTemplate());
		$cssNachPageTypes = $xml->CSSPageTypes;
	}
	foreach($cssNachPageTypes as $o)
		foreach($o as $css)
			if($css->attributes()->PageType == $params['cPageType'] || $css->attributes()->PageType == 'all')
			{
				$path = str_replace('##theme##',$Einstellungen['template']['theme']['theme_default'],$css->attributes()->Path);
				if(substr($path,0,1) != '/') $path = '/'.$cTemplateDir.$path;
				$cssArr[] = $path;
			}
		
			
	
	
	$cssConfig = array();
	foreach($Einstellungen2 as $key => $val)
	{
		if(substr($key,0,4) == 'css_')
		$cssConfig[substr($key,4)] = $val;
	}
	
	//Ist es eine Listen oder Detailseite? => GGF CSS Eigenschaften überschreiben!
	$nSeitenTyp = $smarty->get_template_vars('nSeitenTyp');
	$zusatzConfigs = array();
	$zusatzConfigsCheck = '';
	if($nSeitenTyp === 1)
	{
		$x = $smarty->get_template_vars('Artikel');
		if($x && isset($x->FunktionsAttribute))
			$zusatzConfigs = $x->FunktionsAttribute;
	} elseif($nSeitenTyp === 2) {
		$x = $smarty->get_template_vars('AktuelleKategorie');
		if($x && isset($x->categoryFunctionAttributes))
			$zusatzConfigs = $x->categoryFunctionAttributes;
	}
	if(count($zusatzConfigs) > 0)
	{
		foreach($zusatzConfigs as $key => $val)
			if(substr($key,0,4) == 'css_')
			{
				foreach($cssConfig as $key2 => $val2)
					if(strtolower($key2) == strtolower(substr($key,4)))
					{
						$cssConfig[$key2] = $val;
					}
				$zusatzConfigsCheck = substr($key,4).'###'.$val.'|';
			}
	}
	
	
	//Ausgabe!
	$minified = '';
	$zusatzConfigsCheck = ($zusatzConfigsCheck == '') ? '' : '_'.crc32($zusatzConfigsCheck);
	$cssFile = PFAD_ROOT.'templates/snackys/temp/main_inline_css_'.crc32(implode(';',$cssArr)).$zusatzConfigsCheck.'.css';
	
	if(file_exists($cssFile) && !isset($_REQUEST['rebuildCache']))
		$minified = file_get_contents($cssFile);
	
	if($Einstellungen2['debug_mode'] == 'Y') $minified = '';
	
	
	if($minified == '')
	{
		$css = '';
		foreach($cssArr as $file)
		{
			$css .= file_get_contents(PFAD_ROOT.'/'.$file);
		}
			

		$colors = array();
		foreach($cssConfig as $var => $cfg)
			$colors['@'.$var] = $cfg;
		//foreach($Einstellungen['template']['pdListing'] as $var => $cfg)
		//	$colors['@'.$var] = $cfg;
		
		$css = str_replace(array_keys($colors), $colors, $css);
		if(!class_exists('CSSmin'))
			$minified = $css;
		else
		{
			$minify = new CSSmin;
			$minified = @$minify->run($css);
		}
		file_put_contents($cssFile, $minified);
	}
	$css = '<style id="maincss">'.$minified.'</style>';
	echo $css;
}

function getSizeBySrc($params, &$smarty)
{
    list($width, $height, $type, $attr) = getimagesize($params['src']);
	if(!$width) return;
	
	if(isset($params['cAssign']))
		$smarty->assign($params['cAssign'], array('width' => $width, 'height' => $height, 'padding' => ($height / $width * 100)));
	return ;
}

function imagePreloadLogo($params, &$smarty)
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
		$padding = intval(intval($oImgSize->size->height) / intval($oImgSize->size->width) * 100);
		if(!isset($params['noAdd']))
			$add = '<style type="text/css">#logo .image-content:before{padding-top:'.$padding.'%;}</style>';
        return $add.'<img data-src="' . $imageURL . '" width="' . $oImgSize->size->width . '" height="' .
            $oImgSize->size->height . '"' . $imageID . $imageALT . $imageTITLE . $imageCLASS . ' />';
    }

    return '<img src="' . $imageURL . '"' . $imageID . $imageALT . $imageTITLE . $imageCLASS . ' />';
}
?>