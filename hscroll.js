function hScroller(target) {
    function scrollHorizontally(e) {
        e = window.event || e;
        var delta = Math.max(-1, Math.min(1, (e.wheelDelta || -e.detail)));
        document.getElementById(target).scrollLeft -= (delta*40); // Multiplied by 40
        e.preventDefault();
    }
    if (document.getElementById(target).addEventListener) {
        // IE9, Chrome, Safari, Opera
        document.getElementById(target).addEventListener("mousewheel", scrollHorizontally, false);
        // Firefox
        document.getElementById(target).addEventListener("DOMMouseScroll", scrollHorizontally, false);
    } else {
        // IE 6/7/8
        document.getElementById(target).attachEvent("onmousewheel", scrollHorizontally);
    }
};