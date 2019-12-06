<div id="priceFlowContainer">
    <canvas id="priceHistoryChart" width="400" height="150"></canvas>
    
    {* assign var="maxPreis" value=0}
    {foreach from=$preisverlaufData|array_reverse item=pv}
        {if $pv->fPreis>$maxPreis}{assign var="maxPreis" value=$pv->fPreis}
        {/if}
    {/foreach}
    {$maxPreis}
    
    {foreach from=$preisverlaufData|array_reverse item=pv}
        Set:<br>
        Datum: {$pv->date}<br>
        Preis: {$pv->fPreis}<br>
        Währung: {$pv->currency}<br><br>
    {/foreach *}
</div>

<script>
    var ctx = document.getElementById('priceHistoryChart').getContext('2d'),
        priceHistoryChart = null,
        chartDataCurrency = '',
        chartData = {ldelim}
        labels:   [],
        datasets: [
            {ldelim}
                fillColor:            "rgba(220,220,220,0.2)",
                strokeColor:          "rgba(220,220,220,1)",
                pointColor:           "rgba(220,220,220,1)",
                pointStrokeColor:     "#fff",
                pointHighlightFill:   "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data:                 []
            {rdelim}
        ]
    {rdelim};

    {foreach from=$preisverlaufData|array_reverse item=pv}
    chartData.labels.push('{$pv->date}');
    chartData.datasets[0].data.push('{$pv->fPreis}');
    chartDataCurrency = '{$pv->currency}';
    {/foreach}
    {* if $Einstellungen.artikeldetails.artikeldetails_tabs_nutzen === 'N' *}
        $(function() {ldelim}
            window.priceHistoryChart = new Chart(window.ctx).Bar(window.chartData, {ldelim}
                responsive:      true,
                scaleBeginAtZero: false,
                tooltipTemplate: "<%if (label){ldelim}%><%=label%> - <%{rdelim}%><%= parseFloat(value).toFixed(2).replace('.', ',') %> " + window.chartDataCurrency
            {rdelim});
        {rdelim});
    {* /if *}
</script>
