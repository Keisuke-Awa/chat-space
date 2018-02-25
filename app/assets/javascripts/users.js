$(function(){
    // Userクラスの定義
    var User = function(data) {
        this.id = data.id
        this.name = data.name;
    };

    User.prototype.searchFieldHTML = function() {
        var html = '<div class="chat-group-user">'
        html += '<p class="chat-group-user__name">' + this.name + '</p>'
        html += '</div>'
        return html;
    };

    $(function() {
        $('#user-search-field').on('keyup', function() {
            $('#user-search-result').empty();
            const input = $(this).val();
            if (!input) {
                return;
            }
            $.ajax({
                type: 'GET',
                url: '/users',
                data: { query: input },
                dataType: 'json'
            })
            .done(function(users) {

                users.forEach( function( user ) {
                    var user = new User(user);
                    const html = user.searchFieldHTML()
                    $('#user-search-result').append(html);
                });
            })
            .fail(function(){
                console.log('failed');
            })
        });
    });
})