(function () {
    'use strict';

    if ($.snacky && !$.snacky.checkout) {
        $.snacky.checkout = {};
    }

    var SnackyCheckoutClass = function() {};

    SnackyCheckoutClass.prototype = {
		
        data: { isLoading: false, galleryPreviews: 4 },

        constructor: SnackyCheckoutClass,
		
        load: function()
		{
			this.adressForm();
			this.versand();
			this.basics();
			this.checkPayPalPlus();
		},
		
		basics: function()
		{
			$('input[type=submit],button[type=submit]').on('click',function(){
				var submit = this;
				$(submit).closest("form").find('input:hidden, select:hidden').each(function(){
					$(this).removeAttr('required');
				});
			});
			
			$('#comment').on('change',function(){
				$('#comment-hidden').val($(this).val());
			});
		},
		
		adressForm: function()
		{
			this.observePLZ('#postcode','#city','#country');
			this.observePLZ('#register-shipping_address-postcode','#register-shipping_address-city','#register-shipping_address-country');
			$('#checkout_register_shipping_address').on('change',function(){
				if(this.checked)
					$('#select_shipping_address').hide();
				else
					$('#select_shipping_address').show();
			});
			$('#checkout_create_account_unreg').on('change',function(){
				if(this.checked)
					$('#create_account_data').show();
				else
					$('#create_account_data').hide();
			});

			$('input[name=kLieferadresse]').on('change',function(){
				if($(this).val() > 0)
					$('#register_shipping_address').hide();
				else
					$('#register_shipping_address').show();
			});
			

			$( "#choose-way .step-box" ).click(function() {
			  $('#choose-way .step-box').removeClass( "active" );
			  $(this).addClass( "active" );
			  if($(this).hasClass('login'))
			  {
				  $('#existing-customer').removeClass( "hidden" );
				  $('#customer').addClass( "hidden" );
			  } else {
				  $('#existing-customer').addClass( "hidden" );
				  $('#customer').removeClass( "hidden" );
			  }
			  if($(this).hasClass('reg'))
			  {
				$( "#checkout_create_account_unreg" ).prop( "checked", true );
				$('#create_account_data').show();
			  } else if($(this).hasClass('guest')) {
				$( "#checkout_create_account_unreg" ).prop( "checked", false );
				$('#create_account_data').hide();
			  }
			});
			
			//checking wether there is an invalid invoice adresse (non-deliverable country)
			$('#country').on('change',function(){
				if(document.getElementById('register-shipping_address-country'))
				{
					if(document.getElementById('register-shipping_address-country').querySelector('[value="' + $(this).val() + '"]') == null)
					{
						$('#checkout_register_shipping_address_div').addClass('hidden');
						$('#select_shipping_address').show();
						$('#checkout_register_shipping_address').prop( "checked", false );
					} else {
						$('#checkout_register_shipping_address_div').removeClass('hidden');
					}
				}
			});
		},
		
		observePLZ: function(plz,city,land)
		{
			$(plz).on('change',function(){
				if($(city).val() == '')
				{
					//only if it is empty!
					$.ajax({
						url: 'io.php',
						data: {'io': JSON.stringify({'name': 'getCitiesByZip', 'params': ["",$(land).val(),$(plz).val()]})}
					}).done(function(data)
					{
						//if there is exactly 1 city and the city field still empty, directly paste it inside
						if($(data).length==1 && $(city).val() == '')
							$(city).val(data[0]);
					});
				}
			});
		},
		
		versand: function()
		{
			var that = this;
			$('input[name=Versandart]').on('change',function()
			{
				$('body').addClass('loading');

				$.ajax({
					url: 'bestellvorgang.php?isAjax&kVersandart='+$(this).val()
				}).done(function(data) {
					$('body').removeClass('loading');
					var e = $.parseHTML(data, document, true);
					payments = $(e).find('#fieldset-payment').html();
					$('#fieldset-payment').html(payments);
					that.checkPayPalPlus();
				}).fail(function(){
					$('body').removeClass('loading');
					console.log('Error loading '+url);
				});
			});
		},

		checkPayPalPlus: function()
		{
			if($('#ppp-modal').length)
			{
				var first = true;
				$('.shipping-payments .btn-primary.submit').each(function()
				{
					if(first) first = false;
					else
						$(this).hide();
				});
			} else
			$('.shipping-payments .btn-primary.submit').show();
		}
			
	}
    // PLUGIN DEFINITION
    // =================
    $.snacky.checkout = new SnackyCheckoutClass();
	$.snacky.start($.snacky.checkout);
})(jQuery);


/* ehemals modal.min.js */
!function(o){"object"==typeof module&&"object"==typeof module.exports?o(require("jquery"),window,document):o(jQuery,window,document)}(function(o,t,i,e){var s=[],l=function(){return s.length?s[s.length-1]:null},n=function(){var o,t=!1;for(o=s.length-1;o>=0;o--)s[o].$blocker&&(s[o].$blocker.toggleClass("current",!t).toggleClass("behind",t),t=!0)};o.modal=function(t,i){var e,n;if(this.$body=o("body"),this.options=o.extend({},o.modal.defaults,i),this.options.doFade=!isNaN(parseInt(this.options.fadeDuration,10)),this.$blocker=null,this.options.closeExisting)for(;o.modal.isActive();)o.modal.close();if(s.push(this),t.is("a"))if(n=t.attr("href"),this.anchor=t,/^#/.test(n)){if(this.$elm=o(n),1!==this.$elm.length)return null;this.$body.append(this.$elm),this.open()}else this.$elm=o("<div>"),this.$body.append(this.$elm),e=function(o,t){t.elm.remove()},this.showSpinner(),t.trigger(o.modal.AJAX_SEND),o.get(n).done(function(i){if(o.modal.isActive()){t.trigger(o.modal.AJAX_SUCCESS);var s=l();s.$elm.empty().append(i).on(o.modal.CLOSE,e),s.hideSpinner(),s.open(),t.trigger(o.modal.AJAX_COMPLETE)}}).fail(function(){t.trigger(o.modal.AJAX_FAIL);var i=l();i.hideSpinner(),s.pop(),t.trigger(o.modal.AJAX_COMPLETE)});else this.$elm=t,this.anchor=t,this.$body.append(this.$elm),this.open()},o.modal.prototype={constructor:o.modal,open:function(){var t=this;this.block(),this.anchor.blur(),this.options.doFade?setTimeout(function(){t.show()},this.options.fadeDuration*this.options.fadeDelay):this.show(),o(i).off("keydown.modal").on("keydown.modal",function(o){var t=l();27===o.which&&t.options.escapeClose&&t.close()}),this.options.clickClose&&this.$blocker.click(function(t){t.target===this&&o.modal.close()})},close:function(){s.pop(),this.unblock(),this.hide(),o.modal.isActive()||o(i).off("keydown.modal")},block:function(){this.$elm.trigger(o.modal.BEFORE_BLOCK,[this._ctx()]),this.$body.css("overflow","hidden"),this.$blocker=o('<div class="'+this.options.blockerClass+' blocker current"></div>').appendTo(this.$body),n(),this.options.doFade&&this.$blocker.css("opacity",0).animate({opacity:1},this.options.fadeDuration),this.$elm.trigger(o.modal.BLOCK,[this._ctx()])},unblock:function(t){!t&&this.options.doFade?this.$blocker.fadeOut(this.options.fadeDuration,this.unblock.bind(this,!0)):(this.$blocker.children().appendTo(this.$body),this.$blocker.remove(),this.$blocker=null,n(),o.modal.isActive()||this.$body.css("overflow",""))},show:function(){this.$elm.trigger(o.modal.BEFORE_OPEN,[this._ctx()]),this.options.showClose&&(this.closeButton=o('<a href="#close-modal" rel="modal:close" class="close-modal '+this.options.closeClass+'">'+this.options.closeText+"</a>"),this.$elm.append(this.closeButton)),this.$elm.addClass(this.options.modalClass).appendTo(this.$blocker),this.options.doFade?this.$elm.css({opacity:0,display:"inline-block"}).animate({opacity:1},this.options.fadeDuration):this.$elm.css("display","inline-block"),this.$elm.trigger(o.modal.OPEN,[this._ctx()])},hide:function(){this.$elm.trigger(o.modal.BEFORE_CLOSE,[this._ctx()]),this.closeButton&&this.closeButton.remove();var t=this;this.options.doFade?this.$elm.fadeOut(this.options.fadeDuration,function(){t.$elm.trigger(o.modal.AFTER_CLOSE,[t._ctx()])}):this.$elm.hide(0,function(){t.$elm.trigger(o.modal.AFTER_CLOSE,[t._ctx()])}),this.$elm.trigger(o.modal.CLOSE,[this._ctx()])},showSpinner:function(){this.options.showSpinner&&(this.spinner=this.spinner||o('<div class="'+this.options.modalClass+'-spinner"></div>').append(this.options.spinnerHtml),this.$body.append(this.spinner),this.spinner.show())},hideSpinner:function(){this.spinner&&this.spinner.remove()},_ctx:function(){return{elm:this.$elm,$elm:this.$elm,$blocker:this.$blocker,options:this.options}}},o.modal.close=function(t){if(o.modal.isActive()){t&&t.preventDefault();var i=l();return i.close(),i.$elm}},o.modal.isActive=function(){return s.length>0},o.modal.getCurrent=l,o.modal.defaults={closeExisting:!0,escapeClose:!0,clickClose:!0,closeText:"Close",closeClass:"",modalClass:"modal",blockerClass:"jquery-modal",spinnerHtml:'<div class="rect1"></div><div class="rect2"></div><div class="rect3"></div><div class="rect4"></div>',showSpinner:!0,showClose:!0,fadeDuration:null,fadeDelay:1},o.modal.BEFORE_BLOCK="modal:before-block",o.modal.BLOCK="modal:block",o.modal.BEFORE_OPEN="modal:before-open",o.modal.OPEN="modal:open",o.modal.BEFORE_CLOSE="modal:before-close",o.modal.CLOSE="modal:close",o.modal.AFTER_CLOSE="modal:after-close",o.modal.AJAX_SEND="modal:ajax:send",o.modal.AJAX_SUCCESS="modal:ajax:success",o.modal.AJAX_FAIL="modal:ajax:fail",o.modal.AJAX_COMPLETE="modal:ajax:complete",o.fn.modal=function(t){return 1===this.length&&new o.modal(this,t),this},o(i).on("click.modal",'a[rel~="modal:close"]',o.modal.close),o(i).on("click.modal",'a[rel~="modal:open"]',function(t){t.preventDefault(),o(this).modal()})});