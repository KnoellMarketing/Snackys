'use strict';

/**********************************************************************************************************************/
/**********************************************************************************************************************/
/*
$('body').on('click', '.option li', function (e) {
    var i = $(this).parents('.select').attr('id'),
        v = $(this).children().text(),
        o = $(this).attr('id');
    $('#' + i + ' .selected').attr('id', o).text(v);
});
*/

function sanitizeOutput(val) {
    return val.replace(/\&/g, '&amp;')
        .replace(/\</g, '&lt;')
        .replace(/\>/g, '&gt;')
        .replace(/\"/g, '&quot;')
        .replace(/\'/g, '&#x27;')
        .replace(/\//g, '&#x2F;');
}

/**
 *  Format file size
 */
function formatSize(size) {
    var fileSize = Math.round(size / 1024),
        suffix = 'KB',
        fileSizeParts;

    if (fileSize > 1000) {
        fileSize = Math.round(fileSize / 1000);
        suffix = 'MB';
    }

    fileSizeParts = fileSize.toString().split('.');
    fileSize = fileSizeParts[0];

    if (fileSizeParts.length > 1) {
        fileSize += '.' + fileSizeParts[1].substr(0, 2);
    }
    fileSize += suffix;

    return fileSize;
}

function getCategoryMenu(categoryId, success) {
	/*
    var xx = {};
    var io = $.evo.io();

    io.call('getCategoryMenu', [categoryId], xx, function (error, data) {
        if (error) {
            console.error(data);
        }
        else {
            if (typeof success === 'function') {
                success(xx.response);
            }
        }
    });

    return true;
	*/
}

function categoryMenu(rootcategory) {
	/*
    if (typeof rootcategory === 'undefined') {
        rootcategory = $('.sidebar-offcanvas .navbar-categories').html();
    }

    $('.sidebar-offcanvas li a.nav-sub').on('click', function(e) {
        var navbar = $('.sidebar-offcanvas .navbar-categories'),
            ref = $(this).data('ref');

        if (ref === 0) {
            $(navbar).html(rootcategory);
            categoryMenu(rootcategory);
        }
        else {
            getCategoryMenu(ref, function(data) {
                $(navbar).html(data);
                categoryMenu(rootcategory);
            });
        }

        return false;
    });
	*/
}

function compatibility() {
	/*
    var __enforceFocus = $.fn.modal.Constructor.prototype.enforceFocus;
    $.fn.modal.Constructor.prototype.enforceFocus = function () {
        if ($('.modal-body .g-recaptcha').length == 0) {
            __enforceFocus.apply(this, arguments);
        }
    };
	*/
}

function regionsToState() {
    if ($('#state').length == 0)
        return;

    var title = $('#state').attr('title');
    if($('#state').attr('required') == 'required'){
        var stateIsRequired = true;
    } else {
        var stateIsRequired = false;
    }

    $('#country').change(function() {
        var result = {};
        var io = $.evo.io();
        var val = $(this).find(':selected').val();

        io.call('getRegionsByCountry', [val], result, function (error, data) {
            if (error) {
                console.error(data);
            }
            else {
                var data = result.response;
                var def = $('#state').val();
                if (data != null && data.length > 0) {
                    if (stateIsRequired){
                        var state = $('<select />').attr({ id: 'state', name: 'bundesland', class: 'required form-control', required: 'required'});
                    } else {
                        var state = $('<select />').attr({ id: 'state', name: 'bundesland', class: 'form-control'});
                    }

                    state.append('<option value="">' + title + '</option>');
                    $(data).each(function(idx, item) {
                        state.append(
                            $('<option></option>').val(item.cCode).html(item.cName)
                                .attr('selected', item.cCode == def || item.cName == def ? 'selected' : false)
                        );
                    });
                    $('#state').replaceWith(state);
                }
                else {
                    if (stateIsRequired) {
                        var state = $('<input />').attr({ type: 'text', id: 'state', name: 'bundesland', class: 'required form-control', placeholder: title, required: 'required' });
                    } else {
                        var state = $('<input />').attr({ type: 'text', id: 'state', name: 'bundesland', class: 'form-control', placeholder: title });
                    }
                    $('#state').replaceWith(state);
                }
            }
        });
        return false;

    }).trigger('change');
}

function loadContent(url)
{
    $.evo.extended().loadContent(url, function() {
        $.evo.extended().register();

        if (typeof $.evo.article === 'function') {
            $.evo.article().onLoad();
            $.evo.article().register();
            addValidationListener();
        }

        //$('html,body').animate({
        //    scrollTop: $('.list-pageinfo').offset().top - $('#evo-main-nav-wrapper').outerHeight() - 10 
        //}, 100);
    });
}

function navigation()
{
	/*
    var navWrapper = $('#evo-main-nav-wrapper');
    if (navWrapper.hasClass('do-affix')) {
        navWrapper.parent()
            .height(navWrapper.height());
        navWrapper.affix({
            offset: {
                top: navWrapper.offset().top
            }
        });
    }
	*/
}

function addValidationListener() {
    var forms  = $('form.evo-validate'),
        inputs = $('form.evo-validate input,form.evo-validate select,form.evo-validate textarea'),
		selects = $('form.evo-validate select'),
        $body  = $('body');

    for (var i = 0; i < forms.length; i++) {
        forms[i].addEventListener('invalid', function (event) {
            event.preventDefault();
            $(event.target).closest('.form-group').find('div.form-error-msg').remove();
            $(event.target).closest('.form-group').addClass('has-error').append('<div class="form-error-msg text-danger"><i class="fa fa-warning"></i> ' + sanitizeOutput(event.target.validationMessage) + '</div>');

            if (!$body.data('doScrolling')) {
                var $firstError = $(event.target).closest('.form-group.has-error');
                if ($firstError.length > 0) {
                    $body.data('doScrolling', true);
                    var $nav        = $('#evo-main-nav-wrapper.do-affix'),
                        fixedOffset = $nav.length > 0 ? $nav.outerHeight() : 0,
                        vpHeight    = $(window).height(),
                        scrollTop   = $(window).scrollTop();
                    if ($firstError.offset().top > (scrollTop + vpHeight) || $firstError.offset().top < scrollTop) {
                        $('html, body').animate(
                            {
                                scrollTop: $firstError.offset().top - fixedOffset - parseInt($firstError.css('margin-top'))
                            },
                            {
                                done: function () {
                                    $body.data('doScrolling', false);
                                }
                            }, 300
                        );
                    }
                }
            }
        }, true);
    }

    for (var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('blur', function (event) {
            checkInputError(event);
        }, true);
    }
    for (var i = 0; i < selects.length; i++) {
        selects[i].addEventListener('change', function (event) {
            checkInputError(event);
        }, true);
    }



	
	$('.p-c.thumbnail a').hover(function(){
		var s = $(this).find('.second-img img');
		if(s)
		{
			s.attr('src',s.attr('data-hover'));
			s.removeAttr('data-hover');
		}
	});
	

			
}

function checkInputError(event)
{

	var $target = $(event.target);
	$target.closest('.form-group').find('div.form-error-msg').remove();

	if ($target.data('must-equal-to') !== undefined) {
		var $equalsTo = $($target.data('must-equal-to'));
		if ($equalsTo.length === 1) {
			var theOther = $equalsTo[0];
			if (theOther.value !== '' && theOther.value !== event.target.value && event.target.value !== '') {
				event.target.setCustomValidity($target.data('custom-message') !== undefined ? $target.data('custom-message') : sanitizeOutput(event.target.validationMessage));
			} else {
				event.target.setCustomValidity('');
			}
		}
	}

	if (event.target.validity.valid) {
		$target.closest('.form-group').removeClass('has-error');
	} else {
		$target.closest('.form-group').addClass('has-error').append('<div class="form-error-msg text-danger"><i class="fa fa-exclamation-triangle"></i> ' + sanitizeOutput(event.target.validationMessage) + '</div>');
	}
}

function captcha_filled() {
    $('.g-recaptcha').closest('.form-group').find('div.form-error-msg').remove();
}

function isTouchCapable() {
    return 'ontouchstart' in window || (window.DocumentTouch && document instanceof window.DocumentTouch);
}

function snackys()
{
	var tElem,i,t,e,tElemList;


	$("a[href='#top']").click(function() {
		window.scrollTo({ top: 0, behavior: 'smooth' });
		return false;
	});

	//Sidebar NAV
	if(document.getElementById("ftr-tg"))
	{
		for (document.getElementById("ftr-tg").addEventListener("click", function(e) {
			
				//Checken ob Sidebarnav gefüllt ist, oder noch gefüllt werden muss!
				if($('#sp-l').hasClass('lazy'))
				{
					//Load Sidebar and set listeners!
					var url = window.location.href;
					url += url.includes('?') ? '&sidebar=1' : '?sidebar=1';
					$.evo.extended().loadContent(url, function() {
						mainEventListener();
						if($.snackyList)
							$.snacky.panelOpener();
						for(t = document.querySelectorAll("#sp-l .overlay-bg,#sp-l .close-sidebar"), e = 0; e < t.length; e++) t[e].addEventListener("click", function(e) {
							e.preventDefault(), document.body.classList.remove("show-sidebar")
						});
					},false,false,'#sp-l');
					$('#sp-l').removeClass('lazy');
				}
				e.preventDefault(), document.body.classList.contains("show-sidebar") ? document.body.classList.remove("show-sidebar") : document.body.classList.add("show-sidebar")
			}), t = document.querySelectorAll("#sp-l .overlay-bg,#sp-l .close-sidebar"), e = 0; e < t.length; e++) t[e].addEventListener("click", function(e) {
			e.preventDefault(), document.body.classList.remove("show-sidebar")
		})
		
		if($.snacky)
			$.snacky.panelOpener();
	}
	
	$('#header-promo-close').on('click',function(){
		$.evo.io().call('km_promo',false,function(){});
		$('#header-promo').remove();
	});
	
	//Search Toggle
	$('.sr-tg').on('click',function(e){
		$('body').toggleClass('shw-sr-d');
		window.setTimeout(function ()
		{
			document.querySelector('input[name=qs]').focus();
		}, 0);
		
		e.preventDefault();
	});
	
	//touch/mobile megamenu klick = 1ter klick open sub, 2ter klick = zur URL
	if(($('body').hasClass('mobile') || 'ontouchstart' in window)) {
		if(window.screen.width > 767)
		{
			$('.mgm-fw > a').on('click',function(e) {
				e.preventDefault();
				var link = $(this);
				if(link.hasClass('tapped'))
					window.location = link.attr('href');
				else
				{
					link.addClass('tapped');
					link.parent().mouseleave(function(){link.removeClass('tapped')});
				}
			});
		}
	}
	
	// per burgerbutton moviles menu öffnen 
	tElem = document.getElementById('mobile-nav-toggle');
	if(tElem)
		tElem.addEventListener('click',function(e){
			if(!e) e = window.event;
			e.preventDefault();
			if(document.body.classList.contains('shw-sb'))
				document.body.classList.remove('shw-sb');
			else
				document.body.classList.add('shw-sb');
		});
	
	tElemList = document.querySelectorAll('#cat-w .close-btn');
	if(tElemList)
		for(i=0;i<tElemList.length;i++)
		{
			tElemList[i].addEventListener('click',function(e){
				document.body.classList.remove('shw-sb');
			});
		}
		

	// mobil footer boxen öffnen 
	tElem = document.getElementById('footer');
	if(tElem)
	tElem = tElem.getElementsByClassName('panel-heading');
		for(i=0;i<tElem.length;i++)
			tElem[i].addEventListener('click',function(e){
				if(!e) e = window.event;
				e.preventDefault();
				if(e.target.parentNode.parentNode.classList.contains('open-show'))
					e.target.parentNode.parentNode.classList.remove('open-show')
				else
					e.target.parentNode.parentNode.classList.add('open-show')
			});
	

	// wenn n alert button n schließen button hat 
	tElem = document.querySelectorAll('.alert button.close');
	for(i=0;i<tElem.length;i++)
		tElem[i].addEventListener('click',function(e){
		if(!e) e = window.event;
		e.preventDefault();
		e.target.parentNode.classList.add('hidden');
	});
	
	// mobile suche öffnen/schließen 
	tElem = document.getElementById('sr-tg-m');
	if(tElem)
		tElem.addEventListener('click',function(e){
			if(!e) e = window.event;
			e.preventDefault();
			if(document.body.classList.contains('show-search'))
				document.body.classList.remove('show-search');
			else
			{
				document.body.classList.add('show-search');
				window.setTimeout(function ()
				{
					document.querySelector('input[name=qs]').focus();
				}, 0);
			}
		});
	
	//.x Close aus account/index.tpl 
	$('.x').on('click',function(e){e.preventDefault();$(this).closest('.modal-dialog').remove();});
	

	//KLick auf Category Nav Wrapper
	tElem = document.getElementById('cat-w');
	if(tElem)
		tElem.addEventListener('click',function(e){
			if(e.target == document.getElementById('cat-w') || e.target.classList.contains('fullscreen-menu'))
				document.body.classList.remove('shw-sb');
		});
}

function mainEventListener()
{
	
	$('.cart-menu, .cart-menu>a, .cart-menu>a *').click(function(e)
	{
		if(e.target !== e.currentTarget) return;
		e.preventDefault();
		$('.cart-menu').addClass('open');
	});
	

	// hintergrund bei sidebasket wieder schließen 
	tElem = document.querySelectorAll('.c-dp .overlay-bg,.cart-menu .overlay-bg, .c-dp .close-sidebar');
	for(i=0;i<tElem.length;i++)
	{
		tElem[i].addEventListener('click',function(e)
		{
			$('.cart-menu').removeClass('open');
			if(!e) e = window.event;
			e.preventDefault();
			e.target.parentNode.parentNode.classList.remove('open');
			document.body.classList.remove('sidecart-open');
			
		});
	}
						$('.tab-content.notabs .panel-heading').click(function(){
							$(this).closest('.panel-default').toggleClass('open-show');
						});
								$('.collapse-non-validate')
									.on('hidden.bs.collapse', function(e) {
										$(e.target)
											.addClass('hidden')
											.find('fieldset, .form-control')
											.attr('disabled', true);
										e.stopPropagation();
									})
									.on('show.bs.collapse', function(e) {
										$(e.target)
											.removeClass('hidden')
											.attr('disabled', false);
										e.stopPropagation();
									}).on('shown.bs.collapse', function(e) {
										$(e.target)
											.find('fieldset, .form-control')
											.filter(function (i, e) {
												return $(e).closest('.collapse-non-validate.collapse').hasClass('in');
											})
											.attr('disabled', false);
										e.stopPropagation();
									});
								$('.collapse-non-validate.collapse.in')
									.removeClass('hidden')
									.find('fieldset, .form-control')
									.attr('disabled', false);
								$('.collapse-non-validate.collapse:not(.in)')
									.addClass('hidden')
									.find('fieldset, .form-control')
									.attr('disabled', true);

								$('#complete-order-button').click(function () {
									var commentField = $('#comment'),
										commentFieldHidden = $('#comment-hidden');
									if (commentField && commentFieldHidden) {
										commentFieldHidden.val(commentField.val());
									}
								});

    $(document).on('click', '.footnote-vat a, .versand, .popup', function(e) {
        var url = e.currentTarget.href;
        url += (url.indexOf('?') === -1) ? '?isAjax=true' : '&isAjax=true';
        eModal.ajax({
            size: 'lg',
            url: url,
            title: typeof e.currentTarget.title !== 'undefined' ? e.currentTarget.title : '',
            keyboard: true,
            tabindex: -1
        });
        e.stopPropagation();
		e.preventDefault();
        return false;
    });


    $('.dropdown .dropdown-menu.keepopen').on('click touchstart', function(e) {
        e.stopPropagation();
    });
    /*
     * show subcategory on caret click
     */
    $('section.box-categories .nav-panel li a').on('click', function(e) {
        if ($(e.target).hasClass("nav-toggle")) {
            $(e.delegateTarget)
                .parent('li')
                .find('> ul.nav').toggle();
            $(e.delegateTarget)
                .parent('li').toggleClass('open');
            return false;
        }
    });

    /*
     * show linkgroup on caret click
     */
    $('section.box-linkgroup .nav-panel li a').on('click', function(e) {
        if ($(e.target).hasClass("nav-toggle")) {
            $(e.delegateTarget)
                .parent('li')
                .find('> ul.nav').toggle();
            $(e.delegateTarget)
                .parent('li').toggleClass('open');
            return false;
        }
    });
	
	//Modal Lazy Loading!
	$('body').on('shown.bs.modal', function (e) {
	  sImages.rewatch();
	});
}

$(document).ready(function () {
	
	mainEventListener();

    /*if (typeof $.fn.jtl_search === 'undefined') {
        var productSearch = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.obj.whitespace('keyword'),
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            remote:         {
                url:      'io.php?io={"name":"suggestions", "params":["%QUERY"]}',
                wildcard: '%QUERY'
            }
        });

        $('input[name="qs"]').typeahead(
            {
                highlight: true
            },
            {
                name:      'product-search',
                display:   'keyword',
                source:    productSearch,
                templates: {
                    suggestion: function (e) {
                        return e.suggestion;
                    }
                }
            }
        );
    }

    var citySuggestion = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('keyword'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote:         {
            url:      'io.php?io={"name":"getCitiesByZip", "params":["%QUERY", "' + $(this).closest('fieldset').find('.country_input').val() + '", "' + $(this).closest('fieldset').find('.postcode_input').val() + '"]}',
            wildcard: '%QUERY'
        },
        dataType: "json"
    });
    $('.city_input').focusin(function () {
        citySuggestion.remote.url = 'io.php?io={"name":"getCitiesByZip", "params":["%QUERY", "' + $(this).closest('fieldset').find('.country_input').val() + '", "' + $(this).closest('fieldset').find('.postcode_input').val() + '"]}';
    });
    $('.postcode_input').change(function () {
        citySuggestion.remote.url = 'io.php?io={"name":"getCitiesByZip", "params":["%QUERY", "' + $(this).closest('fieldset').find('.country_input').val() + '", "' + $(this).val() + '"]}';
    });
    $('.country_input').change(function () {
        citySuggestion.remote.url = 'io.php?io={"name":"getCitiesByZip", "params":["%QUERY", "' + $(this).val() + '", "' + $(this).closest('fieldset').find('.postcode_input').val() + '"]}';
    });

    $('.city_input').typeahead(
        {
            hint: true,
            minLength: 0
        },
        {
            name:   'cities',
            source: citySuggestion
        }
    );*/

	/*
    $('.btn-offcanvas').click(function() {
        $('body').click();
    });
	*/
    if ("ontouchstart" in document.documentElement) {
        $('.variations .swatches .variation').on('mouseover', function() {
            $(this).trigger('click');
        });
    }
    
    /*
     * activate category parents of active child
     
    var child = $('section.box-categories .nav-panel li.active');
    if (child.length > 0) {
        //$(child).parents('.nav-panel li').addClass('active');
        $(child).parents('.nav-panel li').each(function(i, item) {
           $(item).find('ul.nav').show();
        });
    }
     */


    /*
     * Banner
     */
	 /*
    var bannerLink = $('.banner > a');
    bannerLink.popover({
        placement: 'auto bottom',
        html:      true,
        trigger:   'hover',
        container: 'body',
        content:   function () {
            return $(this).children('.area-desc').html()
        }
    });

    bannerLink.mouseenter(function () {
        $(this).animate({
            borderWidth: 10,
            opacity:     0
        }, 900, function () {
            $(this).css({opacity: 1, borderWidth: 0});
        });
    });

    $('.banner').mouseenter(function () {
        $(this).children('a').animate({
            borderWidth: 10,
            opacity:     0
        }, 900, function () {
            $(this).css({opacity: 1, borderWidth: 0});
        });
    });

    $('.banner > a[href=""]').click(function () {
        return false;
    });

    /*
     * set bootstrap viewport
     */
	 /*
    (function($, document, window, viewport){ 
        var $body = $('body');

        $(window).resize(
            viewport.changed(function() {
                $body.attr('data-viewport', viewport.current());
            })
        );
        $body.attr('data-viewport', viewport.current());
        $body.attr('data-touchcapable', isTouchCapable() ? 'true' : 'false');
    })(jQuery, document, window, ResponsiveBootstrapToolkit);
	*/
    //categoryMenu();
    //regionsToState();
    //compatibility();
    addValidationListener();
	
	snackys();
});
