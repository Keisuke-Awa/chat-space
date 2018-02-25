$(function(){
    // Userクラスの定義
    var User = function(data) {
        this.id = data.id;
        this.name = data.name;
    };

    User.prototype.searchFieldHTML = function() {
        console.log(this);
        var html = '<div class="chat-group-user">';
        html += '<p class="chat-group-user__name">' + this.name + '</p>';
        html += "<button class='chat-group-user__add-user-btn' type='button' data-obj='" + this +  "'>追加</button>";
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

    User.prototype.deleteMemberHTML = function() {

    };

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
                const html = chatGroupUser.searchFieldHTML();
                $('#user-search-result').append(html);
            });
        })
        .fail(function(errors) {
            alert(errors.responseJSON['errors']);
        });
    });

    $(document).on("click", ".chat-group-user__add-user-btn", function(){
        const userData = $(this).data('obj');
        const user = new User(userData);
        console.log(user.name);
    });
})