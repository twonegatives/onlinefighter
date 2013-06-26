#encoding:utf-8
class Character < ActiveRecord::Base
  attr_accessible :character_type_id, :health, :experience, :won, :lost, :defence, :attack, :magic
  belongs_to :character_type
  has_many :items


  validates :character_type_id, :health, :experience, :won, :lost, :defence, :attack, :magic, :presence => true
  validate :has_lteq_one_item_of_type_equipped
  validate :can_equip_items_of_appropriate_type_only

  before_create :give_two_equal_items

  def give_two_equal_items
    item_hash = { :character_type_id => self.character_type_id,
                  :increasable_id    => Random.rand(Item::INCREASABLES.size),
                  :increase_value    => Random.rand(1..5),
                  :item_type_id      => Random.rand(Item::ITEM_TYPES.size),
                  :is_equipped       => false
                }
    2.times{|time| self.items.build(item_hash)}
  end

  def has_lteq_one_item_of_type_equipped
    self.errors['base'] << 'Нельзя одевать несколько предметов одного типа' if self.items.uniq{|i| i.item_type_id}.size != self.items.size
  end

  def can_equip_items_of_appropriate_type_only
    self.errors['base'] << 'Нельзя одевать предметы чужого класса' if self.items.any?{|i| i.is_equipped && i.character_type_id != self.character_type_id}
  end

  def perform_a_round
    self.health     -=  Random.rand(2..15)
    self.save!
  end

  def win_a_round
    self.experience +=  Random.rand(1..10)
    self.won        +=  1
    self.perform_a_round
  end

  def loose_a_round
    self.lost       +=  1
    self.perform_a_round
  end

end
