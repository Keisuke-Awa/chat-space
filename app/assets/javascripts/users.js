$(function(){
    // Userクラスの定義
    var User = function(data) {
        this.id = data.id
        this.name = data.name;
    };

    User.prototype.newHTML = function() {

    };

    $(function() {
        $('#user-search-field').on('keyup', function() {
            var input = $(this).val();
        });
    });
})