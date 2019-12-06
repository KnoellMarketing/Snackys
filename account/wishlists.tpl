{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

<h1 class="menu-title">{block name="account-wishlist-title"}{lang key="yourWishlist" section="login"}{/block}</h1>
{if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
    {block name="account-wishlist"}
        {block name="account-wishlist-body"}
            {if !empty($oWunschliste_arr[0]->kWunschliste)}
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>{lang key="wishlistName" section="login"}</th>
                        <th>{lang key="wishlistStandard" section="login"}</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach name=wunschlisten from=$oWunschliste_arr item=Wunschliste}
                        <tr>
                            <td><strong><a href="{get_static_route id='jtl.php'}?wl={$Wunschliste->kWunschliste}">{$Wunschliste->cName}</a></strong></td>
                            <td>{if $Wunschliste->nStandard == 1}{lang key="active" section="global"}{/if} {if $Wunschliste->nStandard == 0}{lang key="inactive" section="global"}{/if}</td>
                            <td class="text-right">
                                <form method="post" action="{get_static_route id='jtl.php'}?wllist=1">
                                    <input type="hidden" name="wl" value="{$Wunschliste->kWunschliste}"/>
                                    {$jtl_token}
                                    <span class="btn-group btn-group-sm preload">
                                        {if $Wunschliste->nStandard != 1}
                                            <button class="btn btn-default" name="wls" value="{$Wunschliste->kWunschliste}" title="{lang key="wishlistStandard" section="login"}">
                                                <span class="image-content icon">
													<svg>
													  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-check"></use>
													</svg>
												</span> {lang key="wishlistStandard" section="login"}
                                            </button>
                                        {/if}
                                        {if $Wunschliste->nOeffentlich == 1}
                                            <button type="submit" class="btn btn-default" name="wlAction" value="setPrivate" title="{lang key="wishlistPrivat" section="login"}">
                                                <span class="image-content icon">
													<svg>
													  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-hide"></use>
													</svg>
												</span> <span class="hidden-xs"> {lang key="wishlistSetPrivate" section="login"}</span>
                                            </button>
                                        {/if}
                                        {if $Wunschliste->nOeffentlich == 0}
                                            <button type="submit" class="btn btn-default" name="wlAction" value="setPublic" title="{lang key="wishlistNotPrivat" section="login"}">
                                                <span class="image-content icon">
													<svg>
													  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-show"></use>
													</svg>
												</span> <span class="hidden-xs"> {lang key="wishlistNotPrivat" section="login"}</span>
                                            </button>
                                        {/if}
                                        <button type="submit" class="btn btn-danger" name="wllo" value="{$Wunschliste->kWunschliste}" title="{lang key='wishlisteDelete' section='login'}">
                                            <span class="image-content icon">
												<svg>
												  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-bin-w"></use>
												</svg>
                                            </span>
                                        </button>
                                    </span>
                                </form>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            {/if}
            <form method="post" action="{get_static_route id='jtl.php'}?wllist=1" class="form form-inline">
                {$jtl_token}
                <input name="wlh" type="hidden" value="1" />
                <div class="input-group">
                    <input name="cWunschlisteName" type="text" class="form-control input-sm" placeholder="{lang key="wishlistAddNew" section="login"}" size="25" aria-label="{lang key="wishlistAddNew" section="login"}">
                    <span class="input-group-btn">
                        <input type="submit" class="btn btn-default btn-sm" name="submit" value="{lang key="wishlistSaveNew" section="login"}" />
                    </span>
                </div>
            </form>
        {/block}
    {/block}
{/if}