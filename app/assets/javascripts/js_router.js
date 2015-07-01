Page = null;

// our global object for page-specific javascript
EASY_WIKI = {

};

// handle setting the Page object and initializing javascript for the page we loaded
UTIL = {
  exec: function( controller, action ) {
    var ns = EASY_WIKI,
        action = ( action === undefined ) ? "init" : action;
    if (controller !== "" && ns[controller]) {
      if (typeof ns[controller][action] == "object" ) {
        Page = ns[controller][action];
        if (typeof Page.init === "function") {
          Page.init();
        }
      } else if (typeof ns[controller][action] == "function") {
        debugger;
        ns[controller][action]();
      }
    }
  },

  init: function() {
    var body = document.body,
        controller = body.getAttribute( "data-controller" ),
        action = body.getAttribute( "data-action" );

    UTIL.exec( controller );
    UTIL.exec( controller, action );
  }
};

$( document ).ready( UTIL.init );
$( document ).on('page:load', UTIL.init);
