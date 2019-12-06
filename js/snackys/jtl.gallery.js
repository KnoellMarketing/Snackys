/**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 */
(function () {
    'use strict';

    var GalleryClass = function (element, options) {
        this.init(element, options);
    };
        
    GalleryClass.DEFAULTS = {
        items: [],
        size: 'md',
        fullscreen: false,
        template: {
            inline: '<div class="image-gallery has-thumbs">' +
            '<ul class="image-container v-wrap carousel vertical slide"></ul>' +
                '<div class="thumbs">' +
                    '<button name="btnGalleryPre" type="button" class="btnGalleryPre slick-up"></button>' +
                    '<div class="thumbs-box">' +
                        '<ul class="image-thumbs carousel vertical"></ul>' +
                    '</div>' +
                    '<button  name="btnGalleryNext" type="button" class="btnGalleryNext stick-down"></button>' +
                '</div>' +
            '</div>',
            fullscreen: '<div class="fullscreen image-gallery has-thumbs">' +
            '<ul class="image-container box-expanded"></ul>' +
            '<ul class="image-thumbs carousel vertical"></ul>' +
            '</div>',
            indicator: '<div class="pswp-indicator nivo-controlNav carousel-indicators bottom17"></div>'
        }
    };

    GalleryClass.prototype = {
        constructor: GalleryClass,
        element: null,
        ident: '_',
        index: 0,
        stack: [],

        init: function(element, options) {
            var items = [];
			
            this.stack   = [];
            this.index   = 0;
            this.element = element;
            this.options =
                $.extend({}, GalleryClass.DEFAULTS, options);


            if (this.options.items.length > 0) {
                items = this.options.items;
            } else {
                $(this.element).find('img').each(function (i, item) {
                    var image = $(item).data('list');
                    items.push(image);
                });
            }

            this.setItems(items);
            this.adjust();  //render at pageload not needed!!
        },
        
        getIdent: function() {
            return this.ident;
        },

        setItems: function(items, scope) {
            var self = this;
            this.ident = scope || this.ident;
            this.clearStack();
            $(items).each(function (i, item) {
                self.getStack().push(item);
            });
        },
		
		lightbox: function(idx){
			if($('body').hasClass('lightbox-shown'))
			{
				this.render();
				$('body').removeClass('lightbox-shown');
			} else {
				this.render(false,true);
				$('body').addClass('lightbox-shown');
			}
			if(idx)
				this.activate(idx);
		},
		
        render: function(scope,big) {
			var self = this,
				container, image, i, item;
				
            this.ident = scope || this.ident;
			
			//Show different imagestack!			
            $(this.element).empty();
			container = $('<div />').addClass('inner');
            for (i = 0; i < self.getStack().length; i++) {
                item = self.getStack()[i];
				image = $('<a />').attr('href',item.lg.src);
				if(i==0) image.addClass('active');
				image.append(
					$('<div />').addClass("img-ct").append(
						$('<img />').attr('src', (big) ? item.lg.src : item.md.src).attr('alt', item.md.alt).attr('data-big',item.lg.src)
					)
                );
				container.append(image)
			}
			
			if(self.getStack().length > 1 && $('body').hasClass('mobile'))
				$(this.element).append(
					$('<div />').attr('id',"gallery-prev").addClass("sl-ar sl-pr").append(
						$('<div />').addClass("ar ar-l")
					)
				);
			$(this.element).append(container);
			if(self.getStack().length > 1 && $('body').hasClass('mobile'))
				$(this.element).append(
					$('<div />').attr('id',"gallery-next").addClass("sl-ar sl-nx").append(
						$('<div />').addClass("ar ar-r")
					)
				);
			
			
			if(self.getStack().length > 1 && !$('body').hasClass('mobile') && $('#gallery-thumbs').length > 0)
			{
				var thumb;
				$('#gallery-thumbs').empty();
				for (i = 0; i < self.getStack().length; i++) {
					item = self.getStack()[i];
					thumb = $('<div />').addClass('img-w');
					if(i==0) thumb.addClass('active');
					thumb.append(
						$('<div />').addClass('img-ct').append(
							$('<img />').attr('src', item.sm.src).attr('alt', item.sm.alt)
						)
					);
					$('#gallery-thumbs').append(thumb);
					image = $('<a />').attr('href',item.lg.src).append(
						$('<div />').addClass("img-ct").append(
							$('<img />').attr('src', item.md.src).attr('alt', item.md.alt)
						)
					);
					container.append(image)
				}
				
			}
			
			
			self.adjust();
        },

        scrollTo: function(step) {
			self.activate(step);
        },
        
        showThumbs: function(show) {
        },
		zoom: function(e){
		},
        adjust: function() {
			var self = this,
				i = 0;
				
			$('#gallery-prev,#gallery-next,#gallery-thumbs>div,#gallery').unbind();
			$('#gallery-prev').on('click',function(){self.prev()});
			$('#gallery-next').on('click',function(){self.next()});
			$('#gallery-thumbs>div').each(function()
			{
				$(this).on('click',function(){
					self.activate($(this).index('#gallery-thumbs>div'));
				});
				i++;
			});
			
				
			if(!$('body').hasClass('mobile'))
			{
				//mouseover des hauptbildes
				$('#gallery a').each(function(){
					var that = this;
					$(that).zoom({
						url: $(that).find('img').attr('data-big'),
						touch: false
					});
				});
				$('#gallery a').on('click',function(e){e.preventDefault(); e.stopPropagation(); self.lightbox(self.index)});
			}
			else
			{
				$('#gallery a').on('click',function(e){e.preventDefault(); e.stopPropagation();});
				swiper.init(document.getElementById('gallery'),function(e){
					if(e && e.direction)
					{
						if(e.direction == "right")
							self.prev();
						else if(e.direction == "left")
							self.next();
					}
				});
			}
			
			
			$('#close-lightbox').on('click',function(){$('body').removeClass('lightbox-shown');});
			
        },
        
        calcHeights: function() {
        },

        setMaxHeight: function(height, thumb_height) {
        },

        resetMaxHeight: function () {
        },

        itemCount: function() {
            return this.getStack().length;
        },

        clearStack: function(scope) {
            var s = scope || this.ident;
            if (typeof this.stack[s] !== 'undefined') {
                this.stack[s] = [];
            }
        },

        getStack: function(scope) {
            var s = scope || this.ident;
            if (typeof this.stack[s] === 'undefined') {
                this.stack[s] = [];
            }
            return this.stack[s];
        },

        getStacks: function() {
            return this.stack;
        },

        activate: function(index) {
            $(this.element).find('.inner>a').each(function (index, item) {
                $(item).removeClass('active');
            });

            $(this.element).find('.inner>a:eq(' + index + ')')
                .addClass('active');

			if($('#gallery-thumbs').length > 0)
			{
				$('#gallery-thumbs>div').removeClass('active');
				$('#gallery-thumbs>div:eq(' + index + ')').addClass('active');
			}
            this.index = index;
        },

        next: function() {
            var idx = (this.index + 1) >= this.itemCount() ? 0 : this.index + 1;
            this.activate(idx);
        },

        prev: function() {
            var idx = (this.index - 1) < 0 ? this.itemCount() - 1 : this.index - 1;
            this.activate(idx);
        }
    };

    // PLUGIN DEFINITION
    // =================

    $.fn.gallery = function(option) {
        if (this.length === 0) {
            return this;
        } else if (this.length > 1) {
            this.each(function () {
                $(this).gallery(option);
            });
            return this;
        }

        return new GalleryClass(this, option);
    };

})(jQuery);
