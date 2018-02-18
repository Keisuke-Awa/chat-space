$(function(){
    function buildHTML(message){
        var html = `<div class='main-content__chat-area__message'>
                       <div class='main-content__chat-area__message__info clearfix'>
                         <h3>${ message.user.name }</h3>
                         <p>${ message.created_at }</p>
                       </div>`;
        if(message.body){
            html += `<div class='main-content__chat-area__message__text'>
                      <p>${ message.body }</p>
                     </div>`;
        }
        if(message.image.url){
            html += `<img class="main-content__chat-area__message__image" src="${ message.image.url }">`
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
            type: "POST",
            data: formData,
            dataType: 'json',
            processData: false,
            contentType: false
        })
        .done(function(data){
            var html = buildHTML(data);
            console.log(data.image.url);
            console.log(html);
            $('.main-content__chat-area').append(html);
            $('.message-text').val('');
            $('.message-img').val('');

        })
    })
})