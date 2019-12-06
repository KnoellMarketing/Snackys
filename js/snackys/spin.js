var Spinner = function() {};
Spinner.prototype = {
	constructor: Spinner,
	spin: function(){
		$('body').addClass('loading');
		return this;
	},
	stop: function(){
		$('body').removeClass('loading');
	}
}
