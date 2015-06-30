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
});