class Service < ActiveRecord::Base
  attr_accessible :provider, :uemail, :uid, :uname, :user_id
  belongs_to :user
end
