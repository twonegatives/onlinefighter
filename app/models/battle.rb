class Battle < ActiveRecord::Base
  attr_accessible :fighter1_id, :fighter2_id, :winner_id
  belongs_to :fighter1, :class_name => 'Character', :foreign_key => :fighter1_id
  belongs_to :fighter2, :class_name => 'Character', :foreign_key => :fighter2_id
  belongs_to :winner,   :class_name => 'Character', :foreign_key => :winner_id, :counter_cache => :won_battles_count

  validates :fighter1_id, :fighter2_id, :winner_id, :presence => true
  validates :winner_id, :inclusion => {:in => Proc.new{|battle| [battle.fighter1_id, battle.fighter2_id]}, :message => 'Winner should be the one of battle participants.'}
  validate :fighter1_and_fighter2_differ

  after_create :update_fighters

  def fighter1_and_fighter2_differ
    self.errors['base'] << 'Fighting with self is not allowed' if self.fighter1_id == self.fighter2_id
  end

  def update_fighters
    self.winner.win_a_round
    looser_id = [self.fighter1_id, self.fighter2_id].find{|i| i != self.winner_id}
    Character.find(looser_id).loose_a_round
  end
end
