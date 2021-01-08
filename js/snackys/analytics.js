/* Universal Analytics */
window.dataLayer = window.dataLayer || [];
var _paq = window._paq || [];

(function () {
    'use strict';

    if (!$.snackyAnalytics) {
        $.snackyAnalytics = {};
    }

    var SnackyAnalyticsClass = function() {};

    SnackyAnalyticsClass.prototype = {
		
        data: { tagmanager: false, matomoUrl: false, matomoSiteId: 1, galleryPreviews: 4, viewtracked: false },


        load: function()
		{
			if(typeof gtagId !== 'undefined')
			{
				this.tagmanager = gtagId;
				this.addTagManager();
			}
			if(typeof matomoUrl !== 'undefined')
			{
				this.matomoUrl = matomoUrl;
				this.matomoSiteId = matomoSiteId;
				this.addMatomo();
			}
			this.addListener();
		},
		
		addMatomo: function() {
			var that = this;
			_paq.push(['disableCookies']);
			_paq.push(['enableLinkTracking']);
			_paq.push(['setTrackerUrl', that.matomoUrl+'matomo.php']);
			_paq.push(['setSiteId', that.matomoSiteId]);
			$.ajax({
				url: that.matomoUrl+"matomo.js",
				dataType: "script",
				async: true
			});
		},
		
		matomoPageView: function() {
			if(this.matomoUrl)
				_paq.push(['trackPageView']);
		},
		
		
		
		addTagManager: function(w, d, s, l, i)
		{
			window.dataLayer.push({
				'gtm.start': new Date().getTime(),
				event: 'gtm.js'
			});
			var that = this;
			$.ajax({
				url: "https://www.googletagmanager.com/gtm.js?id=" + that.tagmanager + "&l=dataLayer",
				dataType: "script",
				async: true
			});

		},

		getElementAttrs: function(el) {
			var attr = new Array();
			for(var i=0; i < el.attributes.length; i++)
				attr.push({name: el.attributes[i].name, value: el.attributes[i].value});
		  return attr;
		},
		
		addListener: function()
		{
			//Events are done by: gtag('event', 'login', {'method': 'Google'});
			var items = document.querySelectorAll('[data-track-event]');
			var that = this;
			var attributes,attrName,finalAttributes,eventName,type;
			for(var i=0;i<items.length;i++)
			{
				type = items[i].getAttribute('data-track-type');
				if(type == 'start')
					that.callEvent(items[i]);
				else if(type != false)
					items[i].addEventListener(type,$.snackyAnalytics.callEventByListener);
			}
			
			//Jetzt Matomo Pageview tracking, alle OnLoad Listener sind durch!
			that.matomoPageView();
		},
		callEventByListener: function(e)
		{
			$.snackyAnalytics.callEvent(this);
		},

		callEvent: function(elem)
		{
			//Via Try da hier ggf. Eingabefehler vorhanden sein können und dann z.B.: json.parse Fehler spuckt
			try {

				//Jetzt die Attribute holen und entsprechend erarbeiten
				var attributes = this.getElementAttrs(elem);
				var finalAttributes = new Object();
				var eventName=false;
				var attrName;
				var vValue;
				for(attrName in attributes)
				{
					if(attributes[attrName].name == 'data-track-event')
						eventName=attributes[attrName].value;
					else if(attributes[attrName].name.substr(0,13) == 'data-track-p-')
					{
						vValue =attributes[attrName].value;
						if(vValue.substr(0,1) == '[')
						{
							vValue = JSON.parse(vValue);
							for(var i in vValue)
							{
								for(var x in vValue[i])
								{
									if(vValue[i][x].substr(0,12) == 'selectorval:')
										vValue[i][x] = document.querySelector(vValue[i][x].substr(12)).value;
									else if(vValue[i][x].substr(0,13) == 'selectorhtml:')
										vValue[i][x] = document.querySelector(vValue[i][x].substr(13)).innerHTML;
								}
							}
						}
						finalAttributes[attributes[attrName].name.substr(13)] = vValue;
					}
				}
				if($.snackyAnalytics.tagmanager)
				{
					var gtmAttributes = new Object();
					switch(eventName)
					{
						case 'view_item_list':
							gtmAttributes['ecommerce'] = new Object;
							gtmAttributes['ecommerce']['currencyCode'] = finalAttributes['currency'];
							gtmAttributes['ecommerce']['impressions'] = finalAttributes['items'];
							break;
						case 'view_item':
							gtmAttributes['ecommerce'] = new Object;
							gtmAttributes['ecommerce']['detail'] = new Object;
							gtmAttributes['ecommerce']['detail']['products'] = finalAttributes['items'];
							break;
						case 'add_to_cart':
							gtmAttributes['ecommerce'] = new Object;
							gtmAttributes['event'] = 'addToCart';
							gtmAttributes['ecommerce']['currencyCode'] = finalAttributes['currency'];
							gtmAttributes['ecommerce']['add'] = new Object;
							gtmAttributes['ecommerce']['add']['products'] = finalAttributes['items'];
							break;
						case 'remove_from_cart':
							gtmAttributes['ecommerce'] = new Object;
							gtmAttributes['event'] = 'removeFromCart';
							gtmAttributes['ecommerce']['currencyCode'] = finalAttributes['currency'];
							gtmAttributes['ecommerce']['remove'] = new Object;
							gtmAttributes['ecommerce']['remove']['products'] = finalAttributes['items'];
							break;
						case 'begin_checkout':
							gtmAttributes['ecommerce'] = new Object;
							gtmAttributes['event'] = 'checkout';
							gtmAttributes['ecommerce']['checkout'] = new Object;
							//gtmAttributes['ecommerce']['checkout']['step'] = 1;
							gtmAttributes['ecommerce']['checkout']['actionField'] = new Object;
							gtmAttributes['ecommerce']['checkout']['actionField']['step'] = 1;
							gtmAttributes['ecommerce']['checkout']['products'] = finalAttributes['items'];
							break;
						case 'checkout_progress':
							gtmAttributes['ecommerce'] = new Object;
							gtmAttributes['event'] = 'checkout';
							gtmAttributes['ecommerce']['checkout'] = new Object;
							//gtmAttributes['ecommerce']['checkout']['step'] = parseInt(finalAttributes['checkout_step']) +1;
							gtmAttributes['ecommerce']['checkout']['actionField'] = new Object;
							gtmAttributes['ecommerce']['checkout']['actionField']['step'] = parseInt(finalAttributes['checkout_step']) +1;
							gtmAttributes['ecommerce']['checkout']['products'] = finalAttributes['items'];
							break;
						case 'purchase':
							gtmAttributes['ecommerce'] = new Object;
							gtmAttributes['ecommerce']['purchase'] = new Object;
							gtmAttributes['ecommerce']['purchase']['products'] = finalAttributes['items'];
							gtmAttributes['ecommerce']['purchase']['actionField'] = new Object;
							gtmAttributes['ecommerce']['purchase']['actionField']['id'] = finalAttributes['transaction_id'];
							gtmAttributes['ecommerce']['purchase']['actionField']['tax'] = finalAttributes['tax'];
							gtmAttributes['ecommerce']['purchase']['actionField']['shipping'] = finalAttributes['shipping'];
							gtmAttributes['ecommerce']['purchase']['actionField']['revenue'] = finalAttributes['value'];
							if(finalAttributes['coupon'])
								gtmAttributes['ecommerce']['purchase']['actionField']['coupon'] = finalAttributes['coupon'];
							break;
						default:
							gtmAttributes = finalAttributes;
							gtmAttributes['event'] = eventName;
					}
					window.dataLayer.push(gtmAttributes);
				}
				
				if($.snackyAnalytics.matomoUrl)
				{
					if(eventName == 'view_item_list')
					{
						if(this.viewtracked !== true)
						{
							//Dont track this twice!
							_paq.push(['setEcommerceView',
								false,
								false,
								finalAttributes['items'][0]['category']
							]);
							this.viewtracked = true;
						}
					} else if(eventName == 'view_item')
					{
						_paq.push(['setEcommerceView',
							finalAttributes['items'][0]['id'],
							finalAttributes['items'][0]['name'],
							finalAttributes['items'][0]['category'],
							finalAttributes['items'][0]['price']
						]);
						this.viewtracked = true;
					} else if(eventName == 'add_to_cart')
					{
						//Cant be implemented now, because matomo needs all products, not just the new one (and we only have the item that is pushed to cart)
					} else if(eventName == 'remove_from_cart')
					{
						//Cant be implemented now, because matomo needs all products, not just the removed one (and we only have the item that is pushed to cart)
					} else if(eventName == 'begin_checkout' || eventName == 'checkout_progress')
					{
						//Add eCommerce Items and use "update Cart", it is only possible here
						for(var i=0;i<finalAttributes.items.length;i++)
						{
							_paq.push(['addEcommerceItem',
								finalAttributes.items[i].id,
								finalAttributes.items[i].name,
								[],
								finalAttributes.items[i].price,
								finalAttributes.items[i].quantity
							]);
						}
						
						_paq.push(['trackEcommerceCartUpdate',finalAttributes.value]);
						this.viewtracked = true;
					} else if(eventName == 'purchase')
					{
						//Track purchase
						for(var i=0;i<finalAttributes.items.length;i++)
						{
							_paq.push(['addEcommerceItem',
								finalAttributes.items[i].id,
								finalAttributes.items[i].name,
								[],
								finalAttributes.items[i].price,
								finalAttributes.items[i].quantity
							]);
						}
						
						_paq.push(['trackEcommerceOrder',
								finalAttributes['transaction_id'],
								finalAttributes['total'],
								finalAttributes['value'],
								finalAttributes['tax'],
								finalAttributes['shipping']
								//,false // (optional) Discount offered
							]);
						this.viewtracked = true;
					}
					else
						console.log('matomo unknown event: '+eventName);
				}
			} catch(e) {
				console.log(e);
			}
		}

	}
    // PLUGIN DEFINITION
    // =================
    $.snackyAnalytics = new SnackyAnalyticsClass();
	$.snackyAnalytics.load();
})(jQuery);
