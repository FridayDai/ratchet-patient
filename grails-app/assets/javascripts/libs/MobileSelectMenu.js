require("jquery-ui-selectmenu");

var Utility = require('../utils/Utility');
var DEFAULT_TEXT_WRAP = '<span class="select-menu-default-text"></span>';

$.widget( "ui.selectmenu", $.ui.selectmenu, {
    _create: function() {
        this._super();
        var that = this;
        this.document.on('mobileSelectSuccess', function(event, data) {
            if(that.ids.element  === data.id) {
                that.element.data('isDefault', false);
                that.element[0].selectedIndex = +data.index;
                that._setText( that.buttonText, data.label );
                that._trigger( "select", event, {item: {value: data.label}});
            }
        });
    },
    _drawButton: function() {
        this._super();
        var text = '';

        if (Utility.isMobile()) {
            text = this.element.data('defaultTextMobile') ||
                this.element.data('defaultText') ||
                this.options.defaultButtonText;
        } else {
            text = this.element.data('defaultText') || this.options.defaultButtonText;
        }

        var hasSelected  = this.element.find('option').filter('[selected]').length !== 0;

        if (hasSelected) {
            this.element.data('isDefault', false);
        } else {
            this.element.data('isDefault', true);
        }

        if(text && !hasSelected) {
            this.element[0].selectedIndex = -1;
            this.buttonText.html($(DEFAULT_TEXT_WRAP).html(text));
        }
    },
    _select: function( item, event ) {
        var oldIndex = this.element[ 0 ].selectedIndex;

        // Change native select element
        this.element[ 0 ].selectedIndex = item.index;
        this._setText( this.buttonText, item.label );
        this._setAria( item );
        this.element.data('isDefault', false);
        this._trigger( "select", event, { item: item } );

        if ( item.index !== oldIndex ) {
            this._trigger( "change", event, { item: item } );
        }

        this.close( event );
    },
    _setOption: function( key, value ) {
        if ( key === "icons" ) {
            this.button.find( "span.ui-icon" )
                .removeClass( this.options.icons.button )
                .addClass( value.button );
        }

        this._super( key, value );

        if ( key === "appendTo" ) {
            this.menuWrap.appendTo( this._appendTo() );
        }

        if ( key === "disabled" ) {
            this.menuInstance.option( "disabled", value );
            this.button
                .toggleClass( "ui-state-disabled", value )
                .attr( "aria-disabled", value );

            this.element.prop( "disabled", value );
            if ( value ) {
                this.button.attr( "tabindex", -1 );
                this.element.data('isDefault', true);
                this.close();
            } else {
                this.button.attr( "tabindex", 0 );
            }
        }

        if ( key === "width" ) {
            this._resizeButton();
        }

        if (key === "defaultButtonText") {
            this.element[0].selectedIndex = -1;
            this.focusIndex = null;

            if (Utility.isMobile()) {
                value = value ||
                    this.element.data('defaultTextMobile') ||
                    this.element.data('defaultText') ||
                    this.options.defaultButtonText;
            } else {
                value = value || this.element.data('defaultText') || this.options.defaultButtonText;
            }
            this.buttonText.html($(DEFAULT_TEXT_WRAP).html(value));
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
            if(Utility.isMobile() && !this.element.data('noTriggerDialog')) {
                this.element.trigger(this.element.data('mobileDialogEvent'), {id: this.ids.element});
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
