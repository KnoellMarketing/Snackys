{if $Kunde->fGuthaben > 0 && (!isset($smarty.session.Bestellung->GuthabenNutzen) || !$smarty.session.Bestellung->GuthabenNutzen)}
    <form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form form-inline">
        {$jtl_token}
        <fieldset>
            <div class="row">
                <div class="col-xs-6">
                    <p class="credit-description">{lang key="creditDesc" section="account data"}</p>
                </div>
                <div class="col-xs-6">
                    <p class="alert alert-info credit-amount-description text-center">{lang key="yourCreditIs" section="account data"} <strong class="credit-amount">{$GuthabenLocalized}</strong></p>
                    <input type="hidden" name="guthabenVerrechnen" value="1" />
                    <input type="hidden" name="guthaben" value="1" />
                    <input type="submit" value="{lang key="useCredits" section="checkout"}" class="submit btn btn-default btn-block" />
                </div>
            </div>
        </fieldset>
    </form>
{/if}