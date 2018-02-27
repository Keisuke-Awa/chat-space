$(function(){
    // Messageクラスの定義
    var Message = function(data) {
        this.id = data.id;
        this.userName = data.user_name;
        this.createdAt = data.created_at;
        this.body = data.body;
        this.imageUrl = data.image_url;
    };

    Message.prototype.messageComponent = function() {
        var html = '<div class=\'main-content__chat-area__message\'>';
        html += '<div class="main-content__chat-area__message__info clearfix" data-id="' + this.id + '">';
        html += '<h3>' + this.userName + '</h3>';
        html += '<p>' + this.createdAt + '</p>';
        html += '</div>';
        html += '<div class=\'main-content__chat-area__message__text\'>';
        html += '<p>' + this.body + '</p>';
        html += '<img class="main-content__chat-area__message__image" src="' + this.imageUrl + '" >';
        html += '</div></div>';
        return html;
    };

    var currentURL = window.location.href;

    function judgeValidURL(targetURL) {
        const regex = new RegExp(/.+\/chat_groups\/\d+\/messages/);
        if (regex.test(targetURL)) {
            return true;
        }
        else {
            return false;
        }
    };

    function autoMessageScroll() {
        $("html,body").animate({scrollTop:$('.main-content__chat-area__message').last().offset().top});
    }

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
            const html = message.messageComponent();
            $('#chat-area').append(html);
            autoMessageScroll();
            $('#message-text').val('');
            $('#message-img').val('');
        })
        .fail(function(errors) {
            alert(errors.responseJSON['errors']);
        });
        return false;
    });

    if( judgeValidURL(currentURL)){
        setInterval(function(){
            var lastMessageId = $('.main-content__chat-area__message:last').data('id');
            if(lastMessageId === void 0){
                lastMessageId = 0
            }
            $.ajax({
                url: currentURL,
                type: 'GET',
                data: { last_message_id: lastMessageId },
                dataType: 'json'
            })
            .done(function(messages){
                if(messages.length === 0) {
                    return ;
                };
                var html = '';
                messages.forEach( function( message ) {
                    var message = new Message(message);
                    html +=  message.messageComponent();
                });
                $('#chat-area').append(html);
                autoMessageScroll();
            })
            .fail(function(){
                alert('自動更新に失敗しました');
            });
        },5 * 1000);
    }

})