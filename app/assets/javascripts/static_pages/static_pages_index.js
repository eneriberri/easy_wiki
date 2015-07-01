$(document).ready(function() {

  EASY_WIKI.static_pages.index = {

    init: function() {
      
      //Handle search bar functionality
      submitSearch = function() {
        window.location.href = '/tagged?tag=' + $('#search-box').val();
      }

      $('#search-box').val("")
      $('#search-box').select2(
        {
          tags: true,
          width: "resolve",
          query: function(options) {
            $.ajax({
              type: 'GET',
              url: encodeURI('api/tags/search/' + options.term)
            }).done(function(a) {
              result = [];
              for (var tag in a) {
                result.push({text: a[tag].text, id: a[tag].text})
              }
              options.callback({
                results: result,
                more: false
              })
            })
          }
        });

      $('.search-submit').on('click', submitSearch);

      
      //Create editor and animate its functionality
      var editor = new Pen({editor: document.getElementById('write-post'), stay: false}),
      $writePost = $('#write-post');
      $writePost.one('click', function(e) {
        $writePost.animate({'height': '180px'}, function() {
          $('.new-tag-wrapper').animate({'opacity': '1'});
          $('.new-btn-wrapper').animate({'opacity': '1'});
        });
      });
      
      
      //Top right nav bar animation and functionality
      var $tagOverlay = $('#tag-overlay');
      $('.fa-bar-link').on('click', function(e) {
        $(e.target).fadeOut();
        $tagOverlay.animate({'left': 0});
        $.ajax({
          url: '/api/tags/',
          type: 'GET',
          success: function(res) {
            for(var i = 0, n = res.length; i < n; i++) {
              var tag = res[i]['text'],
              link = '/tagged?tag=' + tag;
              
              $('.tags-overlay-wrapper').append('<a class="overlay-tag" href="'+link+'">'+tag+'</span>');
            } 
          }
        });
      });
      
      $('.fa-times-link').on('click', function(e) {
        $('.fa-bars').fadeIn();
        $tagOverlay.animate({'left': '100%'});
        $('.tags-overlay-wrapper').empty();
      });
      
    },
  }
});
