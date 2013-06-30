#encoding:utf-8
class Character < ActiveRecord::Base
  attr_accessible :character_type_id, :health, :experience, :lost, :defence, :attack, :magic, :user_id
  attr_readonly :won_battles_count
  belongs_to :character_type
  has_many :items
  belongs_to :user

  validates :character_type_id, :health, :experience, :lost, :defence, :attack, :magic, :presence => true

  before_validation :set_character_type_defaults, :on => :create
  before_validation :set_current_health_to_zero, :if => lambda{|i| i.health < 0}
  before_create :give_two_equal_items

  has_many :won_battles, :class_name => 'Battle', :foreign_key => 'winner_id'

  def set_current_health_to_zero
    self.health = 0
  end

  def battles
    Battle.where("fighter1_id = #{self.id} OR fighter2_id = #{self.id}")
  end

  def set_character_type_defaults
    if type = self.character_type
      [:defence, :attack, :magic].each do |attribute|
        self.send %Q{#{attribute}=}, type.try(attribute)
      end
      self.health = type.max_health
    end
  end

  def give_two_equal_items
    item_hash = { :character_type_id => self.character_type_id,
                  :increasable_id    => Random.rand(Item::INCREASABLES.size),
                  :increase_value    => Random.rand(1..5),
                  :item_type_id      => Random.rand(Item::ITEM_TYPES.size),
                  :is_equipped       => false
                }
    2.times{|time| self.items.build(item_hash)}
  end

  def perform_a_round
    self.health     -=  Random.rand(1..7)
    self.save!
  end

  def win_a_round
    self.experience +=  Random.rand(1..10)
    self.perform_a_round
  end

  def loose_a_round
    self.lost       +=  1
    self.perform_a_round
  end

end
