$(function(){
    function newMessageHTML(message){
        var html = `<div class='main-content__chat-area__message'>
                       <div class='main-content__chat-area__message__info clearfix'>
                         <h3>${ message.user_name }</h3>
                         <p>${ message.created_at_time }</p>
                       </div>`;
        if(message.body){
            html += `<div class='main-content__chat-area__message__text'>
                      <p>${ message.body }</p>
                     </div>`;
        }
        if(message.image_url){
            html += `<img class="main-content__chat-area__message__image" src="${ message.image_url }">`
        }
        html += `</div>`;
        return html;
        }
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
            var html = newMessageHTML(data);
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