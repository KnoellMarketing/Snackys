/*! Selectric ϟ v1.13.0 (2017-08-22) - git.io/tjl9sQ - Copyright (c) 2017 Leonardo Santos - MIT License */
!function(e){"function"==typeof define&&define.amd?define(["jquery"],e):"object"==typeof module&&module.exports?module.exports=function(t,s){return void 0===s&&(s="undefined"!=typeof window?require("jquery"):require("jquery")(t)),e(s),s}:e(jQuery)}(function(e){"use strict";var t=e(document),s=e(window),l=["a","e","i","o","u","n","c","y"],i=[/[\xE0-\xE5]/g,/[\xE8-\xEB]/g,/[\xEC-\xEF]/g,/[\xF2-\xF6]/g,/[\xF9-\xFC]/g,/[\xF1]/g,/[\xE7]/g,/[\xFD-\xFF]/g],n=function(t,s){var l=this;l.element=t,l.$element=e(t),l.state={multiple:!!l.$element.attr("multiple"),enabled:!1,opened:!1,currValue:-1,selectedIdx:-1,highlightedIdx:-1},l.eventTriggers={open:l.open,close:l.close,destroy:l.destroy,refresh:l.refresh,init:l.init},l.init(s)};n.prototype={utils:{isMobile:function(){return/android|ip(hone|od|ad)/i.test(navigator.userAgent)},escapeRegExp:function(e){return e.replace(/[.*+?^${}()|[\]\\]/g,"\\$&")},replaceDiacritics:function(e){for(var t=i.length;t--;)e=e.toLowerCase().replace(i[t],l[t]);return e},format:function(e){var t=arguments;return(""+e).replace(/\{(?:(\d+)|(\w+))\}/g,function(e,s,l){return l&&t[1]?t[1][l]:t[s]})},nextEnabledItem:function(e,t){for(;e[t=(t+1)%e.length].disabled;);return t},previousEnabledItem:function(e,t){for(;e[t=(t>0?t:e.length)-1].disabled;);return t},toDash:function(e){return e.replace(/([a-z0-9])([A-Z])/g,"$1-$2").toLowerCase()},triggerCallback:function(t,s){var l=s.element,i=s.options["on"+t],n=[l].concat([].slice.call(arguments).slice(1));e.isFunction(i)&&i.apply(l,n),e(l).trigger("selectric-"+this.toDash(t),n)},arrayToClassname:function(t){var s=e.grep(t,function(e){return!!e});return e.trim(s.join(" "))}},init:function(t){var s=this;if(s.options=e.extend(!0,{},e.fn.selectric.defaults,s.options,t),s.utils.triggerCallback("BeforeInit",s),s.destroy(!0),s.options.disableOnMobile&&s.utils.isMobile())return void(s.disableOnMobile=!0);s.classes=s.getClassNames();var l=e("<input/>",{class:s.classes.input,readonly:s.utils.isMobile()}),i=e("<div/>",{class:s.classes.items,tabindex:-1}),n=e("<div/>",{class:s.classes.scroll}),a=e("<div/>",{class:s.classes.prefix,html:s.options.arrowButtonMarkup}),o=e("<span/>",{class:"label"}),r=s.$element.wrap("<div/>").parent().append(a.prepend(o),i,l),u=e("<div/>",{class:s.classes.hideselect});s.elements={input:l,items:i,itemsScroll:n,wrapper:a,label:o,outerWrapper:r},s.options.nativeOnMobile&&s.utils.isMobile()&&(s.elements.input=void 0,u.addClass(s.classes.prefix+"-is-native"),s.$element.on("change",function(){s.refresh()})),s.$element.on(s.eventTriggers).wrap(u),s.originalTabindex=s.$element.prop("tabindex"),s.$element.prop("tabindex",-1),s.populate(),s.activate(),s.utils.triggerCallback("Init",s)},activate:function(){var e=this,t=e.elements.items.closest(":visible").children(":hidden").addClass(e.classes.tempshow),s=e.$element.width();t.removeClass(e.classes.tempshow),e.utils.triggerCallback("BeforeActivate",e),e.elements.outerWrapper.prop("class",e.utils.arrayToClassname([e.classes.wrapper,e.$element.prop("class").replace(/\S+/g,e.classes.prefix+"-$&"),e.options.responsive?e.classes.responsive:""])),e.options.inheritOriginalWidth&&s>0&&e.elements.outerWrapper.width(s),e.unbindEvents(),e.$element.prop("disabled")?(e.elements.outerWrapper.addClass(e.classes.disabled),e.elements.input&&e.elements.input.prop("disabled",!0)):(e.state.enabled=!0,e.elements.outerWrapper.removeClass(e.classes.disabled),e.$li=e.elements.items.removeAttr("style").find("li"),e.bindEvents()),e.utils.triggerCallback("Activate",e)},getClassNames:function(){var t=this,s=t.options.customClass,l={};return e.each("Input Items Open Disabled TempShow HideSelect Wrapper Focus Hover Responsive Above Below Scroll Group GroupLabel".split(" "),function(e,i){var n=s.prefix+i;l[i.toLowerCase()]=s.camelCase?n:t.utils.toDash(n)}),l.prefix=s.prefix,l},setLabel:function(){var t=this,s=t.options.labelBuilder;if(t.state.multiple){var l=e.isArray(t.state.currValue)?t.state.currValue:[t.state.currValue];l=0===l.length?[0]:l;var i=e.map(l,function(s){return e.grep(t.lookupItems,function(e){return e.index===s})[0]});i=e.grep(i,function(t){return i.length>1||0===i.length?""!==e.trim(t.value):t}),i=e.map(i,function(l){return e.isFunction(s)?s(l):t.utils.format(s,l)}),t.options.multiple.maxLabelEntries&&(i.length>=t.options.multiple.maxLabelEntries+1?(i=i.slice(0,t.options.multiple.maxLabelEntries),i.push(e.isFunction(s)?s({text:"..."}):t.utils.format(s,{text:"..."}))):i.slice(i.length-1)),t.elements.label.html(i.join(t.options.multiple.separator))}else{var n=t.lookupItems[t.state.currValue];t.elements.label.html(e.isFunction(s)?s(n):t.utils.format(s,n))}},populate:function(){var t=this,s=t.$element.children(),l=t.$element.find("option"),i=l.filter(":selected"),n=l.index(i),a=0,o=t.state.multiple?[]:0;i.length>1&&t.state.multiple&&(n=[],i.each(function(){n.push(e(this).index())})),t.state.currValue=~n?n:o,t.state.selectedIdx=t.state.currValue,t.state.highlightedIdx=t.state.currValue,t.items=[],t.lookupItems=[],s.length&&(s.each(function(s){var l=e(this);if(l.is("optgroup")){var i={element:l,label:l.prop("label"),groupDisabled:l.prop("disabled"),items:[]};l.children().each(function(s){var l=e(this);i.items[s]=t.getItemData(a,l,i.groupDisabled||l.prop("disabled")),t.lookupItems[a]=i.items[s],a++}),t.items[s]=i}else t.items[s]=t.getItemData(a,l,l.prop("disabled")),t.lookupItems[a]=t.items[s],a++}),t.setLabel(),t.elements.items.append(t.elements.itemsScroll.html(t.getItemsMarkup(t.items))))},getItemData:function(t,s,l){var i=this;return{index:t,element:s,value:s.val(),className:s.prop("class"),text:s.html(),slug:e.trim(i.utils.replaceDiacritics(s.html())),alt:s.attr("data-alt"),selected:s.prop("selected"),disabled:l}},getItemsMarkup:function(t){var s=this,l="<ul>";return e.isFunction(s.options.listBuilder)&&s.options.listBuilder&&(t=s.options.listBuilder(t)),e.each(t,function(t,i){void 0!==i.label?(l+=s.utils.format('<ul class="{1}"><li class="{2}">{3}</li>',s.utils.arrayToClassname([s.classes.group,i.groupDisabled?"disabled":"",i.element.prop("class")]),s.classes.grouplabel,i.element.prop("label")),e.each(i.items,function(e,t){l+=s.getItemMarkup(t.index,t)}),l+="</ul>"):l+=s.getItemMarkup(i.index,i)}),l+"</ul>"},getItemMarkup:function(t,s){var l=this,i=l.options.optionsItemBuilder,n={value:s.value,text:s.text,slug:s.slug,index:s.index};return l.utils.format('<li data-index="{1}" class="{2}">{3}</li>',t,l.utils.arrayToClassname([s.className,t===l.items.length-1?"last":"",s.disabled?"disabled":"",s.selected?"selected":""]),e.isFunction(i)?l.utils.format(i(s,this.$element,t),s):l.utils.format(i,n))},unbindEvents:function(){var e=this;e.elements.wrapper.add(e.$element).add(e.elements.outerWrapper).add(e.elements.input).off(".sl")},bindEvents:function(){var t=this;t.elements.outerWrapper.on("mouseenter.sl mouseleave.sl",function(s){e(this).toggleClass(t.classes.hover,"mouseenter"===s.type),t.options.openOnHover&&(clearTimeout(t.closeTimer),"mouseleave"===s.type?t.closeTimer=setTimeout(e.proxy(t.close,t),t.options.hoverIntentTimeout):t.open())}),t.elements.wrapper.on("click.sl",function(e){t.state.opened?t.close():t.open(e)}),t.options.nativeOnMobile&&t.utils.isMobile()||(t.$element.on("focus.sl",function(){t.elements.input.focus()}),t.elements.input.prop({tabindex:t.originalTabindex,disabled:!1}).on("keydown.sl",e.proxy(t.handleKeys,t)).on("focusin.sl",function(e){t.elements.outerWrapper.addClass(t.classes.focus),t.elements.input.one("blur",function(){t.elements.input.blur()}),t.options.openOnFocus&&!t.state.opened&&t.open(e)}).on("focusout.sl",function(){t.elements.outerWrapper.removeClass(t.classes.focus)}).on("input propertychange",function(){var s=t.elements.input.val(),l=new RegExp("^"+t.utils.escapeRegExp(s),"i");clearTimeout(t.resetStr),t.resetStr=setTimeout(function(){t.elements.input.val("")},t.options.keySearchTimeout),s.length&&e.each(t.items,function(e,s){if(!s.disabled){if(l.test(s.text)||l.test(s.slug))return void t.highlight(e);if(s.alt)for(var i=s.alt.split("|"),n=0;n<i.length&&i[n];n++)if(l.test(i[n].trim()))return void t.highlight(e)}})})),t.$li.on({mousedown:function(e){e.preventDefault(),e.stopPropagation()},click:function(){return t.select(e(this).data("index")),!1}})},handleKeys:function(t){var s=this,l=t.which,i=s.options.keys,n=e.inArray(l,i.previous)>-1,a=e.inArray(l,i.next)>-1,o=e.inArray(l,i.select)>-1,r=e.inArray(l,i.open)>-1,u=s.state.highlightedIdx,p=n&&0===u||a&&u+1===s.items.length,c=0;if(13!==l&&32!==l||t.preventDefault(),n||a){if(!s.options.allowWrap&&p)return;n&&(c=s.utils.previousEnabledItem(s.lookupItems,u)),a&&(c=s.utils.nextEnabledItem(s.lookupItems,u)),s.highlight(c)}if(o&&s.state.opened)return s.select(u),void(s.state.multiple&&s.options.multiple.keepMenuOpen||s.close());r&&!s.state.opened&&s.open()},refresh:function(){var e=this;e.populate(),e.activate(),e.utils.triggerCallback("Refresh",e)},setOptionsDimensions:function(){var e=this,t=e.elements.items.closest(":visible").children(":hidden").addClass(e.classes.tempshow),s=e.options.maxHeight,l=e.elements.items.outerWidth(),i=e.elements.wrapper.outerWidth()-(l-e.elements.items.width());!e.options.expandToItemText||i>l?e.finalWidth=i:(e.elements.items.css("overflow","scroll"),e.elements.outerWrapper.width(9e4),e.finalWidth=e.elements.items.width(),e.elements.items.css("overflow",""),e.elements.outerWrapper.width("")),e.elements.items.width(e.finalWidth).height()>s&&e.elements.items.height(s),t.removeClass(e.classes.tempshow)},isInViewport:function(){var e=this;if(!0===e.options.forceRenderAbove)e.elements.outerWrapper.addClass(e.classes.above);else if(!0===e.options.forceRenderBelow)e.elements.outerWrapper.addClass(e.classes.below);else{var t=s.scrollTop(),l=s.height(),i=e.elements.outerWrapper.offset().top,n=e.elements.outerWrapper.outerHeight(),a=i+n+e.itemsHeight<=t+l,o=i-e.itemsHeight>t,r=!a&&o,u=!r;e.elements.outerWrapper.toggleClass(e.classes.above,r),e.elements.outerWrapper.toggleClass(e.classes.below,u)}},detectItemVisibility:function(t){var s=this,l=s.$li.filter("[data-index]");s.state.multiple&&(t=e.isArray(t)&&0===t.length?0:t,t=e.isArray(t)?Math.min.apply(Math,t):t);var i=l.eq(t).outerHeight(),n=l[t].offsetTop,a=s.elements.itemsScroll.scrollTop(),o=n+2*i;s.elements.itemsScroll.scrollTop(o>a+s.itemsHeight?o-s.itemsHeight:n-i<a?n-i:a)},open:function(s){var l=this;if(l.options.nativeOnMobile&&l.utils.isMobile())return!1;l.utils.triggerCallback("BeforeOpen",l),s&&(s.preventDefault(),l.options.stopPropagation&&s.stopPropagation()),l.state.enabled&&(l.setOptionsDimensions(),e("."+l.classes.hideselect,"."+l.classes.open).children().selectric("close"),l.state.opened=!0,l.itemsHeight=l.elements.items.outerHeight(),l.itemsInnerHeight=l.elements.items.height(),l.elements.outerWrapper.addClass(l.classes.open),l.elements.input.val(""),s&&"focusin"!==s.type&&l.elements.input.focus(),setTimeout(function(){t.on("click.sl",e.proxy(l.close,l)).on("scroll.sl",e.proxy(l.isInViewport,l))},1),l.isInViewport(),l.options.preventWindowScroll&&t.on("mousewheel.sl DOMMouseScroll.sl","."+l.classes.scroll,function(t){var s=t.originalEvent,i=e(this).scrollTop(),n=0;"detail"in s&&(n=-1*s.detail),"wheelDelta"in s&&(n=s.wheelDelta),"wheelDeltaY"in s&&(n=s.wheelDeltaY),"deltaY"in s&&(n=-1*s.deltaY),(i===this.scrollHeight-l.itemsInnerHeight&&n<0||0===i&&n>0)&&t.preventDefault()}),l.detectItemVisibility(l.state.selectedIdx),l.highlight(l.state.multiple?-1:l.state.selectedIdx),l.utils.triggerCallback("Open",l))},close:function(){var e=this;e.utils.triggerCallback("BeforeClose",e),t.off(".sl"),e.elements.outerWrapper.removeClass(e.classes.open),e.state.opened=!1,e.utils.triggerCallback("Close",e)},change:function(){var t=this;t.utils.triggerCallback("BeforeChange",t),t.state.multiple?(e.each(t.lookupItems,function(e){t.lookupItems[e].selected=!1,t.$element.find("option").prop("selected",!1)}),e.each(t.state.selectedIdx,function(e,s){t.lookupItems[s].selected=!0,t.$element.find("option").eq(s).prop("selected",!0)}),t.state.currValue=t.state.selectedIdx,t.setLabel(),t.utils.triggerCallback("Change",t)):t.state.currValue!==t.state.selectedIdx&&(t.$element.prop("selectedIndex",t.state.currValue=t.state.selectedIdx).data("value",t.lookupItems[t.state.selectedIdx].text),t.setLabel(),t.utils.triggerCallback("Change",t))},highlight:function(e){var t=this,s=t.$li.filter("[data-index]").removeClass("highlighted");t.utils.triggerCallback("BeforeHighlight",t),void 0===e||-1===e||t.lookupItems[e].disabled||(s.eq(t.state.highlightedIdx=e).addClass("highlighted"),t.detectItemVisibility(e),t.utils.triggerCallback("Highlight",t))},select:function(t){var s=this,l=s.$li.filter("[data-index]");if(s.utils.triggerCallback("BeforeSelect",s,t),void 0!==t&&-1!==t&&!s.lookupItems[t].disabled){if(s.state.multiple){s.state.selectedIdx=e.isArray(s.state.selectedIdx)?s.state.selectedIdx:[s.state.selectedIdx];var i=e.inArray(t,s.state.selectedIdx);-1!==i?s.state.selectedIdx.splice(i,1):s.state.selectedIdx.push(t),l.removeClass("selected").filter(function(t){return-1!==e.inArray(t,s.state.selectedIdx)}).addClass("selected")}else l.removeClass("selected").eq(s.state.selectedIdx=t).addClass("selected");s.state.multiple&&s.options.multiple.keepMenuOpen||s.close(),s.change(),s.utils.triggerCallback("Select",s,t)}},destroy:function(e){var t=this;t.state&&t.state.enabled&&(t.elements.items.add(t.elements.wrapper).add(t.elements.input).remove(),e||t.$element.removeData("selectric").removeData("value"),t.$element.prop("tabindex",t.originalTabindex).off(".sl").off(t.eventTriggers).unwrap().unwrap(),t.state.enabled=!1)}},e.fn.selectric=function(t){return this.each(function(){var s=e.data(this,"selectric");s&&!s.disableOnMobile?"string"==typeof t&&s[t]?s[t]():s.init(t):e.data(this,"selectric",new n(this,t))})},e.fn.selectric.defaults={onChange:function(t){e(t).change()},maxHeight:300,keySearchTimeout:500,arrowButtonMarkup:'<b class="button">&#x25be;</b>',disableOnMobile:!1,nativeOnMobile:!0,openOnFocus:!0,openOnHover:!1,hoverIntentTimeout:500,expandToItemText:!1,responsive:!1,preventWindowScroll:!0,inheritOriginalWidth:!1,allowWrap:!0,forceRenderAbove:!1,forceRenderBelow:!1,stopPropagation:!0,optionsItemBuilder:"{text}",labelBuilder:"{text}",listBuilder:!1,keys:{previous:[37,38],next:[39,40],select:[9,13,27],open:[13,32,37,38,39,40],close:[9,27]},customClass:{prefix:"selectric",camelCase:!1},multiple:{separator:", ",keepMenuOpen:!0,maxLabelEntries:!1}}});

var sliderCode = $('#gallery').parent().html();
var slidesToShow = 4;
var firstTime = true;
/* Main Article JS */
(function () {
    'use strict';

    if ($.snacky && !$.snacky.article) {
        $.snacky.article = {};
    }

    var SnackyArticleClass = function() {};

    SnackyArticleClass.prototype = {
		
        data: { isLoading: false, galleryPreviews: 4 },

        constructor: SnackyArticleClass,
		
        load: function()
		{
			this.imageGallery();
			this.makeSelectFancy();
			this.tabs();
			makeVari();
		},
		
		imageGallery: function()
		{
			//activate zoom
			startSlider(slidesToShow);
		},
		
		makeSelectFancy: function()
		{
			$('#buy_form select:not(.nofancy)').selectric({disableOnMobile:false,nativeOnMobile:false,
				optionsItemBuilder: function(itemData) {
					var code = $(itemData.element).attr('data-content');
					if(!code)
						code = '{text}'
					return code;
				}
			});
		},
		
		refreshSelectFancy: function()
		{
			$('#buy_form select:not(.nofancy)').selectric('refresh');
		},
		
		tabs: function()
		{
			$('#article-tab-nav span').on('click',function(e){
				var tabSelector = $(this).attr('aria-controls')
				$('#article-tab-nav li').removeClass('active');
				$(this).parent().addClass('active');
				$('#article-tabs > div').removeClass('active');
				$('#article-tabs > div#' + tabSelector).addClass('active');
				
			});
		}
	}
    // PLUGIN DEFINITION
    // =================
    $.snacky.article = new SnackyArticleClass();
	$.snacky.start($.snacky.article);
})(jQuery);


/* Mobile Tabs Toggle */
$('#article-tabs .panel-heading').on('click',function(e){
	e.preventDefault();
	$(this).parent().toggleClass('open-show');
});

function zoom(e){
	e.stopPropagation();
	if(e && (e.offsetX || (e.touches && e.touches[0] && e.touches[0].pageX)) && (e.offsetY || (e.touches && e.touches[0] && e.touches[0].pageY)))
	{
		var zoomer = e.currentTarget;
		e.offsetX ? offsetX = e.offsetX : offsetX = e.touches[0].pageX
		e.offsetY ? offsetY = e.offsetY : offsetY = e.touches[0].pageY
		x = offsetX/zoomer.offsetWidth*100
		y = offsetY/zoomer.offsetHeight*100
		zoomer.style.backgroundPosition = x + '% ' + y + '%';
	}
}
function initImageZoom()
{
	//Get Image and create zoomdiv
	var image = $('#gallery img').each(function(){
		if($(this).attr('data-big'))
		{
			var div = $(this).parent().addClass("zoom");
			$(this).parent().css('backgroundImage', "url("+$(this).attr('data-big')+")");
			
			//First remove all mousemove Listeners, to avoid duplicate actions
			$(this).parent().off("mousemove");
			this.parentNode.addEventListener('mousemove',zoom);
//			$(this).parent().on("mousemove", zoom);
		}
	});
}

function slickDouble(slidesToShow)
{
	$('#gallery').slick({
		dots: false,
		adaptiveHeight: true,
		asNavFor: '#gallery-thumbs',
		fade: true,
        nextArrow:'<div class="slick-next btn"><div class="css-arrow css-arrow-right"></div></div>',
        prevArrow:'<div class="slick-prev btn"><div class="css-arrow css-arrow-left"></div></div>'
	});
	$('#gallery-thumbs').slick({
		dots: false,
		slidesToShow: slidesToShow,
		slidesToScroll: 1,
		vertical: true,
		asNavFor: '#gallery',
		focusOnSelect: true,
		nextArrow:'<div class="slick-next btn btn-xs"><div class="css-arrow css-arrow-down"></div></div>',
		prevArrow:'<div class="slick-prev btn btn-xs"><div class="css-arrow css-arrow-up"></div></div>'
	});
	
	$('#gallery-thumbs').on('afterChange',function(x,y){$.snacky.rewatchImages();});
	$('#gallery').on('afterChange',function(x,y){$.snacky.rewatchImages();});
}

function slickSingle()
{
	$('#gallery').slick({
		dots: false,
		adaptiveHeight: true,
		fade: true,
        nextArrow:'<div class="slick-next btn"><div class="css-arrow css-arrow-right"></div></div>',
        prevArrow:'<div class="slick-prev btn"><div class="css-arrow css-arrow-left"></div></div>'
	});
	$("#gallery-thumbs .image-wrapper").first().addClass('slick-current');
    $("#gallery-thumbs .image-wrapper").click(function(e){
		$("#gallery-thumbs .image-wrapper").each(function(){$(this).removeClass('slick-current');});
        e.preventDefault();
        slideIndex = $(this).index();
        $( '#gallery' ).slick('slickGoTo', parseInt(slideIndex) );
		$(this).addClass('slick-current');
    });
	$('#gallery').on('afterChange',function(event, slick, currentSlide){
		nr = currentSlide+1;
		$("#gallery-thumbs .image-wrapper").each(function(){$(this).removeClass('slick-current');});
		$("#gallery-thumbs .image-wrapper:nth-child("+nr+")").addClass('slick-current');
	});
	$('#gallery').on('afterChange',function(x,y){$.snacky.rewatchImages();});
}

function startSlider(slidesToShow){
	if( $('#gallery-thumbs').children().length <= 1) {
		/*if($('#gallery img').attr('data-lazy'))
		{
            $('#gallery img').attr('src', $('#gallery img').attr('data-lazy'));
			$('#gallery img').on('load',function(){
				$('#gallery img').removeAttr('data-lazy');
				$('#gallery img').parent().addClass("loaded");
			});
		}*/
	} else if( slidesToShow < $('#gallery-thumbs').children().length ) {
		slickDouble(slidesToShow);
	} else {
		slickSingle();
		if(firstTime == false)
		{
			$('#gallery-thumbs img').each(function()
			{
				if($(this).attr('data-src') || $(this).attr('data-lazy'))
				{
					$(this).attr('src',$(this).attr('data-src') ? $(this).attr('data-src') : $(this).attr('data-lazy'));
					$(this).removeAttr('data-src');
					$(this).removeAttr('data-lazy');
					$(this).parent().addClass('loaded');
				}
			});
		} else
			firstTime = false;
	}
	initImageZoom();
	arrLazy = [].slice.call(document.querySelectorAll("img[data-src]"));
	$.snacky.rewatchImages();
	$('#gallery a').click(function(event) { 
		event.preventDefault();
		$('body').addClass("lightbox-shown"); 
		resizeSlider(slidesToShow,true);
		$('#close-lightbox').show();
		$('#close-lightbox').on('click',function(e){
			e.preventDefault();
			$('body').removeClass("lightbox-shown"); 
			resizeSlider(slidesToShow);
			$('#close-lightbox').hide();
		});
	 });
}


function resizeSlider(slidesToShow,takeBig)
{
	if( $('#gallery-thumbs').children().length > 1)
	{
		$('#gallery').slick('refresh');
		/*
		$('#gallery').parent().html('').append(sliderCode).ready(function(){
			if(takeBig == true)
				$('#gallery img').each(function(){
					if($(this).attr('data-big'))
					{
						if($(this).attr('src'))
							$(this).attr('src',$(this).attr('data-big'));
						else
							$(this).attr('data-src',$(this).attr('data-big'));
					}
				});
			startSlider(slidesToShow);
		});*/
	}
	else
	{
			if(takeBig == true)
				$('#gallery img').each(function(){
					if($(this).attr('data-big'))
					{
						if($(this).attr('src'))
							$(this).attr('src',$(this).attr('data-big'));
						else
							$(this).attr('data-src',$(this).attr('data-big'));
					}
				});
	}
}
 
function makeVari(){
	switch ($('#result-wrapper').attr('variations-type')) {
		case 'varkombi':
			registerVarkombi();
			break;
		case 'simple':
			registerSimple();
			break;
	}
}

function registerSimple()
{
	if($('span.pricestarting').length > 0)
	{
		$('#buy_form input, #buy_form select').on('change',function(){
			//Einfache Variationen - hier ist der Aufpreis relevant und das wars
			var preis = $('#buy_form meta[itemprop=price]').attr('content');
			var hatAufpreis = false;
			$('#buy_form .variations select:visible').children('option:selected').each(function(){
				var aufpreis = $(this).attr('data-aufpreis');
				if(aufpreis && $.trim(aufpreis) != '')
				{
					hatAufpreis = true;
					if(aufpreis.substring(0,1) == '-') 
						preis = (+preis) - (+aufpreis.substring(1));
					else
						preis = (+preis) + (+aufpreis);
				}
			});
			
			$('#buy_form .variations input[type=radio]:visible:checked').each(function(){
				var aufpreis = $(this).attr('data-aufpreis');
				if(aufpreis && $.trim(aufpreis) != '')
				{
					hatAufpreis = true;
					if(aufpreis.substring(0,1) == '-')
						preis = (+preis) - (+aufpreis.substring(1));
					else
						preis = (+preis) + (+aufpreis);
				}
			});
			
				
			//Jetzt das "ab" entfernen und neuen Preis einfügen	- nicht nur auf "hatAufpreis" prüfen, da ggf. nur varianten ohne Aufpreis ausgewählt wurden!
			//if(hatAufpreis)
			//{
				preis = +preis;
				var preisNice = preis.toLocaleString(undefined,{style: 'currency', currency:$('#buy_form meta[itemprop=priceCurrency]').attr('content')});
				$('span.price_label.pricestarting').hide();
				$('strong.price.text-nowrap span').html(preisNice);
			//}
		});
	}
}

function registerVarkombi()
{
	var varKombiArr = JSON.parse(document.getElementById('varKombiArr').innerHTML);
	//Check Varkombis - if valid redirect, of only change: check dependencies
	$('#buy_form input[type=radio]:visible, #buy_form select[required]:visible').on('change',function(){
		//Nur wenn das geänderte Element required ist, war es eine relevante Auswahländerung...
		var cElem = $(this);
		var valid = true;
		var values = new Object;
		$('#buy_form .variations select').each(function(){
			var val = $(this).val();
			if(val && $.trim(val) != '')
			{
				var name = $(this).attr("name");
				name = name.replace('\]','').replace('eigenschaftwert[','');
				values[name] = val;
			} else
				valid = false;
		});
		$('#buy_form .variations input[type=radio]').each(function(){
			var val = $('#buy_form input[name="'+$(this).attr('name')+'"]:checked').val();
			if(val && $.trim(val) != '')
			{
				var name = $(this).attr("name");
				name = name.replace('\]','').replace('eigenschaftwert[','');
				values[name] = val;
			} else
				valid = false;
		});
		if(valid)
		{
			//Scheint valide zu sein, jetzt auf die entsprechende URL weiterleiten
			for(x in varKombiArr)
			{
				var found = true;
				for(key in values)
				{
					//Prüfe ob das die richtige Eigenschaft ist!
					if(varKombiArr[x].eigenschaften[key] != values[key])
						found = false;
				}
				if(found == true)
					$(location).attr('href', varKombiArr[x].kArtikel.cURL);
			}
			console.log('Keine passende Varkombi gefunden');
		} else {
			//Invalide, daher jetzt abhängigkeiten checken (ob durch die neue auswahl ggf. Folge-Auswahlen nicht mehr möglich sind)
			
			// first enable all options
			$('#buy_form input[type=radio][disabled], #buy_form select option[disabled]').each(function(){
			if(!$(this).attr('hidden')) $(this).attr('disabled',false);});
			var setEigenschaften = new Array();
			for(x in varKombiArr)
			{
				var found = true;
				for(key in values)
				{
					//Prüfe ob das die richtige Eigenschaft ist!
					if(varKombiArr[x].eigenschaften[key] != values[key])
						found = false;
				}
				if(found == true)
					setEigenschaften.push(varKombiArr[x].eigenschaften);
			}
			
			//jetzt alle invaliden (nicht gefüllten) elemente durchgehen und prüfen ob die disabled werden müssen
			$('#buy_form .variations select').each(function(){
				var val = $(this).val();
				if(!val || $.trim(val) == '')
				{
					var name = $(this).attr("name");
					name = name.replace('\]','').replace('eigenschaftwert[','');
					//Jetzt prüfen ob die options gesetzt werden dürfen
					$(this).find('option').each(function(){
						var wert = $(this).attr('value');
						var found = false;
						//Jetzt alle Eigenschaften durchgehen ob es diesen Wert gibt
						for(x in setEigenschaften)
						{
							for(y in setEigenschaften[x])
								if(setEigenschaften[x][y] == wert && y == name)
									found = true;
						}
						if(found == false)
							$(this).attr('disabled',true);
					});
				}
			});
			
			$('#buy_form .variations input[type=radio]').each(function(){
				var val = $('#buy_form input[name="'+$(this).attr('name')+'"]:checked').val();
				if(!val || $.trim(val) == '')
				{
					var name = $(this).attr("name");
					name = name.replace('\]','').replace('eigenschaftwert[','');
					//Jetzt prüfen ob die options gesetzt werden dürfen
					var wert = $(this).attr('value');
					var found = false;
					//Jetzt alle Eigenschaften durchgehen ob es diesen Wert gibt
					for(x in setEigenschaften)
					{
						for(y in setEigenschaften[x])
							if(setEigenschaften[x][y] == wert && y == name)
								found = true;
					}
					if(found == false)
						$(this).attr('disabled',true);
				}
			});
		}
		$.snacky.article.refreshSelectFancy();
	});
}