$(function(){
    // Messageクラスの定義
    const Message = function(data) {
        this.id = data.id;
        this.userName = data.user_name;
        this.createdAt = data.created_at;
        this.body = data.body;
        this.imageUrl = data.image_url;
    };

    Message.prototype.newHTMLComponent = function() {
        var html = '<div class=\'main-content__chat-area__message\' data-id="' + this.id + '">';
        html += '<div class="main-content__chat-area__message__info clearfix">';
        html += '<h3>' + this.userName + '</h3>';
        html += '<p>' + this.createdAt + '</p>';
        html += '</div>';
        html += '<div class=\'main-content__chat-area__message__text\'>';
        html += '<p>' + this.body + '</p>';
        html += '<img class="main-content__chat-area__message__image" src="' + this.imageUrl + '" >';
        html += '</div></div>';
        return html;
    };

    Message.autoScroll = function () {
        $("html,body").animate({scrollTop:$('.main-content__chat-area__message').last().offset().top});
    };

    Message.isAutoloadApiURL = function (targetURL) {
        const regex = new RegExp(/.+\/chat_groups\/\d+\/messages/);
        return regex.test(targetURL) ;
    };

    Message.defaultId = 0;

    const currentURL = location.href;

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
            const html = message.newHTMLComponent();
            $('#chat-area').append(html);
            Message.autoScroll();
            $('#message-text').val('');
            $('#message-img').val('');
        })
        .fail(function(errors) {
            alert(errors.responseJSON['errors']);
        });
        return false;
    });

    if( Message.isAutoloadApiURL(currentURL)){
        const intervalMSec = 5000;
        setInterval(function(){
            var lastMessageId = $('.main-content__chat-area__message:last').data('id');
            if(lastMessageId === void 0){
                lastMessageId = Message.defaultId;
            }
            $.ajax({
                url: currentURL,
                type: 'GET',
                data: {
                    message: { id: lastMessageId }
                },
                dataType: 'json'
            })
            .done(function(newMessages){
                if(newMessages.length === 0) {
                    return ;
                };
                var html = '';
                newMessages.forEach( function( newMessage ) {
                    const message = new Message(newMessage);
                    html +=  message.newHTMLComponent();
                });
                $('#chat-area').append(html);
                Message.autoScroll();
            })
            .fail(function(){
                alert('自動更新に失敗しました');
            });
        }, intervalMSec );
    }
});
