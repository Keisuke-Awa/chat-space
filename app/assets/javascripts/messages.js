$(function(){
    function buildHTML(message){
        var html = `<div class='main-content__chat-area__message'>
                      <div class='main-content__chat-area__message__info clearfix'>
                        <h3>${ message.user.name }</h3>
                        <p>${ message.created_at }</p>
                      </div>
                      <div class='main-content__chat-area__message__text'>
                        <p>${ message.body }</p>
                      </div>
                    </div>`
            return html;
        }
    $('#new_message').on('submit', function(e){
        e.preventDefault();
        alert('hello');
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
            console.log(html);
            $('.main-content__chat-area').append(html)
            // $('.textbox').val('')
        })
    })
})