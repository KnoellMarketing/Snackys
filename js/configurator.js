var configurator;
(function($, document, window){
    'use strict';
    if ($.snacky && !$.snacky.configurator) {
        $.snacky.configurator = {};
    }
    var _stock_info = ['out-of-stock', 'in-short-supply', 'in-stock'],
        ConfiguratorClass = function () {
            this.init();
        };



    ConfiguratorClass.DEFAULTS = {
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

    ConfiguratorClass.prototype = {
        modalShown: false,
        modalView: null,

        constructor: ConfiguratorClass,

        init: function () {
            this.options = ConfiguratorClass.DEFAULTS;
            this.gallery = null;
        },

		load: function() {
			this.registerConfig();
			$('a.filter-collapsible-control').on('click',function(e){
				e.preventDefault();
				$(e.target.getAttribute('href')).toggle();
			});
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


                if (!sidebar.hasClass('affix')) {
                    sidebar.css('width', '');
                }

                sidebar.css('width', sidebar.width());

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
                       // $.evo.error(data);
                        return;
                    }
                    result = data.response;

                    if (!result.oKonfig_arr) {
                        //$.evo.error('Missing configuration groups');
                        return;
                    }

                    // global price
                    nNetto = result.nNettoPreise;
                    that.setPrice(result.fGesamtpreis[nNetto], result.cPreisLocalized[nNetto], result.cPreisString);
                    that.setStockInformation(result.cEstimatedDelivery);

                    $('#content .summary').html(result.cTemplate);

                    //sidebar.affix('checkPosition');

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

                   // $.evo.extended()
                   //     .trigger('priceChanged', result);
                });
            }
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

            //  Bisher kein Content mit einer Beschreibung vorhanden, aber ein Artikel mit Beschreibung ausgewÃ¤hlt
            if (descriptionDropdownContentHidden.length > 0 && descriptionCheckdioContent.length === 0 && itemBeschreibung.length > 0 && multiselect !== "multiple") {
                groupItems.find('a[href="#filter-collapsible_dropdown_' + groupId + '"]').removeClass('hidden');
                descriptionDropdownContent.replaceWith('<div id="filter-collapsible_dropdown_' + groupId + '" class="collapse top10 panel-body">' + itemBeschreibung + '</div>');
                //  Bisher Content mit einer Beschreibung vorhanden, aber ein Artikel ohne Beschreibung ausgewÃ¤hlt
            } else if (descriptionDropdownContentHidden.length === 0 && descriptionCheckdioContent.length === 0 && itemBeschreibung.length === 0 && multiselect !== "multiple") {
                groupItems.find('a[href="#filter-collapsible_dropdown_' + groupId + '"]').addClass('hidden');
                descriptionDropdownContent.addClass('hidden');
                //  Bisher Content mit einer Beschreibung vorhanden und ein Artikel mit Beschreibung ausgewÃ¤hlt
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

           // $.evo.trigger('changed.article.price', { price: price });
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

        setProductNumber: function(productNumber, wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            $('#product-offer span[itemprop="sku"]', $wrapper).html(productNumber);
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
        }

    };


    $.snacky.configurator = new ConfiguratorClass();
	$.snacky.start($.snacky.configurator);
    // PLUGIN DEFINITION
    // =================
    configurator = function () {
       return $v;
    };
})(jQuery, document, window);