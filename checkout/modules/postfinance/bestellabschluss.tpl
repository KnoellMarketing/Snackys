<div style="margin:10px 0;">
   {lang key="postfinanceDesc" section="checkout"}
   {strip}
   <div>
      <form method="post" action="{$url}">
         <input type="hidden" name="PSPID" value="{$PSPID}">
         <input type="hidden" name="orderID" value="{$orderId}">
         <input type="hidden" name="amount" value="{$amount}">
         <input type="hidden" name="currency" value="{$currency}">
         <input type="hidden" name="language" value="{$language}">

         <!-- lay out information -->
         <input type="hidden" name="TITLE" value="{$shopTitle}">

         <!-- post-payment redirection -->
         <input type="hidden" name="accepturl" value="{$acceptURL}">

         <!-- miscellanous -->
         <input type="hidden" name="CN" value="{$CN}">
         <input type="hidden" name="EMAIL" value="{$EMAIL}">
         <input type="hidden" name="SHASign" value="{$shaSign}">

         <input type="submit" value="{$submitCaption}" name="submit2">
      </form>
   </div>
   {/strip}
</div>