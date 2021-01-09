module Users
  class ContactsController < UsersController
    def index
      @contacts = current_user.contacts.order(:name).page params[:page]
    end
  end
end