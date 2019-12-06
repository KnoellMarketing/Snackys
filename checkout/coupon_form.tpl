{if !empty($cKuponfehler_arr.ungueltig)}
    {if $cKuponfehler_arr.ungueltig == 1}
        <div class="alert alert-danger">{lang key="couponErr1" section="global"}</div>{/if}
    {if $cKuponfehler_arr.ungueltig == 2}
        <div class="alert alert-danger">{lang key="couponErr2" section="global"}</div>{/if}
    {if $cKuponfehler_arr.ungueltig == 3}
        <div class="alert alert-danger">{lang key="couponErr3" section="global"}</div>{/if}
    {if $cKuponfehler_arr.ungueltig == 4}
        <div class="alert alert-danger">{lang key="couponErr4" section="global"}</div>{/if}
    {if $cKuponfehler_arr.ungueltig == 6}
        <div class="alert alert-danger">{lang key="couponErr6" section="global"}</div>{/if}
    {if $cKuponfehler_arr.ungueltig == 11}
        <div class="alert alert-danger">{lang key="invalidCouponCode" section="checkout"}</div>
    {/if}
    {if $cKuponfehler_arr.ungueltig == 12}
        <div class="alert alert-danger">{lang key="invalidCouponCode" section="checkout"}</div>
    {/if}
    {if $cKuponfehler_arr.ungueltig != 1 && $cKuponfehler_arr.ungueltig != 2 && $cKuponfehler_arr.ungueltig != 3 && $cKuponfehler_arr.ungueltig != 4 && $cKuponfehler_arr.ungueltig != 6 && $cKuponfehler_arr.ungueltig != 11}
        <div class="alert alert-danger">{lang key="couponErr99" section="global"}</div>
    {/if}
{/if}

{if $KuponMoeglich == 1}
    <form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form form-inline evo-validate">
        {$jtl_token}
        <input type="hidden" name="pruefekupon" value="1" />
        <fieldset>
            <div class="input-group">
                <input type="text" name="Kuponcode"  maxlength="32" value="{if !empty($Kuponcode)}{$Kuponcode}{/if}" id="kupon" class="form-control" placeholder="{lang key="couponCode" section="account data"}" aria-label="{lang key="couponCode" section="account data"}" />
                <div class="input-group-btn">
                    <input type="submit" value="{lang key="useCoupon" section="checkout"}" class="submit btn btn-default" />
                </div>
            </div>
        </fieldset>
    </form>
{/if}