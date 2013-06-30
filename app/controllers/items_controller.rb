class ItemsController < ApplicationController

  before_filter :find_item

  def equip
    item_type = Item::ITEM_TYPES[@item.item_type_id].to_s
    @flag      = params['action_id'].to_i == 0 ? true : false
    if @item.update_attributes(:is_equipped => @flag)
      @character   = Character.where(:user_id => current_user.id).includes(:items).first
      render :is => 'equip'
    else
      render :js => %Q{alert("Could not #{@flag ? '' : 'un'}equip an #{item_type}: #{@item.errors.full_messages.join(', ')}")}.html_safe
    end
    return
  end

  private
  def find_item
    @item = Item.joins(:character).where(:characters => {:id => params['char_id'].to_i}, :items => {:id => params['item_id'].to_i}).select('items.*').first
    render :js => %Q{alert("There is no such an item in character's inventory")}.html_safe unless @item
  end
end
