! function() {
    "use strict";
    $.snacky && !$.snacky.list && ($.snacky.list = {});
    var e = function() {};
    e.prototype = {
        data: {
            isLoading: !1,
			endlessObserver: {}
        },
        constructor: e,
        load: function() {
            $(".pagination-ajax").closest(".row").hide(), this.activePrev(), this.activeNext(), this.panelOpener(), this.watchEndless()
        },
        panelOpener: function() {
            var e,t, x = document.getElementById("sidepanel_left"),
                a = this;
			if(x)
			{
				t = x.getElementsByClassName("panel-heading");
				for (e = 0; e < t.length; e++) t[e].onclick = function() {
					this.parentNode.classList.contains("open") ? a.closePanels() : (a.closePanels(), this.parentNode.classList.add("open"))
				};
			}
			if(document.getElementById("filter-toggle"))
				for (document.getElementById("filter-toggle").addEventListener("click", function(e) {
						e.preventDefault(), document.body.classList.contains("show-sidebar") ? document.body.classList.remove("show-sidebar") : document.body.classList.add("show-sidebar")
					}), t = document.querySelectorAll("#sidepanel_left .overlay-bg,#sidepanel_left .close-sidebar"), e = 0; e < t.length; e++) t[e].addEventListener("click", function(e) {
					e.preventDefault(), document.body.classList.remove("show-sidebar")
				})
        },
		rewatchEndless: function()
		{
			$.snacky.list.data.endlessObserver.disconnect();
			$.snacky.list.addToObserver();
			
			//remove all Submit Forms and than readd it, because now there are more!
			$('.form-basket button.sn-addBasket:not(.wkWeiterleiten)').unbind('click');
			$('.form-basket button.sn-addBasket:not(.wkWeiterleiten)').on('click',function(){makeAjaxFormFunc(true,this)});
		},
		watchEndless: function()
		{
			this.data.endlessObserver = new IntersectionObserver(function(entries, self) {
				if(0 == $.snacky.list.data.isLoading)
				{
					for(var i=0;i<entries.length;i++)
					{
						if(entries[i].isIntersecting)
						{
							//Should only fire if its visible!
							if(entries[i].target.id == 'view-next')
							{
								$.snacky.list.data.isLoading = !0;
								var a = $("#view-next").attr("data-url");
								"" != a && "false" != a ? ($("#view-next").parent().addClass("loading"), $.snacky.list.loadArticles(a)) : $("#view-next").remove()
							} else if(entries[i].target.className == 'pagination-url') {
								//Das muss ein Element sein um die URL anzupassen!
								window.history.pushState('endless', window.title, entries[i].target.getAttribute('data-url'));
							} else {
								console.log('observer something crazy?');
							}
						}
					}
				}
			}, {
			  rootMargin: '0px 0px 50px 0px',
			  threshold: 0
			});
			this.addToObserver();
		},
		addToObserver: function(){
			var next = document.getElementById('view-next');
			if(next)
				$.snacky.list.data.endlessObserver.observe(next);
			var elems = document.getElementsByClassName('pagination-url');
			if(elems)
				for(var i=0;i<elems.length;i++)
					$.snacky.list.data.endlessObserver.observe(elems[i]);
					
			//this.loadNextArticles();
			//$(window).on("resize scroll", this.loadNextArticles)
		},
        closePanels: function() {
            for (var e = document.getElementById("sidepanel_left").getElementsByClassName("panel-heading"), t = 0; t < e.length; t++) e[t].parentNode.classList.remove("open")
        },
        loadArticles: function(e, t) {
			var x=e;
            e && "" != e && $.ajax({
                type: "POST",
                url: e,
                data: {
                    isAjax: 1,
                    jsonTemplate: "list",
                    paging: 1 == t ? "prev" : "next"
                },
                cache: !1
            }).done(function(e) {
                1 == t ? ($("#view-prev").attr("data-url", $.trim(e.url)), $("#view-prev").parent().after('<span class="pagination-url" data-url="'+x+'"></span>'+e.html)) : ($("#view-next").attr("data-url", $.trim(e.url)), $("#view-next").parent().before('<span class="pagination-url" data-url="'+x+'"></span>'+e.html)), $.snacky.list.activePrev(), $.snacky.list.activeNext(), $.snacky.list.data.isLoading = !1, $(".endless-scrolling.loading").removeClass("loading"), $.snacky.rewatchImages();
				$.snacky.list.rewatchEndless();
            }).fail(function(e) {
                console.log("error while loading articles")
            })
        },
        activePrev: function() {
            var e = $("#view-prev").attr("data-url");
            "" != e && "false" != e || $("#view-prev").parent().remove(), $("#view-prev").off("click"), $("#view-prev").on("click", function() {
                var e = $(this).attr("data-url");
                "" != e && "false" != e ? ($(this).parent().addClass("loading"), $.snacky.list.loadArticles(e, !0)) : $(this).parent().remove()
            })
        },
        activeNext: function() {
            var e = $("#view-next").attr("data-url");
            "" != e && "false" != e || $("#view-next").parent().remove(), $("#view-next").off("click"), $("#view-next").on("click", function() {
                var e = $(this).attr("data-url");
                "" != e && "false" != e ? ($(this).parent().addClass("loading"), $.snacky.list.loadArticles(e)) : $(this).parent().remove()
            })
        },
        loadNextArticles: function() {
            var e = $("#view-next").parent()[0];
            if (e && 0 == $.snacky.list.data.isLoading) {
                var t = e.getBoundingClientRect();
                if (t.top >= 0 && t.top <= $(window).height()) {
                    $.snacky.list.data.isLoading = !0;
                    var a = $("#view-next").attr("data-url");
                    "" != a && "false" != a ? ($("#view-next").parent().addClass("loading"), $.snacky.list.loadArticles(a)) : $("#view-next").remove()
                }
            }
        }
    }, $.snacky.list = new e, $.snacky.start($.snacky.list)
}(jQuery);