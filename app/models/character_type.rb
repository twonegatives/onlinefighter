class CharacterType < ActiveRecord::Base
  attr_accessible :attack, :defence, :magic, :max_health, :name
  has_many :characters
  has_many :items

  validates :attack, :defence, :magic, :max_health, :name, :presence => true
end
