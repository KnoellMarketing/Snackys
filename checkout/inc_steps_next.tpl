{assign var="step1_active" value=($bestellschritt[1] == 1 || $bestellschritt[2] == 1)}
{assign var="step2_active" value=($bestellschritt[3] == 1 || $bestellschritt[4] == 1)}
{assign var="step3_active" value=($bestellschritt[5] == 1)}
{if $bestellschritt[1] != 3}
    <ul class="nav nav-wizard last blanklist">
        {if ($bestellschritt[1] < 3 || $bestellschritt[2] < 3) == false}
        <li class="">
                <span class="nav-badge">
                    <h2 class="h3 m0"><span class="badge">1.</span> {lang section='account data' key='billingAndDeliveryAddress'}</h2>
                </span>
        </li>
        {/if}
        {if ($bestellschritt[3] < 3 || $bestellschritt[4] < 3) == false}
        <li class="">
            <span class="nav-badge">
                <h2 class="h3 m0"><span class="badge">2.</span> {lang section='account data' key='shippingAndPaymentOptions'}</h2>
            </span>
        </li>
        {/if}
        {if $step3_active == false}
        <li class="">
            <span class="nav-badge">
                <h2 class="h3 m0"><span class="badge">3.</span> {lang section='checkout' key='summary'}</h2>
            </span>
        </li>
        {/if}
    </ul>
{/if}