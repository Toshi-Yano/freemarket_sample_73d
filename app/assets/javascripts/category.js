$(document).on('turbolinks:load', function(){
  $(function(){
    function appendOption(category){
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    // 子カテゴリー
    function appendChildrenBox(insertHTML){
      var childSelectHtml = '';
      childSelectHtml = `<div class='selectbox-category__added' id= 'children_wrapper'>
                          <div class='selectbox1'>
                            <select class="selectbox-category--select" id="child_category" name="item[category_id]">
                              <option value="---" data-category="---">---</option>
                              ${insertHTML}
                            <select>
                          </div>
                        </div>`;
      $('.selectbox-category').append(childSelectHtml);
    }

    // 孫カテゴリー
    function appendGrandchidrenBox(insertHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `<div class='selectbox-category__added' id= 'grandchildren_wrapper'>
                                <div class='selectbox2'>
                                  <select class="selectbox-category__box--select" id="grandchild_category" name="item[category_id]">
                                    <option value="---" data-category="---">---</option>
                                    ${insertHTML}
                                  </select>
                                </div>
                              </div>`;
      $('.selectbox-category').append(grandchildSelectHtml);
    }

    // 親カテゴリー選択後のイベント
    $('#parent_category').on('change', function(){
      var parent_category_id = document.getElementById
      ('parent_category').value; //選択された親カテゴリーの名前を取得
      if (parent_category_id != "---"){ //親カテゴリーが初期値でないことを確認
        $.ajax({
          url: '/items/category/get_category_children',
          type: 'get',
          data: { parent_id: parent_category_id },
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove(); 
          $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove(); 
        $('#grandchildren_wrapper').remove();
      }
    });

    // 子カテゴリー選択後のイベント
    $('.selectwrapper').on('change', '#child_category', function(){
      var child_category_id = $('#child_category option:selected').data('category'); 
      if (child_category_id != "---"){ 
        $.ajax({
          url: '/items/category/get_category_grandchildren',
          type: 'get',
          data: { child_id: child_category_id },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0) {
            $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除する
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      }
    });
  });
});