if (!sImages) {
	var sImages = {};
}
var SnackyImages = function() {};

SnackyImages.prototype = {
		
		iO: false,
		xHeight: false,
		xWidth: false,

        constructor: SnackyImages,
		
		load: function()
		{
			this.xHeight=(window.innerHeight || document.documentElement.clientHeight);
			this.xWidth=(window.innerWidth || document.documentElement.clientWidth);
			this.iO = new IntersectionObserver(function(entries, self) {
			  for(var i=0;i<entries.length;i++){
				if(entries[i].isIntersecting) {
					if(entries[i].target.getAttribute('data-src'))
					{
						sImages.show(entries[i].target);
					}
					self.unobserve(entries[i].target);
				}
			  }
			}, {
			  rootMargin: '0px 0px 50px 0px',
			  threshold: 0
			});
			
			this.add();
		},
		add: function(scope)
		{

			var i,ua=window.navigator.userAgent,ie,mobile,imgs;
			//Falls IE, dann alle aus dem megamenu sofort umwandeln
			if(ua.indexOf('MSIE ') > 0 || ua.indexOf('Trident/') > 0 || ua.indexOf('Edge/') > 0)
				ie = true;
			if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) )
				mobile = true;
			if(ie || mobile)
			{
				var entries = document.querySelectorAll('#cat-w img[data-src]');
				
				for(i=0;i<entries.length;i++)
				{
					if(entries[i].getAttribute('data-src'))
					{
						this.show(entries[i]);
					}
				}
			}

			//Add all Page Images to the IntersectionObserver for lazy loading
			if(!scope) scope = 'body';
			imgs = document.querySelectorAll(scope+' img[data-src], '+scope+' iframe[data-src]');
			if(imgs)
			{
				for(i=0;i<imgs.length;i++){
					this.iO.observe(imgs[i]);
				}
			}
		},
		show: function(el)
		{
			el.src=el.getAttribute('data-src');
			el.removeAttribute('data-src');
		},
		showAll: function(scope)
		{
			if(!scope) return false;
			var entries = document.querySelectorAll(scope+' img');
			for(i=0;i<entries.length;i++)
			{
				if(entries[i].getAttribute('data-src'))
				{
					this.show(entries[i]);
				}
			}
		},
		rewatch: function()
		{

			sImages.iO.disconnect();
			sImages.add();
			
		}
}
sImages = new SnackyImages();
sImages.load();