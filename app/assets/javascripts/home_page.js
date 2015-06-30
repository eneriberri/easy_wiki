$(document).ready(function() {
  
  var submitSearch = function() {
    window.location.href = '/tagged?tag=' + $('#search-box').val();
  }
  
  $('#search-box').on('keypress', function(e) {
    if(e.keyCode === 13) {
      submitSearch();
    }
  });
  
  $('.search-submit').on('click', submitSearch);
  
  var editor = new Pen({editor: document.getElementById('write-post'), stay: false});
  
  $('#write-post').on('click', function(e) {
    $(e.target).animate({'height': '130px'});
  });
});