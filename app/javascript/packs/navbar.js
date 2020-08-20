$(document).ready(function() {
    $('.fa-bars').click(function(e) {
        let menu = $('.nav-items');
        if (menu.hasClass("active")) {
            menu.removeClass('active')
        } else {
            menu.addClass('active');
        }
    })
})