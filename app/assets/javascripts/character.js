$(function(){
  $('body').on('click','.inventory-table tbody .equip_item_link', function(event){
    $.ajax({
      url: '/items/equip.js',
      type: "POST",
      dataType: 'script',
      data: {item_id: $(this).data('itemId'), char_id: $(this).data('charId'), action_id: 0}
    });
  });
  $('body').on('click','.equipped_item', function(event){
    $.ajax({
      url: '/items/equip.js',
      type: "POST",
      dataType: 'script',
      data: {item_id: $(this).data('itemId'), char_id: $(this).data('charId'), action_id: 1}
    });
  });
  $('body').on('click','.selecting_char_type', function(event){
    var input_element = $(this).parents('.row').next()
    input_element.val($(this).data('id'));
    $(this).parents('form').submit();
  });
  $('body').on('click','.go_fight', function(event){
    var form = $(this).parents('form')
    form.children('input#enemy_id').val($(this).data('enemyId'));
    form.submit();
  });
});
