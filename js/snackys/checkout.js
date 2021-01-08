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
			//this.versand();
			this.basics();
			//this.checkPayPalPlus();
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
			var payments,sidebasket;
				alert("intitialisiere");
			$('input[name=Versandart]').on('change',function()
			{
				alert("nun aendere");
				$('body').addClass('loading');

				$.ajax({
					url: 'bestellvorgang.php?isAjax&kVersandart='+$(this).val()
				}).done(function(data) {
					alert("geladen");
					$('body').removeClass('loading');
					var e = $.parseHTML(data, document, true);
					payments = $(e).find('#fieldset-payment').html();
					$('#fieldset-payment').html(payments);
					if($(e).find('#checkout-cart-ajaxversand').length > 0)
					{
						sidebasket = $(e).find('#checkout-cart').html();
						$('#checkout-cart').html(sidebasket);
					}
					alert("ist das so");
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
    $.snackyCheckout = new SnackyCheckoutClass();
	$.snackyCheckout.load();
})(jQuery);