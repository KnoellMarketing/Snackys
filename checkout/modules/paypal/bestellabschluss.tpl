<script type="text/javascript">
$(document).ready(function() {ldelim}
   $('#paypal_button').hide();
   $('#paypal_text').html('{lang key="redirect" section="global"}');
   $('#paypal_checkout').submit();
{rdelim});
</script>

<div style="margin:10px 0;">
   {strip}
   <div>
      <img src="{$ShopURL|replace:"http://":"//"}/gfx/PayPal/horizontal_solution_PP.gif" alt="PayPal Logo" />
   </div>
   {/strip}
   <div style="margin:10px 0;" id="paypal_text">
      <noscript>
         {lang key="paypalDesc" section="checkout"}
      </noscript>
   </div>
   <div>
      <form method="post" action="{$url}" id="paypal_checkout">
         {foreach from=$fields key="name" item="value"}
            <input type="hidden" name="{$name}" value="{$value|escape:"html"}">
         {/foreach}
         <input type="submit" value="{lang key="paypalBtn" section="checkout"}" id="paypal_button">
      </form>
   </div>
</div>