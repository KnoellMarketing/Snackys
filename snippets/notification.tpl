<div class="notification-alert bg-{if isset($type)}{$type}{else}info{/if} panel-wrap{if isset($inline)} no-margin{/if}">
    <div class="panel panel-default clearfix">
        {if isset($title)}<div class="panel-heading">{$title}</div>{/if}
        <div class="panel-body">{$body}</div>
        {if isset($buttons)}
        <div class="panel-footer">
            <div class="btn-group btn-group-justified btn-group-full" role="group">
            {foreach name=buttons from=$buttons item=button}
                <a href="{get_static_route id=$button->href}" class="btn{if isset($button->primary) && $button->primary} btn-primary{else} btn-default{/if}"{if isset($button->dismiss)} data-dismiss="{$button->dismiss}" aria-label="Close"{/if}>
                    {$button->title}
                </a>
            {/foreach}
            </div>
        </div>
        {/if}
    </div>
</div>