$(function(){
    $('#new_message').on('submit', function(e){
        e.preventDefault();
        alert('hello');
        var formData = new FormData(this);
        var url = $(this).attr('action');
        console.log(formData);
        $.ajax({
            url: url,
            type: "POST",
            data: formData,
            dataType: 'json',
            processData: false,
            contentType: false
        })
    })
})