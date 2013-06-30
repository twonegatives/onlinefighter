class ServicesController < ApplicationController
  def create
    service         = Service.new(params['service'])
    service.user_id = current_user.id
    flash.alert     = service.errors.full_messages.join(', ') unless service.save
    redirect_to edit_user_registration_path
  end

  def destroy
    Service.where(:id => params['id'], :user_id => current_user.id).destroy_all
    redirect_to edit_user_registration_path
  end
end
