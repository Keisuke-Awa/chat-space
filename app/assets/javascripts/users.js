$(function(){
    // Userクラスの定義
    var User = function(data) {
        this.id = data.id;
        this.name = data.name;
    };

    User.prototype.userListComponent = function() {
        var html = '<div class="chat-group-user">';
        html += '<p class="chat-group-user__name">' + this.name + '</p>';
        html += '<button class="chat-group-user__add-user-btn" type="button" data-id="' + this.id + '" data-name="' + this.name + '">追加</button>';
        html += '</div>';
        return html;
    };

    User.prototype.addMemberHTML = function() {
        var html = '<div class="chat-group-user">';
        html += '<p class="chat-group-user__name">' + this.name + '</p>';
        html += '<button class="chat-group-user__delete-user-btn" type="button">削除</button>';
        html += '<input name="chat_group[user_ids][]" type="hidden" value="' + this.id + '">';
        html += '</div>';
        return html;
    };


    $(document).on('keyup', '#user-search-field', function() {
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
                const html = chatGroupUser.userListComponent();
                $('#user-search-result').append(html);
            });
        })
        .fail(function(errors) {
            alert(errors.responseJSON['errors']);
        });
    });

    $(document).on("click", ".chat-group-user__add-user-btn", function(){
        const userId = $(this).data('id');
        const userName = $(this).data('name');
        const userData = {id: userId, name: userName};
        const user = new User(userData);
        const html = user.addMemberHTML();
        $(this).parent().remove();
        $('#chat-group-users').append(html);
    });

    $(document).on("click", ".chat-group-user__delete-user-btn", function(){
        $(this).parent().remove();
    });
})