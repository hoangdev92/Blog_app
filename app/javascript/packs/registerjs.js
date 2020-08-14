$(document).ready(function() {
    var check = true;
    var images = new Array('/assets/hinh-nen3.jpg', '/assets/hinh-nen4.jpg', '/assets/hinh-nen5.jpg');
    var nextimage = 0;

    doSlideshow();

    function doSlideshow() {
        if (nextimage >= images.length) { nextimage = 0; }
        $('body')
            .css('background-image', 'url(' + images[nextimage++] + ')')
            .fadeIn(3000, function() {
                setTimeout(doSlideshow, 4000);
            });
    }

    $('#name').keyup(function(e) {
        var specialChars = "<>@!#$%^&*()_+[]{}?:;|'\"\\,./~`-=";
        var checkForSpecialChar = function(string) {
            for (i = 0; i < specialChars.length; i++) {
                if (string.indexOf(specialChars[i]) > -1) {
                    return true
                }
            }
            return false;
        }

        if ($(this).val() == '') {
            $(this).removeClass('is-valid');
            $(this).addClass('is-invalid');
            $('#val-name').addClass('alert-danger');
            $('#val-name').text('Nhập Tên Của Bạn');
            check = false;
        } else if ($(this).val().length > 254) {
            $(this).removeClass('is-valid');
            $(this).addClass('is-invalid');
            $('#val-name').addClass('alert-danger');
            $('#val-name').text('Bạn Nhập Tên Quá Dài');
            check = false;
        } else {
            if (checkForSpecialChar($(this).val())) {
                $(this).removeClass('is-valid');
                $(this).addClass('is-invalid');
                $('#val-name').addClass('alert-danger');
                $('#val-name').text('Không Được Chứa Ký Tự Đặc biệt');
                check = false;
            } else {
                $(this).removeClass('is-invalid');
                $(this).addClass('is-valid');
                $('#val-name').removeClass('alert-danger');
                $('#val-name').text('');
                check = true;
            }
        }
    });

    $('#email').keyup(function(e) {
        function ValidateEmail(mail) {
            if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail)) {
                return (true)
            }
            return (false)
        }

        if (ValidateEmail($(this).val())) {
            $(this).removeClass('is-invalid');
            $(this).addClass('is-valid');
            $('#val-email').removeClass('alert-danger');
            $('#val-email').text('');
            check = true;
        } else {
            $(this).removeClass('is-valid');
            $(this).addClass('is-invalid');
            $('#val-email').addClass('alert-danger');
            $('#val-email').text('Email Sai!');
            check = false;
        }

        if ($(this).val() == '') {
            $(this).removeClass('is-valid');
            $(this).addClass('is-invalid');
            $('#val-email').addClass('alert-danger');
            $('#val-email').text('Nhập Email Của Bạn');
            check = false;
        }
    });


    $('#password').keyup(function(e) {
        var specialChars = "<>@!#$%^&*()_+[]{}?:;|'\"\\,./~`-=";
        var checkForSpecialChar = function(string) {
            for (i = 0; i < specialChars.length; i++) {
                if (string.indexOf(specialChars[i]) > -1) {
                    return true
                }
            }
            return false;
        }

        if ($(this).val() == '') {
            $(this).removeClass('is-valid');
            $(this).addClass('is-invalid');
            $('#val-pass').addClass('alert-danger');
            $('#val-pass').text('Nhập Mật Khẩu Của Bạn');
            check = false;
        } else if ($(this).val().length > 254) {
            $(this).removeClass('is-valid');
            $(this).addClass('is-invalid');
            $('#val-pass').addClass('alert-danger');
            $('#val-pass').text('Mật Khẩu  Quá Dài');
            check = false;
        } else {
            if (checkForSpecialChar($(this).val())) {
                $(this).removeClass('is-valid');
                $(this).addClass('is-invalid');
                $('#val-pass').addClass('alert-danger');
                $('#val-pass').text('Không Được Chứa Ký Tự Đặc biệt');
                check = false;
            } else if ($(this).val().length < 6) {
                $(this).removeClass('is-valid');
                $(this).addClass('is-invalid');
                $('#val-pass').addClass('alert-danger');
                $('#val-pass').text('Mật Khẩu Quá Ngắn');
            } else {
                $(this).removeClass('is-invalid');
                $(this).addClass('is-valid');
                $('#val-pass').removeClass('alert-danger');
                $('#val-pass').text('');
                check = true;
            }
        }
    });

    $('#confirm-password').keyup(function(e) {
        var password = $('#password').val();
        var cf = $(this).val();
        if (cf != password) {
            $(this).removeClass('is-valid');
            $(this).addClass('is-invalid');
            $('#val-cfpass').addClass('alert-danger');
            $('#val-cfpass').text('Nhập lại mật khẩu không đúng');
            check = false;
        } else {
            $(this).removeClass('is-invalid');
            $(this).addClass('is-valid');
            $('#val-cfpass').removeClass('alert-danger');
            $('#val-cfpass').text('');
            check = true;
        }
    })
})