<?php

//Special Functions of Snackys
include("snackys.php");

function snackys_empty_func($params, &$smarty){}

if(!defined("APPLICATION_VERSION") || version_compare(APPLICATION_VERSION, 500) > -1)
{
	$smarty->assign('isShopFive',false); 
	include("functions_shop4.php");

	//Shop 5 Fallbacks, empty Functions
	$smarty->registerPlugin('function', 'imageTag', 'snackys_empty_func')
		   ->registerPlugin('function', 'getBoxesByPosition', 'snackys_empty_func')
		   ->registerPlugin('function', 'captchaMarkup', 'snackys_empty_func')
		   ->registerPlugin('function', 'getStates', 'snackys_empty_func')
		   ->registerPlugin('function', 'opcMountPoint', 'snackys_empty_func');

}
else
{
	$smarty->assign('isShopFive',true);
	include("functions_shop5.php");
	
	//Shop 4 deprecated
	$smarty->registerPlugin('function', 'load_boxes', 'snackys_empty_func')
		   ->registerPlugin('function', 'load_boxes_raw', 'snackys_empty_func');
		   
}