{lang key="view" assign="view_"}
<h5>{$result->current->cName}</h5>
<ul class="nav navbar-nav">
    <li class="clearfix">
        <a href="#" class="nav-sub" data-ref="0">{lang key="showAll" section="global"}</a>
        <a href="#" class="nav-sub" data-ref="{$result->current->kOberKategorie}">{lang key="back" section="global"}</a>
    </li>
    <li><a href="{$result->current->cURL}" class="nav-active">{$result->current->cName} {$view_|lower}</a></li>
    {include file='snippets/categories_recursive.tpl' i=0 categoryId=$result->current->kKategorie limit=2 caret='right'}
</ul>
