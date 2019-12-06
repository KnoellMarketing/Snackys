/**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 */
 
;(function($) {
	var response = null,
	request = function() {
		if (response != null)
			return;

		var self = this;
	    IO.call('billpayRates', [], self, function(error, data) {
	      if (error) {
	      	console.error(data);
	      	return; // error handling
	      }
	      else {
	      	handle(self.response);
	      }
		});
	},
 
	handle = function(res) {
		response = res;
		if (response.nType != 2)
		{
			show('error');
			return;
		}
		push();
	},
 
	push = function() {
		var rate = response.nRates_arr[0];
		if ($('select[name="billpay_rate"]').length)
			rate = $('select[name="billpay_rate"]').val();
 
		var html = response.cRateHTML_arr[rate];
		show(html);
	},
 
	show = function(text) {
		$('#billpay_rate_wrapper').html(text);
	},
 
	set_popup = function() {
		$("a.billpay_accepted").fancybox({
			'type' : 'iframe',
			'href' : 'http://www.billpay.de/api/agb',
			'transitionIn' : 'fade',
			'transitionOut' : 'fade',
			'autoScale' : false,
			'width' : 620,
			'height' : 600,
			'showCloseButton' : false,
			'titleShow' : true,
			'titlePosition' : 'inside',
			'titleFormat' : function() {
				return '<a href="javascript:$.fancybox.close();">Fenster schlie\xDFen</a>';
			}
		});
	},

	init = function() {
		//set_popup();
		$('input[name=billpay_paymenttype]').each(function(idx, item) {
			$(this).click(function() {

				if ($(this).val() == 1 || $(this).val() == 2)
					$('#billpay_agb_def').slideDown();
				else
					$('#billpay_agb_def').slideUp();

				if ($(this).val() == 2 || $(this).val() == 3)
				{
					if ($(this).val() == 3)
					{
						$('#billpay_sepa_rate').show();
						$('#billpay_sepa_debit').hide();
						$('#rate_selection').slideDown('fast', function() {
							request();
						});
					}
					else
					{
						$('#billpay_sepa_rate').hide();
						$('#billpay_sepa_debit').show();
						$('#rate_selection').slideUp();
					}

					$('#billpay_sepa').slideDown();
					$('#account_information').slideDown();
					$('#invoicebusiness_information').slideUp();
					$('#invoicebusiness_b2b').slideUp();
					$('#invoicebusiness_b2c').slideDown();
 				}
 				else
				{
					$('#billpay_sepa').slideUp();
					$('#rate_selection').slideUp();
					$('#account_information').slideUp();
					$('#invoicebusiness_information').slideDown();
					$('#invoicebusiness_b2b').slideUp();
					$('#invoicebusiness_b2c').slideDown();
					$('#billpay_b2b_no').attr('checked', true);
					$('#billpay_b2b_yes').attr('checked', false);
				}
			});
		});
      
      $('input[name=billpay_b2b]').each(function(idx, item) {
         $(this).click(function() {
            if ($(this).val() == 1)
            {
               $('#invoicebusiness_b2b').slideDown();
               $('#invoicebusiness_b2c').slideUp();
            }
            else
            {
               $('#invoicebusiness_b2b').slideUp();
               $('#invoicebusiness_b2c').slideDown();
            }
         });
      });
	};
 
	$.billpay = function() {
		init();
	};
 
	$.billpay.req = function() {
		request();
	};

	$.billpay.push = function() {
		push();
	};

	$(document).ready(function() {
		$.billpay();
	});

})(jQuery);
