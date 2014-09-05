/**
 * @overview
 * @copyright 2013 Tommy Rochette http://trochette.github.com/
 * @author Tommy Rochette
 * @version 0.0.1
 *
 * @license MIT
 */
(function () {
    "use strict";

    /**
     * @Class
     */
    window.Key = function ($scope, $element, $attrs) {

        var body = $('body');

        /**
         * Initialize Key to default settings
         */
        function init() {
            if ("ontouchstart" in document.documentElement) {
                $element.bind('touchstart.ngKey', keyPressed);
                body.bind('touchend.ngKey', keyDepressed);
            } else {
                $element.bind('mousedown.ngKey', keyPressed);
                body.bind('mouseup.ngKey', keyDepressed);
            }

            $scope.$on('destroy', destroy);
        };


        /**
         * Triggered when a user press on this element
         *
         * @param event
         */
        function keyPressed(event) {
            $element.addClass('pressed');
            event.preventDefault();
            event.stopImmediatePropagation();
            $scope.$emit(Key.PRESSED, $attrs.ngKey);
        }


        /**
         * Triggered when a user stop pressing this element
         *
         * @param event
         */
        function keyDepressed(event) {
            $element.removeClass('pressed');
        }

        /**
         * Cleanup all listeners before destroying this directive.
         */
        function destroy() {
            $element.bind('touchstart.ngKey', keyPressed);
            bodybind('touchend.ngKey', keyDepressed);
            $element.bind('mousedown.ngKey', keyPressed);
            body.bind('mouseup.ngKey', keyDepressed);
        }


        init();
    };

    /**
     * @Event
     */
    Key.PRESSED = "Key.PRESSED";

    angular.module('ngKeypad', [])
        .directive('ngKey', function () {
            return {
                restrict: 'A',
                link: function ($scope, $element, $attrs) {
                    new Key($scope, $element, $attrs);
                }
            };
        });
})();
/**
 * Keypad directive, display a keypad on the screen. Template for it
 * can be include inside the node containing the keypad attribute.
 *
 * Use of Namespace.js
 *
 * @author tommy.rochette[followed by the usual sign]universalmind.com
 */

(function () {
    "use strict";


    /**
     * @Class
     */
    window.Keypad = function ($scope, $element, $attrs, $rootScope) {

        var locked = false,
            opened = false,
            padId = $attrs.ngKeypad,
            body = $('body');

        /**
         * Initialize Keypad to default settings
         * based on attributes.
         */
        function init() {
            $scope.$on(Key.PRESSED, handleKeyPressed);
            $rootScope.$on(Keypad.TOGGLE_LOCKING, handleLockingToggle);
            $rootScope.$on(Keypad.TOGGLE_OPENING, handleOpeningToggle);
            $rootScope.$on(Keypad.OPEN, handleOpeningToggle);
            $rootScope.$on(Keypad.CLOSE, handleOpeningToggle);
            $element.addClass("closed");

            initScope();
        };

        /**
         * Initialize scope variables
         */
        function initScope() {
            $scope.close = function () {
                close();
            }
        }


        /**
         * Triggered when a user press any key on the pad
         * check current status then dispatch KEY_PRESSED event.
         *
         * @param event
         * @param key
         */
        function handleKeyPressed(event, key) {
            if (!locked) {
                if (key.indexOf('[') === -1 && key.indexOf(']') === -1) {
                    $scope.$emit(Keypad.KEY_PRESSED, key, padId);
                } else {
                    $scope.$emit(Keypad.MODIFIER_KEY_PRESSED, key.substring(1, key.length - 1), padId);
                }
            }
        }


        /**
         * Triggered when a user press any key on the pad
         * check current status then dispatch KEY_PRESSED event.
         *
         * @param event
         * @param key
         */
        function handleLockingToggle(event, id) {
            if (padId === id || !id) {
                locked = !locked;

                if (locked) {
                    $element.attr("disabled", "disabled");
                } else {
                    $element.removeAttr("disabled");
                }
            }
        }


        /**
         * Triggered when a user toggle keypad opening.
         *
         * @param event
         * @param key
         */
        function handleOpeningToggle(event, id, params) {
            if (padId === id || !id) {
                switch (event.name) {
                    case Keypad.CLOSE:
                        opened = false;
                        break;
                    case Keypad.OPEN:
                        opened = true;
                        break;
                    default:
                        opened = !opened;
                        break;
                }

                if (!opened) {
                    close();
                } else {
                    open();
                    applyOptions(params);
                }
            }
        }

        function applyOptions(params) {
            if (params && params.position) {
                $element.css("top", params.position.y);
                $element.css("left", params.position.x);
            }
        }


        /**
         * Open current pad
         */
        function open() {
            $element.removeClass("closed");
            $scope.$emit(Keypad.OPENED, padId);
            autoClose();
            applyOptions();
        }


        /**
         * Close current pad
         */
        function close() {
            opened = false;
            $scope.$emit(Keypad.CLOSED, padId);
            body.off("click.keypad");
            $element.addClass("closed");
        }


        /**
         * Check if the attribute auto-close is set then
         * add event for automatic closing.
         *
         * @param event
         * @param key
         */
        function autoClose() {
            if ($attrs.autoClose) {
                //Timeout use to break the event flow.
                setTimeout(function () {
                    body.on("click.keypad", function () {
                        opened = !opened;
                        close();
                        if (!$scope.$$phase) {
                            $scope.$apply();
                        }
                    });
                    $element.on("click.keypad", cancelEvent);
                }, 1);
            }
        }


        /**
         * Dummy function to cancel event propagation.
         *
         * @param event
         */
        function cancelEvent(event) {
            event.stopPropagation();
        }


        init();
    };


    /**
     * @Events
     */
    Keypad.KEY_PRESSED = "Keypad.KEY_PRESSED";
    Keypad.MODIFIER_KEY_PRESSED = "Keypad.MODIFIER_KEY_PRESSED";
    Keypad.TOGGLE_LOCKING = "Keypad.TOGGLE_LOCKING";
    Keypad.TOGGLE_OPENING = "Keypad.TOGGLE_OPENING";
    Keypad.OPENED = "Keypad.OPENED";
    Keypad.CLOSED = "Keypad.CLOSED";
    Keypad.OPEN = "Keypad.OPEN";
    Keypad.CLOSE = "Keypad.CLOSE";


    angular.module('ngKeypad')
        .directive('ngKeypad', ['$rootScope', function ($rootScope) {

            return {
                restrict: 'A',
                link: function ($scope, $element, $attrs) {
                    new Keypad($scope, $element, $attrs, $rootScope);
                }
            }
        }]);
})();
/**
 * @overview
 * @copyright 2013 Tommy Rochette http://trochette.github.com/
 * @author Tommy Rochette
 * @version 0.0.1
 *
 * @license MIT
 */
(function () {
    "use strict";

    /**
     * @Class
     */
    window.KeypadInput = function ($scope, $element, $attrs, controller) {

        var self = this;

        this.modifierKeyListener = null;
        this.keyListener = null;
        this.element = $element;
        this.active = false;
        this.model = null;
        this.padId = $attrs.ngKeypadInput;


        /**
         * Initialize Key to default settings
         */
        function init() {
            $element.on('click.ngKeypadInput', handleElementSelected);
            $element.on('focus.ngKeypadInput', handleElementSelected);
            $element.on('blur.ngKeypadInput', handleElementBlur);

            if (!$attrs.ngModel) {
                throw new Error("KeypadInput requires the use of ng-model on this element", $element);
            }

            $scope.$on('destroy', destroy);
        };


        /**
         * Triggered when a user select a keypad input field.
         * Set listeners and add focused class.
         *
         * @param event
         */
        function handleElementSelected(event) {
            event.stopPropagation();

            if (!self.active) {
                clearSelectedElement();

                self.active = true;
                self.keyListener = $scope.$on(Keypad.KEY_PRESSED, handleKeyPressed);
                self.closeListener = $scope.$on(Keypad.CLOSED, handleKeypadClosed);
                self.modifierKeyListener = $scope.$on(Keypad.MODIFIER_KEY_PRESSED, handleModifierKeyPressed);

                $element.addClass("focus");
                $element.focus();

                $scope.$emit(Keypad.OPEN, $attrs.ngKeypadInput);

                KeypadInput.selectedInput = self;
            }
        };


        /**
         * Clear old reference of the selected element
         */
        function clearSelectedElement() {
            if (KeypadInput.selectedInput) {
                KeypadInput.selectedInput.active = false;
                KeypadInput.selectedInput.keyListener();
                KeypadInput.selectedInput.element.removeClass("focus");
                KeypadInput.selectedInput = null;
            }
        }


        /**
         * Triggered when keypad is closing to clear
         * the current input being edited.
         *
         * @param event
         * @param padId
         */

        function handleKeypadClosed(event, padId) {
            if (self.padId === padId && self.active) {
                clearSelectedElement();
            }
        }


        /**
         * Trigerred when the input loose focus to
         * clear selected element.
         *
         * @param event
         */
        function handleElementBlur(event) {
            clearSelectedElement();
        }


        /**
         * Event triggered from ngKeyPad called only if the current
         * input is selected. Works with ngModel.
         *
         * @param event
         * @param key
         * @param padId
         */
        function handleKeyPressed(event, key, padId) {
            if (self.padId === padId && self.active) {
                var value = controller.$viewValue;


                if (!value) {
                    value = "";
                }

                if (!isRestricted(value, key)) {
                    value += key;
                }

                controller.$setViewValue(value);
                $scope.$apply();
            }
        };


        /**
         * Triggered when a modifier key is pressed
         *
         * @param event
         * @param key
         * @param padId
         */
        function handleModifierKeyPressed(event, key, padId) {
            if (self.padId === padId && self.active) {
                if (key === "CLEAR") {
                    controller.$setViewValue("");
                    $scope.$apply();
                }
            }
        };


        /**
         * Check if the input is retricted by a RegExp.
         * data-ng-keypad-restric is used to save the string
         * corresponding to the RegExp
         *
         * @param value
         * @param key
         */
        function isRestricted(value, key) {
            var restricted = false,
                regExp = new RegExp($attrs.ngKeypadRestrict, 'gi');

            if ($attrs.ngKeypadRestrict) {
                if (!key.match(regExp)) {
                    restricted = true;
                } else if (!String(value + key).match(regExp, 'gi')) {
                    restricted = true;
                }
            }

            return restricted;
        }


        /**
         * Cleanup all listeners before destroying this directive.
         */
        function destroy() {
            $element.off('click.ngKeypadInput');
            $element.on('focus.ngKeypadInput', this.handleElementSelected);
        };


        init();
    };


    KeypadInput.selectedInput = null;


    angular.module('ngKeypad')
        .directive('ngKeypadInput', function () {
            return {
                restrict: 'A',
                require: '^ngModel',
                link: function ($scope, $element, $attrs, controller) {
                    new KeypadInput($scope, $element, $attrs, controller);
                }
            }
        });
})();