$(function(){
    // Userクラスの定義
    var User = function(data) {
        this.name = data.name;
    };

    User.prototype.newHTML = function() {

    };

    $('#new_message').on('submit', function(e){
        e.preventDefault();
        const formData = new FormData(this);
        const url = $(this).attr('action');
        $.ajax({
            url: url,
            type: 'POST',
            data: formData,
            dataType: 'json',
            processData: false,
            contentType: false
        })
            .done(function(data){
                const message = new Message(data);
                const html = message.newHTML();
                $('.main-content__chat-area').append(html);
                $("html,body").animate({scrollTop:$('.main-content__chat-area__message').last().offset().top});
                $('#message-text').val('');
                $('#message-img').val('');
            })
            .fail(function(errors) {
                alert(errors.responseJSON['errors']);
            });
        return false;
    })
})