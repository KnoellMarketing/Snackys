! function() {
    "use strict";
    !$.snackyList && ($.snackyList = {});
    var e = function() {};
    e.prototype = {
        data: {
            isLoading: !1,
			endlessObserver: {}
        },
        constructor: e,
        load: function() {
            $(".pagination-ajax").closest(".row").hide(), this.activePrev(), this.activeNext(),  this.watchEndless()	// this.panelOpener(),
        },
        panelOpener: function() { /* deprecated */ },
        closePanels: function() { /* deprecated */ },
		rewatchEndless: function()
		{
			$.snackyList.data.endlessObserver.disconnect();
			$.snackyList.addToObserver();
		},
		watchEndless: function()
		{
			this.data.endlessObserver = new IntersectionObserver(function(entries, self) {
				if(0 == $.snackyList.data.isLoading)
				{
					for(var i=0;i<entries.length;i++)
					{
						if(entries[i].isIntersecting)
						{
							if(entries[i].target.id == 'view-next')
							{
								$.snackyList.data.isLoading = !0;
								var a = $("#view-next").attr("data-url");
								"" != a && "false" != a ? ($("#view-next").parent().addClass("loading"), $.snackyList.loadArticles(a)) : $("#view-next").remove()
							} else if(entries[i].target.className == 'pagination-url') {
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
				$.snackyList.data.endlessObserver.observe(next);
			var elems = document.getElementsByClassName('pagination-url');
			if(elems)
				for(var i=0;i<elems.length;i++)
					$.snackyList.data.endlessObserver.observe(elems[i]);
					
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
                1 == t ? ($("#view-prev").attr("data-url", $.trim(e.url)), $("#view-prev").parent().after('<span class="pagination-url" data-url="'+x+'"></span>'+e.html)) : ($("#view-next").attr("data-url", $.trim(e.url)), $("#view-next").parent().before('<span class="pagination-url" data-url="'+x+'"></span>'+e.html)), $.snackyList.activePrev(), $.snackyList.activeNext(), $.snackyList.data.isLoading = !1, $(".endless-scrolling.loading").removeClass("loading"); 
				if(sImages) sImages.rewatch();
				$.snackyList.rewatchEndless();
				if (typeof $.evo.article === 'function') {
					$.evo.article().onLoad();
					$.evo.article().register();
					addValidationListener();
				}
            }).fail(function(e) {
                console.log("error while loading articles")
            })
        },
        activePrev: function() {
            var e = $("#view-prev").attr("data-url");
            "" != e && "false" != e || $("#view-prev").parent().remove(), $("#view-prev").off("click"), $("#view-prev").on("click", function() {
                var e = $(this).attr("data-url");
                "" != e && "false" != e ? ($(this).parent().addClass("loading"), $.snackyList.loadArticles(e, !0)) : $(this).parent().remove()
            })
        },
        activeNext: function() {
            var e = $("#view-next").attr("data-url");
            "" != e && "false" != e || $("#view-next").parent().remove(), $("#view-next").off("click"), $("#view-next").on("click", function() {
                var e = $(this).attr("data-url");
                "" != e && "false" != e ? ($(this).parent().addClass("loading"), $.snackyList.loadArticles(e)) : $(this).parent().remove()
            })
        },
        loadNextArticles: function() {
            var e = $("#view-next").parent()[0];
            if (e && 0 == $.snackyList.data.isLoading) {
                var t = e.getBoundingClientRect();
                if (t.top >= 0 && t.top <= $(window).height()) {
                    $.snackyList.data.isLoading = !0;
                    var a = $("#view-next").attr("data-url");
                    "" != a && "false" != a ? ($("#view-next").parent().addClass("loading"), $.snackyList.loadArticles(a)) : $("#view-next").remove()
                }
            }
        }
    }, $.snackyList = new e, $.snackyList.load();
}(jQuery);