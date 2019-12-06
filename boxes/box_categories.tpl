{if isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde != 0)}
    {assign var="nID" value=$oBox->kCustomID}
    {get_category_array categoryId=0 categoryBoxNumber=$nID assign='categories'}
    {if !empty($categories)}
        <section class="panel panel-default box box-categories word-break sidebox_categories{$nID}">
            <div class="panel-heading">
                <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
					{if !empty($oBox->cTitel)}{$oBox->cTitel}{else}{lang key="categories" section="global"}{/if}
					{include file="snippets/careticon.tpl"}
				</span>
            </div>
            <div class="box-body">
                <nav class="nav-panel">
                    <ul class="nav blanklist">
						{if $oBox->ePosition == 'bottom'}
                        	{include file='snippets/categories_recursive.tpl' i=0 categoryId=0 categoryBoxNumber=$nID limit=1}
						{else}
                        	{include file='snippets/categories_recursive.tpl' i=0 categoryId=0 categoryBoxNumber=$nID limit=3}
						{/if}
                    </ul>
                </nav>
            </div>
        </section>
    {/if}
{/if}