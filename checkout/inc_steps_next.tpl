{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}
{assign var="step1_active" value=($bestellschritt[1] == 1 || $bestellschritt[2] == 1)}
{assign var="step2_active" value=($bestellschritt[3] == 1 || $bestellschritt[4] == 1)}
{assign var="step3_active" value=($bestellschritt[5] == 1)}
{if $bestellschritt[1] != 3}
    <ul class="nav nav-wizard last">
        {if ($bestellschritt[1] < 3 || $bestellschritt[2] < 3) == false}
        <li class="">
                <span class="nav-badge">
                    <h2 class="h3"><i class="badge">1.</i> {lang section='account data' key='billingAndDeliveryAddress'}</h2>
                </span>
        </li>
        {/if}
        {if ($bestellschritt[3] < 3 || $bestellschritt[4] < 3) == false}
        <li class="">
            <span class="nav-badge">
                <h2 class="h3"><i class="badge">2.</i> {lang section='account data' key='shippingAndPaymentOptions'}</h2>
            </span>
        </li>
        {/if}
        {if $step3_active == false}
        <li class="">
            <span class="nav-badge">
                <h2 class="h3"><i class="badge">3.</i> {lang section='checkout' key='summary'}</h2>
            </span>
        </li>
        {/if}
    </ul>
{/if}