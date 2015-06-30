$(document).ready(function() {

  EASY_WIKI.static_pages.index = {

    init: function() {
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
        $writePost.animate({'height': '130px'}, function() {
          var newTags = '<span class="new-tag-wrapper">'+
                        '<i class="fa fa-tags"></i><input type="text" class="new-tags" placeholder="Enter tags here">'+
                        '</span>';
          $writePost.after(newTags);
          $('.new-tag-wrapper').fadeIn();
        });
      });
    },
  }
});
