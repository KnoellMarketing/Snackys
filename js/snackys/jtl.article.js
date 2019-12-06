/**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 */

(function($, document, window, viewport){
    'use strict';

    var _stock_info = ['out-of-stock', 'in-short-supply', 'in-stock'],
        $v,
        ArticleClass = function () {
            this.init();
        };

    ArticleClass.DEFAULTS = {
        input: {
            id: 'a'
        },
        action: {
            compareList: 'Vergleichsliste',
            compareListRemove: 'Vergleichsliste.remove'
        },
        selector: {
            navBadgeUpdate: '#shop-nav li.compare-list-menu',
            navBadgeAppend: '#shop-nav li.cart-menu',
            boxContainer: 'section.box-compare'
        },
        modal: {
            id: 'modal-article-dialog',
            wrapper: '#result-wrapper',
            wrapper_modal: '#result-wrapper-modal'
        }
    };

    ArticleClass.prototype = {
        modalShown: false,
        modalView: null,

        constructor: ArticleClass,

        init: function () {
            this.options = ArticleClass.DEFAULTS;
            this.gallery = null;
        },
        
        onLoad: function() {
            if (this.isSingleArticle()) {
                var that = this;
                var form = $.evo.io().getFormValues('buy_form');

                if (typeof history.replaceState === 'function') {
                    history.replaceState({
                        a: form.a,
                        a2: form.VariKindArtikel || form.a,
                        url: document.location.href,
                        variations: {}
                    }, document.title, document.location.href);
                }

                window.addEventListener('popstate', function (event) {
                    if (event.state) {
                        that.setArticleContent(event.state.a, event.state.a2, event.state.url, event.state.variations);
                    }
                }, false);
            }
        },

        isSingleArticle: function() {
            return $('#buy_form').length > 0;
        },

        getWrapper: function(wrapper) {
            return typeof wrapper === 'undefined' ? $(this.options.modal.wrapper) : $(wrapper);
        },

        getCurrent: function($item) {
            var $current = $item.hasClass('variation') ? $item : $item.closest('.variation');
            if ($current.context.tagName === 'SELECT') {
                $current = $item.find('option:selected');
            }

            return $current;
        },

        register: function(wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            if (this.isSingleArticle()) {
                this.registerGallery();
                this.registerConfig();
            }

            this.registerSimpleVariations($wrapper);
            this.registerSwitchVariations($wrapper);
            this.registerImageSwitch($wrapper);
            this.registerArticleOverlay($wrapper);
            this.registerFinish($wrapper);
        },

        registerGallery: function() {
            var $gallery = $('#gallery');

            if ($gallery.length === 1) {
                this.gallery          = $gallery.gallery();
                this.galleryIndex     = 0;
                this.galleryLastIdent = '_';
            } else {
                this.gallery = null;
            }
        },

        registerConfig: function() {
            var that   = this,
                config = $('.product-configuration')
                    .closest('form')
                    .find('input[type="radio"], input[type="checkbox"], input[type="number"], select');

            if (config.length > 0) {
                config.on('change', function() {
                    that.configurator();
                })
                    .keypress(function (e) {
                        if (e.which === 13) {
                            return false;
                        }
                    });
                that.configurator(true);
            }
        },

        registerSimpleVariations: function($wrapper) {
            var that = this;

			/*
            $('.variations select', $wrapper).selectpicker({
                iconBase: 'fa',
                tickIcon: 'fa-check',
                hideDisabled: true,
                showTick: true
                /*mobile: true*/
            //});
			//*/
			
			//New
			if($('body').hasClass('ios'))
				$('.variations select', $wrapper).selectric({disableOnMobile:false,nativeOnMobile:false,
					optionsItemBuilder: function(itemData) {
						var code = $(itemData.element).attr('data-content');
						if(!code)
							code = '{text}'
						return code;
					},
					labelBuilder: function(itemData) {
						var code = $(itemData.element).attr('data-content');
						if(!code)
							code = $(itemData.element).text()
						return code;
					}
				});
			else
				$('.variations select', $wrapper).on('mouseenter', function()
				{
					$(this).unbind('mouseenter');
					$(this).selectric({disableOnMobile:false,nativeOnMobile:false,
						optionsItemBuilder: function(itemData) {
							var code = $(itemData.element).attr('data-content');
							if(!code)
								code = '{text}'
							return code;
						},
						labelBuilder: function(itemData) {
							var code = $(itemData.element).attr('data-content');
							if(!code)
								code = $(itemData.element).text()
							return code;
						}
					});
				});
			

            $('.simple-variations input[type="radio"]', $wrapper)
                .on('change', function() {
                    var val = $(this).val(),
                        key = $(this).parent().data('key');
                    $('.simple-variations [data-key="' + key + '"]').removeClass('active');
                    $('.simple-variations [data-value="' + val + '"]').addClass('active');
                });

            $('.simple-variations input[type="radio"], .simple-variations select', $wrapper)
                .each(function(i, item) {
                    var $item   = $(item),
                        wrapper = '#' + $item.closest('form').closest('div').attr('id');

                    $item.on('change', function () {
                        that.variationPrice($(this), true, wrapper);
                    });
                });
        },

        registerSwitchVariations: function($wrapper) {
            var that = this;

            $('.switch-variations input[type="radio"], .switch-variations select', $wrapper)
                .each(function(i, item) {
                    var $item   = $(item),
                        wrapper = '#' + $item.closest('form').closest('div[id]').attr('id');

                    $item.on('change', function () {
                        that.variationSwitch($(this), false, wrapper);
                    });
                });

            // ie11 fallback
            if (typeof document.body.style.msTransform === 'string') {
                $('.variations label.variation', $wrapper)
                    .on('click', function (e) {
                        if (e.target.tagName === 'IMG') {
                            $(this).trigger('click');
                        }
                    });
            }
        },

        registerArticleOverlay: function($wrapper) {
            var that         = this;

            $('.quickview', $wrapper)
                .each(function(i, item) {
                    var $item      = $(item),
                        formID     = $item.data('target'),
                        wrapper    = that.options.modal.wrapper_modal + '_' + formID,
                        srcWrapper = that.options.modal.wrapper + '_' + formID;

                    $item.on('click', function (event) {
                        event.preventDefault();
                        that.modalArticleDetail(this, wrapper, srcWrapper);
                    });
                });
            $wrapper.hover(null, function() {
                $(this).removeClass('active');
            })
        },

        registerImageSwitch: function($wrapper) {
            var that     = this,
                imgSwitch,
                gallery  = this.gallery;

            if (gallery !== null) {
                imgSwitch = function (context, temporary, force) {
                    var $context = $(context),
                        id       = $context.attr('data-key'),
                        value    = $context.attr('data-value'),
                        data     = $context.data('list'),
                        title    = $context.attr('data-title');

                    if (typeof temporary === 'undefined') {
                        temporary = true;
                    }

                    if ((!$context.hasClass('active') || force) && !!data) {
                        gallery.setItems([data], value);

                        if (!temporary) {
                            var items  = [data],
                                stacks = gallery.getStacks();
                            for (var s in stacks) {
                                if (stacks.hasOwnProperty(s) && s.match(/^_[0-9a-zA-Z]*$/) && s !== '_' + id) {
                                    items = $.merge(items, stacks[s]);
                                }
                            }

                            gallery.setItems([data], '_' + id);
                            gallery.setItems(items, '__');
                            gallery.render('__');

                            that.galleryIndex     = gallery.index;
                            that.galleryLastIdent = gallery.ident;
                        } else {
                            gallery.render(value);
                        }
                    }
                }
            } else {
                imgSwitch = function (context, temporary) {
                    var $context = $(context),
                        value    = $context.attr('data-value'),
                        data     = $context.data('list'),
                        title    = $context.attr('data-title');

                    if (typeof temporary === 'undefined') {
                        temporary = true;
                    }

                    if (!!data) {
                        var $wrapper = $(context).closest('.p-w'),
                            $img     = $('.image-box img', $wrapper);
                        if ($img.length === 1) {
                            $img.attr('src', data.md.src);
                            if (!temporary) {
                                $img.data('src', data.md.src);
                            }
                        }
                    }
                };
            }

            $('.variations .bootstrap-select select', $wrapper)
                .change(function() {
                    var sel  = $(this).find('[value=' + this.value + ']'),
                        cont = $(this).closest('.variations');

                    if (cont.hasClass('simple-variations')) {
                        imgSwitch(sel, false, false);
                    } else {
                        imgSwitch(sel, true, false);
                    }
                });

            if (!isTouchCapable() || ResponsiveBootstrapToolkit.current() !== 'xs') {
                $('.variations .bootstrap-select .dropdown-menu li', $wrapper)
                    .hover(function () {
                        var tmp_idx = parseInt($(this).attr('data-original-index')) + 1,
                            rule    = 'select option:nth-child(' + tmp_idx + ')',
                            sel     = $(this).closest('.bootstrap-select').find(rule);
                        imgSwitch(sel);
                    }, function () {
                        var tmp_idx = parseInt($(this).attr('data-original-index')) + 1,
                            rule    = 'select option:nth-child(' + tmp_idx + ')',
                            sel     = $(this).closest('.bootstrap-select').find(rule),
                            gallery = that.gallery,
                            active;

                        if (gallery !== null) {
                            active = $(sel).find('.variation.active');
                            gallery.render(that.galleryLastIdent);
                            gallery.activate(that.galleryIndex);
                        } else {
                            var $wrapper = $(sel).closest('.p-w'),
                                $img     = $('.image-box img', $wrapper);
                            if ($img.length === 1) {
                                $img.attr('src', $img.data('src'));
                            }
                        }
                    });
            }

            $('.variations.simple-variations .variation', $wrapper)
                .click(function () {
                    imgSwitch(this, false);
                });

            if (!isTouchCapable() || ResponsiveBootstrapToolkit.current() !== 'xs') {
                $('.variations .variation', $wrapper)
                    .hover(function () {
                        imgSwitch(this);
                    }, function () {
                        var sel     = $(this).closest('.variation'),
                            gallery = that.gallery;

                        if (gallery !== null) {
                            gallery.render(that.galleryLastIdent);
                            gallery.activate(that.galleryIndex);
                        } else {
                            var $wrapper = $(sel).closest('.p-w'),
                                $img     = $('.image-box img', $wrapper);
                            if ($img.length === 1) {
                                $img.attr('src', $img.data('src'));
                            }
                        }
                    });
            }
        },

        registerFinish: function($wrapper) {
            $('#jump-to-votes-tab', $wrapper).click(function () {
                $('#content a[href="#tab-votes"]').tab('show');
            });

            if (!this.isSingleArticle()) {
                var that = this;

                $('.p-c.hv-e')
                    .on('click', function (event) {
                        if (isTouchCapable() && ResponsiveBootstrapToolkit.current() !== 'xs') {
                            var $this = $(this);

                            if (!$this.hasClass('active')) {
                                event.preventDefault();
                                event.stopPropagation();
                                $('.p-c').removeClass('active');
                                $this.addClass('active');
                            }
                        }
                    })
            }

            this.registerProductActions($wrapper);
        },

        registerProductActions: function($wrapper) {
            var that = this;

            $('*[data-toggle="product-actions"] button', $wrapper)
                .on('click', function(event) {
                    var data = $(this.form).serializeObject();

                    if (that.handleProductAction(this, data)) {
                        event.preventDefault();
                    }
                });
            $('a[data-toggle="product-actions"]', $wrapper)
                .on('click', function(event) {
                    var data  = $(this).data('value');
                    this.name = $(this).data('name');

                    if (that.handleProductAction(this, data)) {
                        event.preventDefault();
                    }
                });
        },

        loadModalArticle: function(url, wrapper, done, fail) {
            var that       = this,
                $wrapper   = this.getWrapper(wrapper),
                id         = wrapper.substring(1),
                $modalBody = $('.modal-body', this.modalView);

            $wrapper.addClass('loading');

            $.ajax(url, {data: {'isAjax':1, 'quickView':1}})
                .done(function(data) {
                    var $html      = $('<div />').html(data);
                    var $headerCSS = $html.find('link[type="text/css"]');
                    var $headerJS  = $html.find('script[src][src!=""]');
                    var content    = $html.find(that.options.modal.wrapper).html();

                    $headerCSS.each(function (pos, item) {
                        var $cssLink = $('head link[href="' + item.href + '"]');
                        if ($cssLink.length === 0) {
                            $('head').append('<link rel="stylesheet" type="text/css" href="' + item.href + '" >');
                        }
                    });

                    $headerJS.each(function (pos, item) {
                        if (typeof item.src !== 'undefined' && item.src.length > 0) {
                            var $jsLink = $('head script[src="' + item.src + '"]');
                            if ($jsLink.length === 0) {
                                $('head').append('<script type="text/javascript" src="' + item.src + '" >');
                            }
                        }
                    });

                    $modalBody.html($('<div id="' + id + '" />').html(content));

                    var $modal  = $modalBody.closest(".modal-dialog"),
                        title   = $modal.find('.modal-body h1'),
                        $config = $('#product-configurator', $modalBody);

                    if ($config.length > 0) {
                        // Configurator in child article!? Currently not supported!
                        $config.remove();
                        $modalBody.addClass('loading');
                        var spinner = $.evo.extended().spinner($modalBody.get(0));
                        location.href = url;
                    }

                    if (title.length > 0 && title.text().length > 0) {
                        $modal.find('.modal-title').text(title.text());
                        title.remove();
                    }

                    $('form', $modalBody).on('submit', function(event) {
                        event.preventDefault();

                        var $form = $(this);
                        var data  = $form.serializeObject();
                        if (data['VariKindArtikel']) {
                            data['a'] = data['VariKindArtikel'];
                        }

                        $.evo.basket().addToBasket($form, data);
                        that.modalView.modal('hide');
                    });

                    if (typeof done === 'function') {
                        done();
                    }
					if(sImages)
						sImages.rewatch();
                })
                .fail(function() {
                    if (typeof fail === 'function') {
                        fail();
                    }
                })
                .always(function() {
                    $wrapper.removeClass('loading');
                });
        },

        addToComparelist: function(data) {
            var productId = parseInt(data[this.options.input.id]);
            if (productId > 0) {
                var that = this;
                $.evo.io().call('pushToComparelist', [productId], that, function(error, data) {
                    if (error) {
                        return;
                    }

                    var response = data.response;

                    if (response) {
                        switch (response.nType) {
                            case 0: // error
                                var errorlist = '<ul><li>' + response.cHints.join('</li><li>') + '</li></ul>';
                                eModal.alert({
                                    title: response.cTitle,
                                    message: errorlist,
                                    keyboard: true,
                                    tabindex: -1
                                });
                                break;
                            case 1: // forwarding
                                window.location.href = response.cLocation;
                                break;
                            case 2: // added to comparelist
                                that.updateComparelist(response);
                                eModal.alert({
                                    title: response.cTitle,
                                    message: response.cNotification,
                                    keyboard: true,
                                    tabindex: -1
                                });
                                break;
                        }
                    }
                });

                return true;
            }

            return false;
        },

        removeFromCompareList: function(data) {
            var productId = parseInt(data[this.options.input.id]);
            if (productId > 0) {
                var that = this;
                $.evo.io().call('removeFromComparelist', [productId], that, function(error, data) {
                    if (error) {
                        return;
                    }

                    var response = data.response;

                    if (response) {
                        switch (response.nType) {
                            case 0: // error
                                var errorlist = '<ul><li>' + response.cHints.join('</li><li>') + '</li></ul>';
                                eModal.alert({
                                    title: response.cTitle,
                                    message: errorlist,
                                    keyboard: true,
                                    tabindex: -1
                                });
                                break;
                            case 1: // forwarding
                                window.location.href = response.cLocation;
                                break;
                            case 2: // removed from comparelist
                                that.updateComparelist(response);
                                break;
                        }
                    }
                });

                return true;
            }

            return false;
        },

        updateComparelist: function(data) {
            var $badgeUpd = $(this.options.selector.navBadgeUpdate);

            if (data.nCount > 1 && data.cNavBadge.length) {
                var badge = $(data.cNavBadge);
                if ($badgeUpd.length > 0) {
                    $badgeUpd.replaceWith(badge);
                } else {
                    $(this.options.selector.navBadgeAppend).before(badge);
                }

                badge.on('click', '.popup', function (e) {
                    var url = e.currentTarget.href;
                    url += (url.indexOf('?') === -1) ? '?isAjax=true' : '&isAjax=true';
                    eModal.ajax({
                        size: 'lg',
                        url: url,
                        keyboard: true,
                        tabindex: -1
                    });
                    e.stopPropagation();

                    return false;
                });
            } else if ($badgeUpd.length > 0) {
                $badgeUpd.remove();
            }

            var $list = $(this.options.selector.boxContainer);

            if ($list.length > 0) {
                if (data.cBoxContainer.length) {
                    var $boxContent = $(data.cBoxContainer);
                    this.registerProductActions($boxContent);
                    $list.replaceWith($boxContent).removeClass('hidden');
                } else {
                    $list.html('').addClass('hidden');
                }
            }
        },

        handleProductAction: function(action, data) {
            switch (action.name) {
                case this.options.action.compareList:
                    return this.addToComparelist(data);
                case this.options.action.compareListRemove:
                    return this.removeFromCompareList(data);
            }

            return false;
        },

        configurator: function(init) {
            if (this.isSingleArticle()) {
                var that      = this,
                    container = $('#cfg-container'),
                    sidebar   = $('#product-configuration-sidebar'),
                    width,
                    form;

                if (container.length === 0) {
                    return;
                }

                if (viewport.current() !== 'lg') {
                    sidebar.removeClass('affix');
                }

                if (!sidebar.hasClass('affix')) {
                    sidebar.css('width', '');
                }

                sidebar.css('width', sidebar.width());

                if (init) {
                    sidebar.affix({
                        offset: {
                            top: function () {
                                var navHeight = $('#evo-main-nav-wrapper.affix').outerHeight(true);
                                navHeight = navHeight === undefined ? 0 : navHeight;
                                var top = parseInt(container.offset().top - navHeight);
                                if (sidebar.hasClass('affix')) {
                                    sidebar.css('top', navHeight);
                                } else {
                                    sidebar.css('top', 0);
                                }
                                if (viewport.current() !== 'lg') {
                                    top = 999999;
                                }
                                return top;
                            },
                            bottom: function () {
                                var bottom = $('body').height() - (container.height() + container.offset().top);
                                if (viewport.current() !== 'lg') {
                                    bottom = 999999;
                                }
                                return bottom;
                            }
                        }
                    });
                }

                $('#buy_form').find('*[data-selected="true"]')
                    .attr('checked', true)
                    .attr('selected', true)
                    .attr('data-selected', null);

                form = $.evo.io().getFormValues('buy_form');

                $.evo.io().call('buildConfiguration', [form], that, function (error, data) {
                    var result,
                        i,
                        j,
                        item,
                        cBeschreibung,
                        quantityWrapper,
                        grp,
                        value,
                        enableQuantity,
                        nNetto,
                        quantityInput;
                    if (error) {
                        $.evo.error(data);
                        return;
                    }
                    result = data.response;

                    if (!result.oKonfig_arr) {
                        $.evo.error('Missing configuration groups');
                        return;
                    }

                    // global price
                    nNetto = result.nNettoPreise;
                    that.setPrice(result.fGesamtpreis[nNetto], result.cPreisLocalized[nNetto], result.cPreisString);
                    that.setStockInformation(result.cEstimatedDelivery);

                    $('#content .summary').html(result.cTemplate);

                    sidebar.affix('checkPosition');

                    // groups
                    for (i = 0; i < result.oKonfig_arr.length; i++) {
                        grp = result.oKonfig_arr[i];
                        quantityWrapper = that.getConfigGroupQuantity(grp.kKonfiggruppe);
                        quantityInput   = that.getConfigGroupQuantityInput(grp.kKonfiggruppe);
                        if (grp.bAktiv) {
                            enableQuantity = grp.bAnzahl;
                            for (j = 0; j < grp.oItem_arr.length; j++) {
                                item = grp.oItem_arr[j];
                                if (item.bAktiv) {
                                    if (item.cBildPfad) {
                                        that.setConfigItemImage(grp.kKonfiggruppe, item.cBildPfad.cPfadKlein);
                                    } else {
                                        that.setConfigItemImage(grp.kKonfiggruppe, grp.cBildPfad);
                                    }
                                    that.setConfigItemDescription(grp.kKonfiggruppe, item.cBeschreibung);
                                    enableQuantity = item.bAnzahl;
                                    if (!enableQuantity) {
                                        quantityInput
                                            .attr('min', item.fInitial)
                                            .attr('max', item.fInitial)
                                            .val(item.fInitial)
                                            .attr('disabled', true);
                                        if (item.fInitial === 1) {
                                            quantityWrapper.slideUp(200);
                                        } else {
                                            quantityWrapper.slideDown(200);
                                        }
                                    } else {
                                        if (quantityWrapper.css('display') === 'none' && !init) {
                                            quantityInput.val(item.fInitial);
                                        }
                                        quantityWrapper.slideDown(200);
                                        quantityInput
                                            .attr('disabled', false)
                                            .attr('min', item.fMin)
                                            .attr('max', item.fMax);
                                        value = quantityInput.val();
                                        if (value < item.fMin || value > item.fMax) {
                                            quantityInput.val(item.fInitial);
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            that.setConfigItemDescription(grp.kKonfiggruppe, '');
                            quantityInput.attr('disabled', true);
                            quantityWrapper.slideUp(200);
                        }
                    }

                    $.evo.extended()
                        .trigger('priceChanged', result);
                });
            }
        },

        variationRefreshAll: function($wrapper) {
            //$('.variations select', $wrapper).selectpicker('refresh');
            $('.variations select', $wrapper).selectric('refresh');
        },

        getConfigGroupQuantity: function (groupId) {
            return $('.cfg-group[data-id="' + groupId + '"] .quantity');
        },

        getConfigGroupQuantityInput: function (groupId) {
            return $('.cfg-group[data-id="' + groupId + '"] .quantity input');
        },

        getConfigGroupImage: function (groupId) {
            return $('.cfg-group[data-id="' + groupId + '"] .group-image img');
        },

        setConfigItemImage: function (groupId, img) {
            $('.cfg-group[data-id="' + groupId + '"] .group-image img').attr('src', img).first();
        },

        setConfigItemDescription: function (groupId, itemBeschreibung) {
            var groupItems                       = $('.cfg-group[data-id="' + groupId + '"] .group-items');
            var descriptionDropdownContent       = groupItems.find('#filter-collapsible_dropdown_' + groupId + '');
            var descriptionDropdownContentHidden = groupItems.find('.hidden');
            var descriptionCheckdioContent       = groupItems.find('div[id^="filter-collapsible_checkdio"]');
            var multiselect                      = groupItems.find('select').attr("multiple");

            //  Bisher kein Content mit einer Beschreibung vorhanden, aber ein Artikel mit Beschreibung ausgewählt
            if (descriptionDropdownContentHidden.length > 0 && descriptionCheckdioContent.length === 0 && itemBeschreibung.length > 0 && multiselect !== "multiple") {
                groupItems.find('a[href="#filter-collapsible_dropdown_' + groupId + '"]').removeClass('hidden');
                descriptionDropdownContent.replaceWith('<div id="filter-collapsible_dropdown_' + groupId + '" class="collapse top10 panel-body">' + itemBeschreibung + '</div>');
                //  Bisher Content mit einer Beschreibung vorhanden, aber ein Artikel ohne Beschreibung ausgewählt
            } else if (descriptionDropdownContentHidden.length === 0 && descriptionCheckdioContent.length === 0 && itemBeschreibung.length === 0 && multiselect !== "multiple") {
                groupItems.find('a[href="#filter-collapsible_dropdown_' + groupId + '"]').addClass('hidden');
                descriptionDropdownContent.addClass('hidden');
                //  Bisher Content mit einer Beschreibung vorhanden und ein Artikel mit Beschreibung ausgewählt
            } else if (descriptionDropdownContentHidden.length === 0 && descriptionCheckdioContent.length === 0 && itemBeschreibung.length > 0 && multiselect !== "multiple") {
                descriptionDropdownContent.replaceWith('<div id="filter-collapsible_dropdown_' + groupId + '" class="collapse top10 panel-body">' + itemBeschreibung + '</div>');
            }
        },

        setPrice: function(price, fmtPrice, priceLabel, wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            if (this.isSingleArticle()) {
                $('#product-offer .price', $wrapper).html(fmtPrice);
                if (priceLabel.length > 0) {
                    $('#product-offer .price_label', $wrapper).html(priceLabel);
                }
            } else {
                var $price = $('.price_wrapper', $wrapper);

                $('.price span:first-child', $price).html(fmtPrice);
                if (priceLabel.length > 0) {
                    $('.price_label', $price).html(priceLabel);
                }
            }

            $.evo.trigger('changed.article.price', { price: price });
        },

        setStockInformation: function(cEstimatedDelivery, wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            $('.delivery-status .estimated-delivery span', $wrapper).html(cEstimatedDelivery);
        },

        setStaffelPrice: function(prices, fmtPrices, wrapper) {
            var $wrapper   = this.getWrapper(wrapper),
                $container = $('#product-offer', $wrapper);

            $.each(fmtPrices, function(index, value){
                $('.bulk-price-' + index + ' .bulk-price', $container).html(value);
            });
        },

        setVPEPrice: function(fmtVPEPrice, VPEPrices, fmtVPEPrices, wrapper) {
            var $wrapper   = this.getWrapper(wrapper),
                $container = $('#product-offer', $wrapper);

            $('.base-price .value', $container).html(fmtVPEPrice);
            $.each(fmtVPEPrices, function(index, value){
                $('.bulk-price-' + index + ' .bulk-base-price', $container).html(value);
            });
        },

        /**
         * @deprecated since 4.05 - use setArticleWeight instead
         */
        setUnitWeight: function(UnitWeight, newUnitWeight) {
            $('#article-tabs .product-attributes .weight-unit').html(newUnitWeight);
        },

        setArticleWeight: function(ArticleWeight, wrapper) {
            if (this.isSingleArticle()) {
                var $articleTabs = $('#article-tabs');

                if ($.isArray(ArticleWeight)) {
                    $('.product-attributes .weight-unit', $articleTabs).html(ArticleWeight[0][1]);
                    $('.product-attributes .weight-unit-article', $articleTabs).html(ArticleWeight[1][1]);
                } else {
                    $('.product-attributes .weight-unit', $articleTabs).html(ArticleWeight);
                }
            } else {
                var $wrapper = this.getWrapper(wrapper);

                if ($.isArray(ArticleWeight)) {
                    $('.attr-weight .value', $wrapper).html(ArticleWeight[0][1]);
                    $('.attr-weight.weight-unit-article .value', $wrapper).html(ArticleWeight[1][1]);
                } else {
                    $('.attr-weight .value', $wrapper).html(ArticleWeight);
                }
            }

        },

        setProductNumber: function(productNumber, wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            $('#product-offer span[itemprop="sku"]', $wrapper).html(productNumber);
        },

        setArticleContent: function(id, variation, url, variations, wrapper) {
            var $wrapper  = this.getWrapper(wrapper),
                listStyle = $('#ed_list.active').length > 0 ? 'list' : 'gallery',
                $spinner  = $.evo.extended().spinner($wrapper.get(0));

            if (this.modalShown) {
                this.loadModalArticle(url, wrapper,
                    function() {
                        var article = new ArticleClass();
                        article.register(wrapper);
                        $spinner.stop();
                    },
                    function() {
                        $spinner.stop();
                        $.evo.error('Error loading ' + url);
                    }
                );
            } else if (this.isSingleArticle()) {
                $.evo.extended().loadContent(url, function (content) {
                    $.evo.extended().register();
                    $.evo.article().register(wrapper);

                    $(variations).each(function (i, item) {
                        $.evo.article().variationSetVal(item.key, item.value, wrapper);
                    });

                    if (document.location.href !== url) {
                        history.pushState({a: id, a2: variation, url: url, variations: variations}, "", url);
                    }

                    $spinner.stop();
                }, function () {
                    $.evo.error('Error loading ' + url);
                    $spinner.stop();
                }, false, wrapper);
            } else {
                $.evo.extended().loadContent(url + (url.indexOf('?') >= 0 ? '&' : '?') + 'isListStyle=' + listStyle, function (content) {
                    $.evo.extended().imagebox(wrapper);
                    $.evo.article().register(wrapper);

                    $('[data-toggle="basket-add"]', $(wrapper)).on('submit', function(event) {
                        event.preventDefault();
                        event.stopPropagation();

                        var $form = $(this);
                        var data  = $form.serializeObject();
                        data['a'] = variation;

                        $.evo.basket().addToBasket($form, data);
                    });

                    $(variations).each(function (i, item) {
                        $.evo.article().variationSetVal(item.key, item.value, wrapper);
                    });

                    if (!$wrapper.hasClass('hv-e')) {
                        $.evo.extended().autoheight();
                    }
                    $spinner.stop();
                }, function () {
                    $.evo.error('Error loading ' + url);
                    $spinner.stop();
                }, false, wrapper);
            }
			if(sImages)
				sImages.rewatch();
        },

        variationResetAll: function(wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            $('.variation[data-value] input:checked', $wrapper).prop('checked', false);
            $('.variations select option', $wrapper).prop('selected', false);
            //$('.variations select', $wrapper).selectpicker('refresh');
            $('.variations select', $wrapper).selectric('refresh');
        },

        variationDisableAll: function(wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            $('.swatches-selected', $wrapper).text('');
            $('[data-value].variation', $wrapper).each(function(i, item) {
                $(item)
                    .removeClass('active')
                    .removeClass('loading')
                    .addClass('not-available');
                $.evo.article()
                    .removeStockInfo($(item));
            });
        },

        variationSetVal: function(key, value, wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            $('[data-key="' + key + '"]', $wrapper).val(value);
        },

        variationEnable: function(key, value, wrapper) {
            var $wrapper = this.getWrapper(wrapper),
                $item    = $('[data-value="' + value + '"].variation', $wrapper);

            $item.removeClass('not-available');
        },

        variationActive: function(key, value, def, wrapper) {
            var $wrapper = this.getWrapper(wrapper),
                $item    = $('[data-value="' + value + '"].variation', $wrapper);

            $item.addClass('active')
                .removeClass('loading')
                .find('input')
                .prop('checked', true)
                .end()
                .prop('selected', true);

            $('[data-id="'+key+'"].swatches-selected')
                .text($item.attr('data-original'));
        },

        removeStockInfo: function($item) {
            var type = $item.attr('data-type'),
                elem,
                label,
                wrapper;

            switch (type) {
                case 'option':
                    label = $item.data('content');
                    wrapper = $('<div />').append(label);
                    $(wrapper)
                        .find('.label-not-available')
                        .remove();
                    label = $(wrapper).html();
                    $item.data('content', label)
                        .attr('data-content', label);
                    break;
                case 'radio':
                    elem = $item.find('.label-not-available');
                    if (elem.length === 1) {
                        $(elem).remove();
                    }
                    break;
                case 'swatch':
                    if ($item.data('bs.tooltip')) {
                        $item.tooltip('destroy');
                        $item.attr('title', $item.attr('data-title'));
                    }
                    break;
            }

            $item.removeAttr('data-stock');
        },

        variationInfo: function(value, status, note, wrapper) {
            var $wrapper = this.getWrapper(wrapper),
                $item    = $('[data-value="' + value + '"].variation', $wrapper),
                type     = $item.attr('data-type'),
                text,
                content,
                $wrapper,
                label;

            $item.attr('data-stock', _stock_info[status]);

            switch (type) {
                case 'option':
                    text     = ' (' + note + ')';
                    content  = $item.data('content');
                    $wrapper = $('<div />');

                    $wrapper.append(content);
                    $wrapper
                        .find('.label-not-available')
                        .remove();

                    label = $('<span />')
                        .addClass('label label-default label-not-available')
                        .text(note);

                    $wrapper.append(label);

                    $item.data('content', $wrapper.html())
                        .attr('data-content', $wrapper.html());

                    $item.closest('select')
							.selectric('refresh');
                   //     .selectpicker('refresh');
                    break;
                case 'radio':
                    $item.find('.label-not-available')
                        .remove();

                    label = $('<span />')
                        .addClass('label label-default label-not-available')
                        .text(note);

                    $item.append(label);
                    break;
                case 'swatch':
                    $item.attr('title', note);
                    window.setTimeout(function () {
                        $item.tooltip({
                            title: note,
                            trigger: 'hover',
                            container: 'body'
                        });
                    }, 300);
                    break;
            }
        },

        variationSwitch: function($item, animation, wrapper) {
            if ($item) {
                var formID   = $item.closest('form').attr('id'),
                    $current = this.getCurrent($item),
                    key      = $current.data('key'),
                    value    = $current.data('value'),
                    io       = $.evo.io(),
                    args     = io.getFormValues(formID),
                    $spinner = null,
                    $wrapper = this.getWrapper(wrapper);

                if (animation) {
                    $wrapper.addClass('loading');
                    $spinner = $.evo.extended().spinner();
                } else {
                    $('.updatingStockInfo', $wrapper).show();
                }

                $current.addClass('loading');
                args.wrapper = wrapper;

                $.evo.article()
                    .variationDispose(wrapper);

                io.call('checkVarkombiDependencies', [args, key, value], $item, function (error, data) {
                    $wrapper.removeClass('loading');
                    if (animation) {
                        $spinner.stop();
                    }
                    $('.updatingStockInfo', $wrapper).hide();
                    if (error) {
                        $.evo.error('checkVarkombiDependencies');
                    }
                });
            }
        },

        variationPrice: function($item, animation, wrapper) {
            var formID   = $item.closest('form').attr('id'),
                $wrapper = this.getWrapper(wrapper),
                io       = $.evo.io(),
                args     = io.getFormValues(formID),
                $spinner = null;

            if (animation) {
                $wrapper.addClass('loading');
                $spinner = $.evo.extended().spinner();
            }

            args.wrapper = wrapper;

            io.call('checkDependencies', [args], null, function (error, data) {
                $wrapper.removeClass('loading');
                if (animation) {
                    $spinner.stop();
                }
                if (error) {
                    $.evo.error('checkDependencies');
                }
            });
        },

        modalArticleDetail: function(item, wrapper, srcWrapper) {
            var that     = this,
                title    = $(srcWrapper).find('h4.title').text(),
                image    = $(srcWrapper).find('.img-ct').html(),
                url      = $(item).data('src');

            if (typeof this.modalView === 'undefined' || this.modalView === null) {
                this.modalView = $(
                    '<div id="' + this.options.modal.id + '" class="modal fade" role="dialog" tabindex="-1" >' +
                    '   <div class="modal-dialog modal-lg">' +
                    '       <div class="modal-content">' +
                    '           <div class="modal-header">' +
                    '               <button type="button" class="x close" data-dismiss="modal">&times;</button>' +
                    '               <h4 class="modal-title">' + title + '</h4>' +
                    '           </div>' +
                    '           <div class="modal-body"><div id="' + wrapper.substring(1) + '" style="min-height:100px">' + image + '</div></div>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>');
                this.modalView
                    .on('hidden.bs.modal', function() {
                        $('.modal-body', that.modalView).html('<div id="' + wrapper.substring(1) + '" style="min-height:100px" />');
                        $('.modal-title', that.modalView).html('');
                        that.modalView
                            .off('shown.bs.modal');
                        that.modalShown = false;
                    });
            } else {
                $('.modal-title', that.modalView).html(title);
                $('.modal-body', that.modalView).html('<div id="' + wrapper.substring(1) + '" style="min-height:100px">' + image + '</div>');
            }

            this.modalView
                .on('shown.bs.modal', function() {
                    var $spinner = $.evo.extended().spinner($(wrapper).get(0));

                    that.modalShown = true;
                    that.loadModalArticle(url, wrapper,
                        function() {
                            var article = new ArticleClass();
                            article.register(wrapper);
                            $spinner.stop();
                        },
                        function() {
                            $spinner.stop();
                            $.evo.error('Error loading ' + params.url);
                        }
                    );
                })
                .modal('show');
        },

        variationDispose: function(wrapper) {
            var $wrapper = this.getWrapper(wrapper);
            $('[role="tooltip"]', $wrapper).remove();
        }
    };

    $v     = new ArticleClass();
    var ie = /(msie|trident)/i.test(navigator.userAgent) ? navigator.userAgent.match(/(msie |rv:)(\d+(.\d+)?)/i)[2] : false;
    if (ie && parseInt(ie) <= 9) {
        $(document).ready(function () {
            $v.onLoad();
            $v.register();
        });
    } else {
        $(window).on('load', function () {
            $v.onLoad();
            $v.register();
        });
    }

    $(window).resize(
        viewport.changed(function(){
            $v.configurator();
        })
    );

    // PLUGIN DEFINITION
    // =================
    $.evo.article = function () {
       return $v;
    };
})(jQuery, document, window, ResponsiveBootstrapToolkit);