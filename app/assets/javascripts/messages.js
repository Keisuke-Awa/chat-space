$(function(){
    // Messageクラスの定義
    var Message = function(userName, createdAtTime, body, imageUrl) {
        this.userName = userName;
        this.createdAtTime = createdAtTime;
        this.body = body;
        this.imageUrl = imageUrl;

        this.newMessageHTML = function() {
            var html = '<div class=\'main-content__chat-area__message\'>';
            html += '<div class=\'main-content__chat-area__message__info clearfix\'>';
            html += '<h3>' + this.userName + '</h3>';
            html += '<p>' + this.createdAtTime + '</p>';
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
        }
    };

    $('#new_message').on('submit', function(e){
        e.preventDefault();
        var formData = new FormData(this);
        var url = $(this).attr('action');
        $.ajax({
            url: url,
            type: 'POST',
            data: formData,
            dataType: 'json',
            processData: false,
            contentType: false
        })
        .done(function(data){
            console.log(data);
            var message = new Message(data.user_name, data.created_at_time, data.body, data.image_url);
            console.log(message);
            var html = message.newMessageHTML();
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