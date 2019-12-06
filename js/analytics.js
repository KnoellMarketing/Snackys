/* Universal Analytics */
window.dataLayer = window.dataLayer || [];
window.dataLayerGTM = window.dataLayerGTM || [];
function gtag(){dataLayer.push(arguments);}

(function () {
    'use strict';

    if ($.snacky && !$.snacky.analytics) {
        $.snacky.analytics = {};
    }

    var SnackyAnalyticsClass = function() {};

    SnackyAnalyticsClass.prototype = {
		
        data: { tagmanager: false, analyticsId: false, galleryPreviews: 4 },


        load: function()
		{
			this.addListener();
			if($.snacky.data.config.analytics)
			{
				this.setId($.snacky.data.config.analytics);
				this.loadLib();
				this.basics();
			}
			if($.snacky.data.config.tagmanager)
			{
				this.tagmanager = $.snacky.data.config.tagmanager;
				this.addTagManager();
			}
		},
		
		addTagManager: function(w, d, s, l, i)
		{
			window.dataLayerGTM.push({
				'gtm.start': new Date().getTime(),
				event: 'gtm.js'
			});
			var that = this;
			$.ajax({
				url: "https://www.googletagmanager.com/gtm.js?id=" + that.tagmanager + "&l=dataLayerGTM",
				dataType: "script",
				async: true
			});

		},

		setId: function(id)
		{
			this.analyticsId = id;
		},

		loadLib: function()
		{
			var that = this;
			$.ajax({
				url: "https://www.googletagmanager.com/gtag/js?id=" + that.analyticsId,
				dataType: "script",
				async: true
			});
		},

		basics: function()
		{
			gtag('config', this.analyticsId);
			if($.snacky.data.config.analytics2)
				gtag('config', $.snacky.data.config.analytics2);
			if($.snacky.data.config.analytics3)
				gtag('config', $.snacky.data.config.analytics3);
			if($.snacky.data.config.analytics4)
				gtag('config', $.snacky.data.config.analytics4);
			if($.snacky.data.config.analytics5)
				gtag('config', $.snacky.data.config.analytics5);
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
			var items = document.querySelectorAll('[gtag-event]');
			var that = this;
			var attributes,attrName,finalAttributes,eventName,type;
			for(var i=0;i<items.length;i++)
			{
				type = items[i].getAttribute('gtag-type');
				if(type == 'start')
					that.callEvent(items[i]);
				else if(type != false)
					items[i].addEventListener(type,$.snacky.analytics.callEventByListener);
			}
		},
		callEventByListener: function(e)
		{
			$.snacky.analytics.callEvent(this);
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
					if(attributes[attrName].name == 'gtag-event')
						eventName=attributes[attrName].value;
					else if(attributes[attrName].name.substr(0,7) == 'gtag-p-')
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
						finalAttributes[attributes[attrName].name.substr(7)] = vValue;
					}
				}
				if($.snacky.data.config.analytics)
					gtag('event',eventName,finalAttributes);
				if($.snacky.data.config.tagmanager)
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
							gtmAttributes['ecommerce']['removeFromCart'] = new Object;
							gtmAttributes['ecommerce']['removeFromCart']['products'] = finalAttributes['items'];
							break;
						case 'begin_checkout':
							gtmAttributes['ecommerce'] = new Object;
							gtmAttributes['event'] = 'checkout';
							gtmAttributes['ecommerce']['checkout'] = new Object;
							gtmAttributes['ecommerce']['checkout']['step'] = 1;
							//gtmAttributes['ecommerce']['checkout']['actionField'] = new Object;
							//gtmAttributes['ecommerce']['checkout']['actionField']['step'] = 1;
							gtmAttributes['ecommerce']['checkout']['products'] = finalAttributes['items'];
							break;
						case 'checkout_progress':
							gtmAttributes['ecommerce'] = new Object;
							gtmAttributes['event'] = 'checkout';
							gtmAttributes['ecommerce']['checkout'] = new Object;
							gtmAttributes['ecommerce']['checkout']['step'] = parseInt(finalAttributes['checkout_step']) +1;
							//gtmAttributes['ecommerce']['checkout']['actionField'] = new Object;
							//gtmAttributes['ecommerce']['checkout']['actionField']['step'] = parseInt(finalAttributes['checkout_step']) +1;
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
						default:
							gtmAttributes = finalAttributes;
							gtmAttributes['event'] = eventName;
					}
					//console.log(finalAttributes);
					//console.log(gtmAttributes);
					window.dataLayerGTM.push(gtmAttributes);
				}
			} catch(e) {
				console.log(e);
			}
		}

	}
    // PLUGIN DEFINITION
    // =================
    $.snacky.analytics = new SnackyAnalyticsClass();
	$.snacky.start($.snacky.analytics);
})(jQuery);
