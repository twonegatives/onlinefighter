class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, #:registerable, :recoverable,
          :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  has_many :services, :dependent => :destroy

  def self.new_with_session params, session
    if hash = session["devise.user_attributes"]
      new(hash, without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  #[:password_required?, :email_required?].each do |method_name|
  #  define_method(method_name) do
  #    super if provider.blank?
  #  end
  #end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end
