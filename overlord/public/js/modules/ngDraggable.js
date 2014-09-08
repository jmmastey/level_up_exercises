 /**
 * Draggable directive, allow to drag any element
 * targeted by this directive.
 *
 * Use of Namespace.js
 *
 * @author Tommy Rochette http://trochette.github.com/
 * @version 0.0.1
 * @license MIT
 */
(function () {
    "use strict";
	
	/**
	 * @Class
	 */ 
    var Draggable = function($scope,$element,$attrs){

    	var offset = {},
    		body   = $('body'),
    		isDragging = false;

    	/**
	     * Initialize Draggable to default settings
	     */  
    	function init(){
    		$element.css("position","absolute");

    		if ("ontouchstart" in document.documentElement){
    			$element.bind('touchstart.ngDraggable',startDrag);
    			body.bind('touchend.ngDraggable',stopDrag);
    			body.bind('touchmove.ngDraggable',drag);
    		}else{
    			$element.bind('mousedown.ngDraggable',startDrag);
    			body.bind('mouseup.ngDraggable',stopDrag);
    			body.bind('mousemove.ngDraggable',drag);
    		}
    		
    		$scope.$on('destroy',destroy);
    	};


    	/**
	     * Triggered when a user start moving his mouse
	     * or his finger on mobile application.
		 *
	     * @param event
	     */ 
    	function drag(event){
    		if(isDragging){
    			var position = {};

    			if(event.type==="mousemove"){
                    position.x = Math.floor(event.pageX-offset.x);
    				position.y = Math.floor(event.pageY-offset.y);
    				
    			}else{
    				var orig = event.originalEvent;  
				    position.x = Math.floor(orig.changedTouches[0].pageX - offset.x); 
				    position.y = Math.floor(orig.changedTouches[0].pageY - offset.y);  
				}

    			$element.css("left",position.x);
				$element.css("top",position.y);
			}
    	}


    	/**
    	 * Triggered when a user click or start touching the element.
		 *
	     * @param event
	     */ 
    	function startDrag(event){
    		isDragging = true;

    		if(event.type==="mousedown"){
                var localoffsetX = $element.offset().left,
                    localoffsetY = $element.offset().top,
                    localx = Math.floor(event.pageX-localoffsetX),
                    localy = Math.floor(event.pageY-localoffsetY);
              	offset.x = localx;
	    		offset.y = localy;
           }else{
    			var orig = event.originalEvent;  
			    var pos  = $(this).position();  
			    offset.x = Math.floor(orig.changedTouches[0].pageX - pos.left);
			    offset.y = Math.floor(orig.changedTouches[0].pageY - pos.top);
    		}

            $scope.$emit("$startDrag");
    		event.preventDefault();
    	}


    	/**
    	 * Triggered when a user remove his finger from the screen.
		 *
	     * @param event
	     */ 
    	function stopDrag(event){
    		isDragging = false;
            offset = {};
    		$scope.$emit("$stopDrag");
    	}


    	/**
    	 * Cleanup all listeners before destroying this directive.
	     */ 
    	function destroy(){
			$element.unbind('mousedown.ngDraggable',startDrag);
    		$element.unbind('mousestart.ngDraggable',startDrag);
    		body.unbind('mouseup.ngDraggable',stopDrag);
    		body.unbind('touchend.ngDraggable',stopDrag);
    		body.unbind('mousemove.ngDraggable',drag);
    		body.unbind('touchmove.ngDraggable',drag);
    	}


		init();
    };

    angular.module('ngDraggable',[])
    	.directive('ngDraggable',function () {
    		return {
			    restrict: 'A',
			    link: function ($scope, $element, $attrs) {
			    	new Draggable($scope, $element, $attrs);
				}
			}	
	});
})();