/**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 */
(function() {
    'use strict';

    var BasketClass = function(options) {
        this.init(options);
    };

    BasketClass.DEFAULTS = {
        input: {
            id: 'a',
            quantity: 'anzahl'
        },
        selector: {
            list: {
                main: '*[data-toggle="basket-add"]',
                form: 'form.form-basket',
                quantity: 'input.quantity',
                submit: '*[type="submit"]',
                loading: 'io-loading'
            },
            cart: {
                container: '*[data-toggle="basket-items"]'
            }
        }
    };

    BasketClass.prototype = {

        constructor: BasketClass,

        init: function(options) {
            this.options = $.extend({}, BasketClass.DEFAULTS, options);
        },

        addToBasket: function($form, data) {
            var $main = $form;

            if (typeof data === 'undefined') {
                data = $form.serializeObject();
            }

            var productId = parseInt(data[this.options.input.id]);
            var quantity = parseFloat(
                data[this.options.input.quantity]
            );

            if (productId > 0 && quantity > 0) {
                this.pushToBasket($main, productId, quantity, data);
            }
        },

        pushToBasket: function($main, productId, quantity, data) {
            var that = this;

            that.toggleState($main, true);

            $.evo.io().call('pushToBasket', [productId, quantity, data], that, function(error, data) {

                that.toggleState($main, false);

                if (error) {
                    return;
                }

                var response = data.response;
                if (response) {
                    switch (response.nType) {
                        case 0: // error
                            that.error(response);
                            break;
                        case 1: // forwarding
                            that.redirectTo(response);
                            break;
                        case 2: // added to basket
                            that.updateCart();
                            that.pushedToBasket(response);
                            break;
                    }
                }
            });
        },

        toggleState: function($main, loading) {
            var cls = this.options.selector.list.loading;
            if (loading) {
                $main.addClass(cls);
            } else {
                $main.removeClass(cls);
            }
        },

        redirectTo: function(response) {
            window.location.href = response.cLocation;
        },

        error: function(response) {
            var errorlist = '<ul><li>' + response.cHints.join('</li><li>') + '</li></ul>';
            $.evo.extended().showNotify({
                text: errorlist,
                title: response.cLabel
            });
        },

        pushedToBasket: function(response) {
			console.log('ja los gehts');
			if (typeof mainEventListener !== 'undefined' && typeof mainEventListener === 'function') { 
			console.log('ja alles klar');
				window.setTimeout(function(){
					mainEventListener();
					if(sImages)
						sImages.rewatch();
				},500);
			}
        },

        updateCart: function(type) {
            var that = this,
                t = parseInt(type);

            $.evo.io().call('getBasketItems', [t], this, function(error, data) {
                if (error) {
                    return;
                }

                var tpl = data.response.cTemplate;

                $(that.options.selector.cart.container)
                    .empty()
                    .append(tpl);
				if(!$('.lpa-checkout-wrapper').length )
				{
					document.getElementsByClassName('cart-menu')[0].classList.add('open');
					document.body.classList.add('sidecart-open');
				}
            });
        }
    };

    // PLUGIN DEFINITION
    // =================

    $.evo.basket = function() {
        return new BasketClass();
    };

    // PLUGIN DATA-API
    // ===============
    $('#content-wrapper').on('submit', '[data-toggle="basket-add"]', function(event) {
        event.preventDefault();
        $.evo.basket().addToBasket($(this));
    }).on('show.bs.dropdown', '[data-toggle="basket-items"]', function (event) {
        $.evo.basket().updateCart();
    });
})(jQuery);