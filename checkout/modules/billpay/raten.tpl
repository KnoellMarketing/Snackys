<div id="billpay_wrapper">
   <div id="billpay_rate_selection">
      <input type="hidden" name="billpay_rate_total" value="{$oRate->fBase}" />
      <div class="input-group">
         <select class="form-control" name="billpay_rate">
            {foreach from=$nRate_arr item="nRate"}
               <option value="{$nRate}" {if $oRate->nRate == $nRate}selected="selected"{/if}>{$nRate} Raten</option>
            {/foreach}
         </select>
         <span class="input-group-btn">
            <button class="btn btn-primary" type="button" id="billpay_calc_rate" onclick="$.billpay.push();">Raten berechnen</button>
         </span>
      </div>
      <br/>
      <div id="billpay_links" class="btn-group">
         <a class="btn btn-default popup" href="{$cBillpayTermsURL}" target="_blank">AGB Ratenkauf</a>
         <a class="btn btn-default popup" href="{$cBillpayPrivacyURL}" target="_blank">Datenschutzbestimmungen</a>
         <a class="btn btn-default popup" href="{$cBillpayTermsPaymentURL}" target="_blank">Zahlungsbedingungen</a>
      </div>
   </div>

   <div id="billpay_rate_info">
      <h2>Ihre Teilzahlung in {$oRate->nRate} Monatsraten</h2>
      <table class="rates table table-striped">
         <tbody>
            <tr>
               <td>Warenkorbwert</td>
               <td class="text-right">=</td>
               <td class="text-right">{$oRate->fBaseFmt}</td>
            </tr>

            <tr>
               <td>Zinsaufschlag</td>
               <td class="text-right">+</td>
               <td></td>
            </tr>

            <tr>
               <td>({$oRate->fBaseFmt} x {$oRate->fInterest} x {$oRate->nRate}) / 100</td>
               <td class="text-right">=</td>
               <td class="text-right">{$oRate->fSurchargeFmt}</td>
            </tr>

            <tr>
               <td>Bearbeitungsgeb�hr</td>
               <td class="text-right">+</td>
               <td class="text-right">{$oRate->fFeeFmt}</td>
            </tr>

            <tr>
               <td>weitere Geb�hren (z.B. Versandgeb�hr)</td>
               <td class="text-right">+</td>
               <td class="text-right">{$oRate->fOtherSurchargeFmt}</td>
            </tr>

            <tr class="special">
               <td>Gesamtsumme</td>
               <td class="text-right">=</td>
               <td class="text-right">{$oRate->fTotalFmt}</td>
            </tr>

            <tr>
               <td>Geteilt durch die Anzahl der Raten</td>
               <td class="text-right"></td>
               <td class="text-right">{$oRate->nRate} Raten</td>
            </tr>

            <tr>
               <td>Die erste Rate inkl. Geb�hren betr�gt</td>
               <td></td>
               <td class="text-right">{$oRate->oDues_arr[0]->fAmountFmt}</td>
            </tr>

            <tr>
               <td>Jede folgende Rate betr�gt</td>
               <td></td>
               <td class="text-right">{$oRate->oDues_arr[1]->fAmountFmt}</td>
            </tr>

            <tr class="special">
               <td>Effektiver Jahreszins</td>
               <td class="text-right">=</td>
               <td class="text-right">{$oRate->fAnual|replace:'.':','} %</td>
            </tr>
         </tbody>
      </table>
   </div>
</div>
