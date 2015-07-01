$(document).ready(function() {

  EASY_WIKI.static_pages.index = {

    init: function() {
      //Handle search bar functionality
      submitSearch = function() {
        window.location.href = '/tagged?tag=' + $('#search-box').val();
      }
      $('#search-box').on('keypress', function(e) {
        if(e.keyCode === 13) {
          submitSearch();
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
    },
  }
});
