$(function(){
    // Messageクラスの定義
    var Message = function(data) {
        this.userName = data.user_name;
        this.createdAt = data.created_at;
        this.body = data.body;
        this.imageUrl = data.image_url;
    };

    Message.prototype.newMessageHTML = function() {
        var html = '<div class=\'main-content__chat-area__message\'>';
        html += '<div class=\'main-content__chat-area__message__info clearfix\'>';
        html += '<h3>' + this.userName + '</h3>';
        html += '<p>' + this.createdAt + '</p>';
        html += '</div>';
        if(this.body) {
            html += '<div class=\'main-content__chat-area__message__text\'>';
            html += '<p>' + this.body + '</p>';
            html += '</div>';
        }
        if(this.imageUrl){
            html += '<img class="main-content__chat-area__message__image" src="' + this.imageUrl + '" >';
        }
        return html;
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
            const html = message.newMessageHTML();
            $('.main-content__chat-area').append(html);
            $("html,body").animate({scrollTop:$('.main-content__chat-area__message').last().offset().top});
            $('.message-text').val('');
            $('.message-img').val('');
        })
        .fail(function() {
            alert('メッセージの送信に失敗しました');
        });
        return false;
    })
})