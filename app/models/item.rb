class Item < ActiveRecord::Base
  INCREASABLES  = [:defence, :attack, :magic, :health]
  ITEM_TYPES    = [:armor, :boots, :gloves, :hood, :weapon]

  attr_accessible :character_type_id, :increasable_id, :increase_value, :character_id, :item_type_id, :is_equipped
  belongs_to :character, :inverse_of => :items
  belongs_to :character_type

  validates :character_type_id, :increasable_id, :increase_value, :item_type_id, :presence => true
  validates :is_equipped,     :inclusion => {:in => [true, false], :message => 'Item should be equipped or unequipped'}
  validates :item_type_id,    :numericality => { :greater_than_or_equal_to => 0, :less_than => Item::ITEM_TYPES.size }
  validates :increasable_id,  :numericality => { :greater_than_or_equal_to => 0, :less_than => Item::INCREASABLES.size }
  validate  :owner_has_lteq_one_item_of_type_equipped, :if => lambda{|i| i.is_equipped_changed? && i.is_equipped == true}
  validate  :owner_can_equip_items_of_appropriate_type_only, :if => lambda{|i| i.is_equipped_changed? && i.is_equipped == true}

  scope :not_equipped, lambda{ where(:is_equipped => false) }

  after_validation :update_owner_stats, :if => lambda{|i| i.is_equipped_changed? }

  def update_owner_stats
    owner       = self.character
    attribute   = Item::INCREASABLES[self.increasable_id]
    owner_value = owner.try(attribute)
    sign        = self.is_equipped ? (1) : (-1)
    owner.update_attribute attribute, (owner_value + self.increase_value.to_i * sign) if owner && attribute
  end

  def owner_has_lteq_one_item_of_type_equipped
    condition = Item.where(:character_id => self.character_id, :is_equipped => true, :item_type_id => self.item_type_id).
                     where("id != ?", self.id).any?
    self.errors['base'] << 'You can not equip more than one item of the same type' if condition
  end

  def owner_can_equip_items_of_appropriate_type_only
    self.errors['base'] << 'You can not equip items of another class' if self.character_type_id != self.character.character_type_id
  end

end
