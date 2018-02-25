$(function(){
    // Userクラスの定義
    var User = function(data) {
        this.id = data.id;
        this.name = data.name;
    };

    User.prototype.searchFieldHTML = function() {
        var html = '<div class="chat-group-user">';
        html += '<p class="chat-group-user__name">' + this.name + '</p>';
        html += '<button class="chat-group-user__add-user-btn" type="button">追加</button>';
        html += '</div>';
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
                    const chatGroupUser = new User(user);
                    const html = chatGroupUser.searchFieldHTML()
                    $('#user-search-result').append(html);
                });
            })
            .fail(function(errors) {
                alert(errors.responseJSON['errors']);
            });
        });
    });
})