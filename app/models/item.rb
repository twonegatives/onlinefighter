class Item < ActiveRecord::Base
  INCREASABLES  = [:defence, :attack, :magic, :max_health]
  ITEM_TYPES    = [:armor, :boots, :gloves, :health, :hood, :weapon]

  attr_accessible :character_type_id, :increasable_id, :increase_value, :character_id, :item_type_id, :is_equipped
  belongs_to :character, :inverse_of => :items
  belongs_to :character_type

  validates :character_type_id, :increasable_id, :increase_value, :item_type_id, :is_equipped, :presence => true

  after_validation :update_owner_stats, :if => lambda{|i| i.is_equipped.changed?}

  def update_owner_stats
    owner       = self.character
    attribute   = Item.INCREASABLES[self.increasable_id]
    owner_value = owner.try(attribute)
    sign        = self.is_equipped ? (1) : (-1)
    owner.update_attribute! attribute, (owner_value + self.increase_value * sign)
  end

end
