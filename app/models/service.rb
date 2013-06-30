class Service < ActiveRecord::Base
  attr_accessible :provider, :uemail, :uid, :uname, :user_id
  belongs_to :user

  validate :provider_and_uid_are_uniq
  validates :provider, :uid, :presence => true

  def provider_and_uid_are_uniq
    services_like_this = Service.where(:provider => self.provider, :uid => self.uid)
    services_like_this = services_like_this.where('id != ?', self.id) if self.id.present?
    self.errors['base'] << "This uid for #{self.provider} is already in use." unless services_like_this.count.zero?
  end
end
