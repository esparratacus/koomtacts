module Api::V1
  class ContactsFilesController < ApiController
    before_action :authorized
    def index
      @contacts_files = current_user.contacts_files.page params[:page]
      render json: ContactsFileSerializer.new(@contacts_files).serializable_hash.to_json, status: :ok
    end

    def create
      @contacts_file = current_user.contacts_files.create!(contacts_file_params)
      render json: ContactsFileSerializer.new(@contacts_file).serializable_hash.to_json, status: :created
    end

    def update
      @contacts_file = current_user.contacts_files.includes(:importer_logs).find(params[:id])
      @contacts_file.update(contacts_file_params)
      render json: ContactsFileSerializer.new(@contacts_file).serializable_hash.to_json, status: :ok
    end

    def destroy
      @contacts_file = current_user.contacts_files.includes(:importer_logs).find(params[:id])
      @contacts_file.destroy
    end

    def contacts_file_params
      params.require(:contacts_file).permit(:contacts_csv, :status, header_mappings:[:dob,:name,:cc_number,:phone_number,:email,:address])
    end
  end
end