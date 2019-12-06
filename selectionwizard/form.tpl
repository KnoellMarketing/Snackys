{if isset($AWA)}
    <h3 class="selection-wizard-desc">
        {$AWA->getDescription()}
    </h3>
    <div class="list-group selection-wizard">
        {foreach $AWA->getQuestions() as $nQuestion => $oFrage}
            {if $AWA->getConf('auswahlassistent_allefragen') === 'Y' || $nQuestion <= $AWA->getCurQuestion()}
                {include file='selectionwizard/question.tpl' AWA=$AWA nQuestion=$nQuestion oFrage=$oFrage}
            {/if}
        {/foreach}
    </div>
{/if}