/**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 */

(function () {
    'use strict';

    if (!$.evo) {
        $.evo = {};
    }

    var EvoClass = function() {};

    EvoClass.prototype = {
        options: { captcha: {} },

        constructor: EvoClass,

        panelOpener: function() {
            var e,t, x = document.getElementById("sp-l"),
                a = this;
			if(x)
			{
				t = x.getElementsByClassName("panel-heading");
				for (e = 0; e < t.length; e++) t[e].onclick = function() {
					this.parentNode.classList.contains("open") ? a.closePanels() : (a.closePanels(), this.parentNode.classList.add("open"))
				};
			}
        },
        closePanels: function() {
            for (var e = document.getElementById("sp-l").getElementsByClassName("panel-heading"), t = 0; t < e.length; t++) e[t].parentNode.classList.remove("open")
        },
        generateSlickSlider: function() {
            /*
             * box product slider
             */

            $('.evo-box-slider:not(.slick-initialized)').slick({
                //dots: true,
                arrows: true,
                slidesToShow: 1
            });

            /*
             * responsive slider (content)
             */
            $('.evo-slider:not(.slick-initialized)').slick({
                //dots: true,
                arrows: true,
                slidesToShow: 3,
                responsive: [
                    {
                        breakpoint: 480, // xs
                        settings: {
                            slidesToShow: 1
                        }
                    },
                    {
                        breakpoint: 768, // sm
                        settings: {
                            slidesToShow: 2
                        }
                    },
                    {
                        breakpoint: 992, // md
                        settings: {
                            slidesToShow: 3
                        }
                    }
                ]
            });
        },

        addSliderTouchSupport: function () {
            $('.carousel').each(function () {
                if ($(this).find('.item').length > 1) {
                    $(this).find('.carousel-control').css('display', 'block');
                    $(this).swiperight(function () {
                        $(this).carousel('prev');
                    }).swipeleft(function () {
                        $(this).carousel('next');
                    });
                } else {
                    $(this).find('.carousel-control').css('display', 'none');
                }
            });
        },

        scrollStuff: function() {
            var breakpoint = 0,
                pos,
                sidePanel = $('#sp-l');

            if(sidePanel.length) {
                breakpoint = sidePanel.position().top + sidePanel.hiddenDimension('height');
            }

            pos = breakpoint - $(this).scrollTop();

            if ($(this).scrollTop() > 200 && !$('#to-top').hasClass('active')) {
                $('#to-top').addClass('active');
            } else if($(this).scrollTop() < 200 && $('#to-top').hasClass('active')) {
                $('#to-top').removeClass('active');
            }

            if ($(window).width() > 768) {
                var $document = $(document),
                    $element = $('.navbar-fixed-top'),
                    className = 'nav-closed';

                $document.scroll(function() {
                    $element.toggleClass(className, $document.scrollTop() >= 150);
                });

            }
        },

        productTabsPriceFlow: function() {
            $('a[href="#tab-priceFlow"]').on('shown.bs.tab', function () {
                if (typeof window.priceHistoryChart !== 'undefined' && window.priceHistoryChart === null) {
                    window.priceHistoryChart = new Chart(window.ctx).Bar(window.chartData, {
                        responsive:      true,
                        scaleBeginAtZero: false,
                        tooltipTemplate: "<%if (label){%><%=label%> - <%}%><%= parseFloat(value).toFixed(2).replace('.', ',') %> " + window.chartDataCurrency
                    });
                }
            });
        },

        autoheight: function() {
			/*
            $('.row-eq-height').each(function(i, e) {
                $(e).children('[class*="col-"]').children().responsiveEqualHeightGrid();
            });
            $('.row-eq-height.gallery > [class*="col-"]').each(function(i, e) {
                $(e).height($('div', $(e)).outerHeight());
            });
			*/
        },
        
        tooltips: function() {
            //$('[data-toggle="tooltip"]').tooltip();
        },

        imagebox: function(wrapper) {
			/*
				deprecated grap
				
				
            var $wrapper = (typeof wrapper === 'undefined' || wrapper.length === 0) ? $('#result-wrapper') : $(wrapper),
                square   = $('.image-box', $wrapper).first().height() + 'px',
                padding  = $(window).height() / 2;

            $('.image-box', $wrapper).each(function(i, item) {
                var box = $(this),
                    img = box.find('img'),
                    src = img.data('src');

                img.css('max-height', square);
                box.css('max-height', square)
                    .addClass('loading');

                if (src && src.length > 0) {
                    //if (src === 'gfx/keinBild.gif') {
                    //    box.removeClass('loading')
                    //        .addClass('none');
                    //    box.parent().find('.overlay-img').remove();
                    //} else {
                        $(img).lazy(padding, function() {
                            $(this).load(function() {
                                img.css('max-height', square);
                                box.css('line-height', square)
                                    .css('max-height', square)
                                    .removeClass('loading')
                                    .addClass('loaded');
                            }).error(function() {
                                box.removeClass('loading')
                                    .addClass('error');
                            });
                        });
                    //}
                }
            });
			*/
        },

        bootlint: function() {
            (function(){
                var p = window.alert;
                var s = document.createElement("script");
                window.alert = function() {
                    console.info(arguments);
                };
                s.onload = function() {
                    bootlint.showLintReportForCurrentDocument([]);
                    window.alert = p;
                };
                s.src = "https://maxcdn.bootstrapcdn.com/bootlint/latest/bootlint.min.js";
                document.body.appendChild(s);
            })();
        },
        
        showNotify: function(options) {
            eModal.alert({
                size: 'lg',
                buttons: false,
                title: options.title, 
                message: options.text,
                keyboard: true,
                tabindex: -1,
                //onShown: function() {
                //    $.evo.generateSlickSlider();
                //}
            });
        },
        
        renderCaptcha: function(parameters) {
            if ($('.g-recaptcha').length > 0) {
                if (typeof parameters !== 'undefined') {
                    this.options.captcha =
                        $.extend({}, this.options.captcha, parameters);
                }

                if (typeof grecaptcha === 'undefined' && !this.options.captcha.loaded) {
                    this.options.captcha.loaded = true;
                    var lang                    = document.documentElement.lang;
                    $.getScript("https://www.google.com/recaptcha/api.js?render=explicit&onload=g_recaptcha_callback&hl=" + lang);
                } else {
                    $('.g-recaptcha').each(function(index, item) {
                        parameters = $.extend({}, $(item).data(), parameters);
                        try {
                            grecaptcha.render(item, parameters);
                        }
                        catch(e) { }
                    });
                }
                $('.g-recaptcha-response').attr('required', true);
            }
        },
        
        popupDep: function() {
            $('#main-wrapper').on('click', '.popup-dep', function(e) {
                var id    = '#popup' + $(this).attr('id'),
                    title = $(this).attr('title'),
                    html  = $(id).html();
                eModal.alert({
                    message: html,
                    title: title,
                    keyboard: true,
                    tabindex: -1,
                    onShown:function () {
                        //the modal just copies all the html.. so we got duplicate IDs which confuses recaptcha
                        var recaptcha = $('.tmp-modal-content .g-recaptcha');
                        if (recaptcha.length === 1) {
                            var siteKey = recaptcha.data('sitekey'),
                                newRecaptcha = $('<div />');
                            if (typeof  siteKey !== 'undefined') {
                                //create empty recapcha div, give it a unique id and delete the old one
                                newRecaptcha.attr('id', 'popup-recaptcha').addClass('g-recaptcha form-group');
                                recaptcha.replaceWith(newRecaptcha);
                                grecaptcha.render('popup-recaptcha', {
                                    'sitekey' : siteKey,
                                    'callback' : 'captcha_filled'

                                });
                            }
                        }
                        addValidationListener();
                        $('.g-recaptcha-response').attr('required', true);
                    }
                });
                return false;
            });
        },

        popover: function() {
            /*
             * <a data-toggle="popover" data-ref="#popover-content123">Click me</a>
             * <div id="popover-content123" class="popover">content here</div> 
             */
            /*$('[data-toggle="popover"]').popover({
                trigger: 'hover',
                html: true,
				sanitize: false,
                content: function() {
                    var ref = $(this).attr('data-ref');
                    return $(ref).html();
                }
            });*/
        },

        smoothScrollToAnchor: function(href, pushToHistory) {
            var anchorRegex = /^#[\w\-]+$/;
            if (!anchorRegex.test(href)) {
                return false;
            }

            var target, targetOffset;
            target = $('#' + href.slice(1));

            if (target.length > 0) {
                // scroll below the static megamenu
                var nav         = $('#evo-main-nav-wrapper.do-affix');
                var fixedOffset = nav.length > 0 ? nav.outerHeight() : 0;

                targetOffset = target.offset().top - fixedOffset - parseInt(target.css('margin-top'));
                $('html, body').animate({scrollTop: targetOffset});

                if (pushToHistory) {
                    history.pushState({}, document.title, location.pathname + href);
                }

                return true;
            }

            return false;
        },

        smoothScroll: function() {
            var supportHistory = (history && history.pushState) ? true : false;
            var that = this;

            this.smoothScrollToAnchor(location.hash, false);
            $(document).delegate('a[href^="#"]', 'click', function(e) {
                var elem = e.target;
                if (!e.isDefaultPrevented()) {
                    // only runs if no other click event is fired
                    if (that.smoothScrollToAnchor(elem.getAttribute('href'), supportHistory)) {
                        e.preventDefault();
                    }
                }
            });
        },

        preventDropdownToggle: function() {
            $('a.dropdown-toggle').click(function(e){
                var elem = e.target;
                if (elem.getAttribute('aria-expanded') == 'true' && elem.getAttribute('href') != '#') {
                    window.location.href = elem.getAttribute('href');
                    e.preventDefault();
                }
            });
        },

        checkout: function() {
            // show only the first submit button (i.g. the button from payment plugin)
            var $submits = $('#checkout-shipping-payment')
                .closest('form')
                .find('input[type="submit"]');
            $submits.addClass('hidden');
            $submits.first().removeClass('hidden');

            $('input[name="Versandart"]', '#checkout-shipping-payment').change(function() {
                var id    = parseInt($(this).val());
                var $form = $(this).closest('form');

                if (isNaN(id)) {
                    return;
                }

                $form.find('fieldset, input[type="submit"]')
                    .attr('disabled', true);

                var url = 'bestellvorgang.php?kVersandart=' + id;
                $.evo.loadContent(url, function() {
                    $.evo.checkout();
                }, null, true);
            });

            $('#country').on('change', function (e) {
                var val = $(this).find(':selected').val();

                $.evo.io().call('checkDeliveryCountry', [val], {}, function (error, data) {
                    var $shippingSwitch = $('#checkout_register_shipping_address');

                    if (data.response) {
                        $shippingSwitch.removeAttr('disabled');
                        $shippingSwitch.parent().removeClass('hidden');
                    } else {
                        $shippingSwitch.attr('disabled', true);
                        $shippingSwitch.parent().addClass('hidden');
                        if ($shippingSwitch.prop('checked')) {
                            $shippingSwitch.prop('checked', false);
                            $('#select_shipping_address').collapse('show');
                        }
                    }
                });
            });
        },

        loadContent: function(url, callback, error, animation, wrapper) {
            var that        = this;
            var $wrapper    = (typeof wrapper === 'undefined' || wrapper.length === 0) ? $('#result-wrapper') : $(wrapper);
            var ajaxOptions = {data: 'isAjax'};
            if (animation) {
                $wrapper.addClass('loading');
            }

            that.trigger('load.evo.content', { url: url });

            $.ajax(url, ajaxOptions).done(function(html) {
                var $data = $(html);
                if (animation) {
                    $data.addClass('loading');
                }
                $wrapper.replaceWith($data);
                $wrapper = $data;
                if (typeof callback === 'function') {
                    callback();
                }
				if(sImages) sImages.rewatch();
            })
            .fail(function() {
                if (typeof error === 'function') {
                    error();
                }
            })
            .always(function() {
                $wrapper.removeClass('loading');
                that.trigger('contentLoaded'); // compatibility
                that.trigger('loaded.evo.content', { url: url });
            });
        },
        
        spinner: function(target) {
            var opts = {
              lines: 12             // The number of lines to draw
            , length: 7             // The length of each line
            , width: 5              // The line thickness
            , radius: 10            // The radius of the inner circle
            , scale: 2.0            // Scales overall size of the spinner
            , corners: 1            // Roundness (0..1)
            , color: '#000'         // #rgb or #rrggbb
            , opacity: 1/4          // Opacity of the lines
            , rotate: 0             // Rotation offset
            , direction: 1          // 1: clockwise, -1: counterclockwise
            , speed: 1              // Rounds per second
            , trail: 100            // Afterglow percentage
            , fps: 20               // Frames per second when using setTimeout()
            , zIndex: 2e9           // Use a high z-index by default
            , className: 'spinner'  // CSS class to assign to the element
            , top: '50%'            // center vertically
            , left: '50%'           // center horizontally
            , shadow: false         // Whether to render a shadow
            , hwaccel: false        // Whether to use hardware acceleration (might be buggy)
            , position: 'absolute'  // Element positioning
            };

            if (typeof target === 'undefined') {
                target = document.getElementsByClassName('product-offer')[0];
            }

            return new Spinner(opts).spin(target);
        },

        trigger: function(event, args) {
            $(document).trigger('evo:' + event, args);
            return this;
        },

        error: function() {
            if (console && console.error) {
                console.error(arguments);
            }
        },
		
		slider: function() {
			$('.sl-ar').unbind();
			$('.sl-nx').on('click',function(){$.evo.slideNext(this);});
			$('.sl-pr').on('click',function(){$.evo.slidePrev(this);});
			$('.no-scrollbar[data-autoplay]').each(function(){
				var that = this;
				setInterval(function(){$.evo.autoSlide(that);},$(this).attr('data-autoplay'));
			});
		},
		slideNext: function(btn) {
			$(btn).closest('.panel').find('.no-scrollbar').animate({
				scrollLeft: ($(btn).closest('.panel').find('.no-scrollbar').scrollLeft()+$(btn).closest('.panel').find('.no-scrollbar').width())
			},300,'swing',function(){$.evo.sliderButtonsAdjust(btn)});
		},
		slidePrev: function(btn) {
			$(btn).closest('.panel').find('.no-scrollbar').animate({
				scrollLeft: ($(btn).closest('.panel').find('.no-scrollbar').scrollLeft()-$(btn).closest('.panel').find('.no-scrollbar').width())
			},300,'swing',function(){$.evo.sliderButtonsAdjust(btn)});
		},
		sliderButtonsAdjust: function(btn){
			$(btn).closest('.panel').find('.sl-ar').removeClass('inactive');
			if($(btn).closest('.panel').find('.no-scrollbar').scrollLeft() <= 1)
				$(btn).closest('.panel').find('.sl-pr').addClass('inactive');
			if($(btn).closest('.panel').find('.no-scrollbar').scrollLeft() >= $(btn).closest('.panel').find('.no-scrollbar')[0].scrollWidth-$(btn).closest('.panel').find('.no-scrollbar').width())
				$(btn).closest('.panel').find('.sl-nx').addClass('inactive');
			
		},
		autoSlide: function(elem)
		{
			if($(elem).closest('.panel').find('.no-scrollbar').scrollLeft() >= $(elem).closest('.panel').find('.no-scrollbar')[0].scrollWidth-$(elem).closest('.panel').find('.no-scrollbar').width())
				$(elem).closest('.panel').find('.no-scrollbar').animate({
					scrollLeft: 0
				},300,'swing',function(){$.evo.sliderButtonsAdjust(elem)});
			else
				$.evo.slideNext(elem);
		},
		
		mobileMenu: function()
		{
			$('#cat-w .fa-caret-down').click(function(e){
				e.preventDefault();
				if($(this).closest('li').hasClass('open'))
				{
					//$('#cat-w li').removeClass('open');
					$(this).closest('li').removeClass('open');
					//$('#cat-w ul').removeClass('noov');
					$(this).closest('ul').removeClass('noov');
				} else {
					//$('#cat-w li').removeClass('open');
					$(this).closest('li').addClass('open');
					//$('#cat-w ul').reClass('noov');
					$(this).closest('ul').addClass('noov');
				}
			});
		},

        /**
         * $.evo.extended() is deprecated, please use $.evo instead
         */
        extended: function() {
            return $.evo;
        },

        register: function() {
            this.addSliderTouchSupport();
            this.productTabsPriceFlow();
            //this.generateSlickSlider();
            //$('.nav-pills, .nav-tabs').tabdrop();
            //this.autoheight();
            //this.tooltips();
            this.imagebox();
            this.renderCaptcha();
            this.popupDep();
            //this.popover();
            this.preventDropdownToggle();
            this.smoothScroll();
            this.checkout();
			this.slider();
			this.mobileMenu();
			this.panelOpener();
        }
    };

    var ie = /(msie|trident)/i.test(navigator.userAgent) ? navigator.userAgent.match(/(msie |rv:)(\d+(.\d+)?)/i)[2] : false;
    if (ie && parseInt(ie) <= 9) {
        $(document).ready(function () {
            $.evo.register();
        });
    } else {
        $(window).on('load', function () {
            $.evo.register();
        });
    }

	/*
    $(window).on('resize', function () {
        $.evo.autoheight();
    });
	*/

    // PLUGIN DEFINITION
    // =================
    $.evo = new EvoClass();
	$.snacky = $.evo;
})(jQuery);

function g_recaptcha_callback() {
    $.evo.renderCaptcha();
}