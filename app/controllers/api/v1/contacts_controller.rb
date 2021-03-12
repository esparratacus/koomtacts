module Api::V1
  class ContactsController < ApiController
    before_action :authorized
    def index
      @contacts = current_user.contacts.order(:name).page params[:page]
      render json: ContactSerializer.new(@contacts).serializable_hash.to_json, status: :ok
    end
  end
end