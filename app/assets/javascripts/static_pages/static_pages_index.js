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
      
      
      //Top right nav bar
      $('.fa-bar-link').on('click', function(e) {
        $(e.target).fadeOut();
        $('#tag-overlay').animate({'left': 0});
      });
      
      $('#tag-overlay').on('click', function(e) {
        $('.fa-bars').fadeIn();
        $('#tag-overlay').animate({'left': '100%'});
      });
      
    },
  }
});
