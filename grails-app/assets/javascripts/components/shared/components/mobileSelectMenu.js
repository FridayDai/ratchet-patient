require("jquery-ui-selectmenu");
var Utility = require('../../../utils/Utility');

function MobileSelectMenu() {

    this.after('initialize', function () {
        $.widget( "ui.selectmenu", $.ui.selectmenu, {
            _create: function() {
                this._super();
                var that = this;
                this.document.on('mobileSelectSuccess', function(event, data) {
                    if(that.ids.element  === data.id) {
                        that.element[0].selectedIndex = +data.index;
                        that._setText( that.buttonText, data.label );
                        that._trigger( "select", event);
                    }
                });
            },
            _drawButton: function() {
                this._super();
                var text = this.options.defaultButtonText;
                if(text) {
                    this._setText( this.buttonText, text );
                }
            },
            _buttonEvents: {

                // Prevent text selection from being reset when interacting with the selectmenu (#10144)
                mousedown: function() {
                    var selection;

                    if ( window.getSelection ) {
                        selection = window.getSelection();
                        if ( selection.rangeCount ) {
                            this.range = selection.getRangeAt( 0 );
                        }

                        // support: IE8
                    } else {
                        this.range = document.selection.createRange();
                    }
                },

                click: function( event ) {
                    if(Utility.isMobile()) {
                        this.element.trigger("showMobileNumberDialog", {id: this.ids.element});
                        this.close(event);
                    } else {
                        this._setSelection();
                        this._toggle( event );
                    }
                },

                keydown: function( event ) {
                    var preventDefault = true;
                    switch ( event.keyCode ) {
                        case $.ui.keyCode.TAB:
                        case $.ui.keyCode.ESCAPE:
                            this.close( event );
                            preventDefault = false;
                            break;
                        case $.ui.keyCode.ENTER:
                            if ( this.isOpen ) {
                                this._selectFocusedItem( event );
                            }
                            break;
                        case $.ui.keyCode.UP:
                            if ( event.altKey ) {
                                this._toggle( event );
                            } else {
                                this._move( "prev", event );
                            }
                            break;
                        case $.ui.keyCode.DOWN:
                            if ( event.altKey ) {
                                this._toggle( event );
                            } else {
                                this._move( "next", event );
                            }
                            break;
                        case $.ui.keyCode.SPACE:
                            if ( this.isOpen ) {
                                this._selectFocusedItem( event );
                            } else {
                                this._toggle( event );
                            }
                            break;
                        case $.ui.keyCode.LEFT:
                            this._move( "prev", event );
                            break;
                        case $.ui.keyCode.RIGHT:
                            this._move( "next", event );
                            break;
                        case $.ui.keyCode.HOME:
                        case $.ui.keyCode.PAGE_UP:
                            this._move( "first", event );
                            break;
                        case $.ui.keyCode.END:
                        case $.ui.keyCode.PAGE_DOWN:
                            this._move( "last", event );
                            break;
                        default:
                            this.menu.trigger( event );
                            preventDefault = false;
                    }

                    if ( preventDefault ) {
                        event.preventDefault();
                    }
                }
            }
        });
    });


}

module.exports = MobileSelectMenu;
