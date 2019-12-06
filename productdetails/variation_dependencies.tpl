{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

function checkAbhaengigkeiten(givenElement,givenSelectedIndex)
{ldelim}
   //alle formular felder enablen
   var arSelected = new Array();
   for (var i=0; i<document.getElementById('buy_form').elements.length; i++)
   {ldelim}
      if (document.getElementById('buy_form').elements[i].checked == true)
      {ldelim}
         arSelected[i] = document.getElementById('buy_form').elements[i].id;
      {rdelim}
      if (document.getElementById('buy_form').elements[i].selected == true)
      {ldelim}
         arSelected[i] = document.getElementById('buy_form').elements[i].id;
      {rdelim}
      document.getElementById('buy_form').elements[i].disabled = false;

      if (document.getElementById('buy_form').elements[i].options)
      {ldelim}
         for (var m=0; m<document.getElementById('buy_form').elements[i].options.length; m++)
         {ldelim}
            document.getElementById('buy_form').elements[i].options[m].disabled = false;
            document.getElementById('buy_form').elements[i].options[m].style.color = "#000";
            if(document.getElementById('buy_form').elements[i].options[m].selected==true)   arSelected[i] = document.getElementById('buy_form').elements[i].options[m].id;
         {rdelim}
      {rdelim}

      if (document.getElementById('buy_form').elements[i].id)
      {ldelim}
         id_name = document.getElementById('buy_form').elements[i].id;
         id = id_name +'_span';
         ele = document.getElementById(id);
         if (ele) if (ele.style.color != "#000") ele.style.color = "#000";
      {rdelim}
   {rdelim}

   {foreach name=NichtErlaubteEigenschaftswerte_array from=$arNichtErlaubteEigenschaftswerte key=Wert item=arZiel}
      for (var i=0; i<arSelected.length; i++)
      {ldelim}
         nEigenschaftID = arSelected[i];
         if (nEigenschaftID == 'kEigenschaftWert_{$Wert}')
         {ldelim}
            arAbhaengigkeiten_{$Wert} = new Array(
               {assign var=arCount value=$arZiel|@count}
               {assign var=arCounter value=0}
               {foreach name=NichtErlaubteEigenschaftswerte_array from=$arZiel key=Ziel item=lalala}
                  {assign var=arCounter value=$arCounter+1}
                  'kEigenschaftWert_{$lalala->EigenschaftWert}'{if $arCount==$arCounter}{else},{/if}
               {/foreach});
            for (var k=0; k<arAbhaengigkeiten_{$Wert}.length; k++)
            {ldelim}
               ele_{$Wert} = document.getElementById(arAbhaengigkeiten_{$Wert}[k]);
               if (ele_{$Wert})
               {ldelim}
                  if(ele_{$Wert}.type=='radio')
                  {ldelim}
                     ele_{$Wert}.disabled = true;
                     if (ele_{$Wert}.checked == true) ele_{$Wert}.checked = false;
                     ele_{$Wert} = document.getElementById(arAbhaengigkeiten_{$Wert}[k]+'_span');
                     if (ele_{$Wert}.style.color != "#ccc")   ele_{$Wert}.style.color = "#ccc";
                  {rdelim} else {ldelim}
                     for (var x=0; x<document.getElementById('buy_form').elements.length; x++)
                     {ldelim}
                        if (document.getElementById('buy_form').elements[x]!=undefined)
                        {ldelim}
                           if (document.getElementById('buy_form').elements[x].options)
                           {ldelim}
                              OptionEle = document.getElementById('buy_form').elements[x].options;
                              for (var m=0; m<OptionEle.length; m++)
                              {ldelim}
                                 if(OptionEle[m].value == ele_{$Wert}.value)
                                 {ldelim}
                                    if(OptionEle[OptionEle.selectedIndex].value==ele_{$Wert}.value)
                                    {ldelim}
                                       OptionEle.selectedIndex=0;
                                    {rdelim}
                                    OptionEle[m].style.color = "#ccc";
                                    OptionEle[m].disabled    = true;
                                 {rdelim}
                                 else
                                 {ldelim}
                                    //OptionEle[m].style.color = "#000";
                                 {rdelim}
                              {rdelim}
                           {rdelim}
                        {rdelim}
                     {rdelim}
                  {rdelim}
               {rdelim}
            {rdelim}
         {rdelim}
      {rdelim}
   {/foreach}
   return false;
{rdelim}