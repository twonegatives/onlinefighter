module CharacterHelper

  def equip_item_link item, character
    no_equipped_item_of_same_type   = character.items.none?{|i| i.is_equipped == true && i.item_type_id == item.item_type_id}
    item_is_equippable_by_char      = item.character_type.id == @character.character_type_id
    hash                            = {:title => 'Equip item',
                                       :class => 'btn btn-mini equip_item_link',
                                       :data => {:item_id => item.id,
                                                 :char_id => character.id}}
    hash[:disabled]                 = 'disabled' unless item_is_equippable_by_char && no_equipped_item_of_same_type
    link_to( '<i class="icon-hand-up"></i>'.html_safe, '#', hash)
  end

  def slot_item type, items
    item = items.find{|i| Item::ITEM_TYPES[i.item_type_id] == type && i.is_equipped == true}
    if item
      content_tag :a, :class => 'status_item equipped_item', :data => {:item_id => item.id, :char_id => item.character_id} do
        content_tag :h4 do
          "#{type.to_s.capitalize}<br/>#{Item::INCREASABLES[item.increasable_id]} +#{item.increase_value}".html_safe
        end
      end
    else
      content_tag :div, :class => 'status_item disabled_item' do
        content_tag :h4 do
          "#{type.to_s.capitalize} slot<br/>(empty)".html_safe
        end
      end
    end
  end
end
