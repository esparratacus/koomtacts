module Users
  class ContactsFilesController < UsersController
    before_action :set_contacts_file, only: [:show, :edit, :update, :destroy,:execute_import]

    # GET /contacts_files
    # GET /contacts_files.json
    def index
      @contacts_files = current_user.contacts_files.order(:contacts).page params[:page]
    end

    def execute_import
      ImportWorker.perform_async @contacts_file.id
      redirect_to @contacts_file, notice: 'Contacts being processed'
    end

    # GET /contacts_files/1
    # GET /contacts_files/1.json
    def show
    end

    # GET /contacts_files/new
    def new
      @contacts_file = ContactsFile.new
    end

    # GET /contacts_files/1/edit
    def edit
      @custom_headers = @contacts_file.contact_file_headers
    end

    # POST /contacts_files
    # POST /contacts_files.json
    def create
      @contacts_file = current_user.contacts_files.new(contacts_file_params)
      #@contacts_file.contacts = contacts_file_params.fetch(:contacts)

      respond_to do |format|
        if @contacts_file.save
          format.html { redirect_to action: :edit, id: @contacts_file.id }
        else
          format.html { render :new }
        end
      end
    end

    # PATCH/PUT /contacts_files/1
    # PATCH/PUT /contacts_files/1.json
    def update
      respond_to do |format|
        if @contacts_file.update(contacts_file_params)
          format.html { redirect_to @contacts_file, notice: 'Contacts file was successfully updated.' }
        else
          format.html { render :show }
        end
      end
    end

    # DELETE /contacts_files/1
    # DELETE /contacts_files/1.json
    def destroy
      @contacts_file.destroy
      respond_to do |format|
        format.html { redirect_to contacts_files_url, notice: 'Contacts file was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_contacts_file
      @contacts_file = ContactsFile.includes(:importer_logs).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contacts_file_params
      params.require(:contacts).permit(:contacts_csv, :status, header_mappings:[:dob,:name,:cc_number,:phone_number,:email,:address])
    end
  end
end


