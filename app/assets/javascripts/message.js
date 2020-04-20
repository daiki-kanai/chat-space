$(function() {
  function buildHTML(message){
    if ( message.image ) {
      var html =
       `<div class="message-block">
          <div class="message-data">
            <div class="message-data__messenger">
              ${message.user_name}
            </div>
            <div class="message-data__data-and-time">
              ${message.created_at}
            </div>
          </div>
          <div class="message">
            <p class="message__content">
              ${message.body}
            </p>
          </div>
          <img src=${message.image} >
        </div>`
      return html;
    } else {
      var html =
       `<div class="message-block">
          <div class="message-data">
            <div class="message-data__messenger">
              ${message.user_name}
            </div>
            <div class="message-data__data-and-time">
              ${message.created_at}
            </div>
          </div>
          <div class="message">
            <p class="message__content">
              ${message.body}
            </p>
          </div>
        </div>`
      return html;
    };
  };
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
    .done(function(data) {
      var html = buildHTML(data);
      $('.main-chat__message-list').append(html);
      $('.main-chat__message-list').animate({ scrollTop: $('.main-chat__message-list')[0].scrollHeight});
      $('form')[0].reset();
      $('.send-btn').prop('disabled', false);
    })
    .fail(function() {
      alert("メッセージの送信に失敗しました");
    });
});
});