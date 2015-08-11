class EbooksController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_ebook, only: [:show, :edit, :update, :destroy, :download]
  before_action :authenticate_user_id!, only: [:edit, :update, :destroy]

  # GET /ebooks
  # GET /ebooks.json
  def index
    @ebooks = Ebook.order("lower(title)")
  end

  # GET /ebooks/1
  # GET /ebooks/1.json
  def show
  end

  # GET /ebooks/new
  def new
    @ebook = Ebook.new
  end

  # GET /ebooks/1/edit
  def edit
  end

  # POST /ebooks
  # POST /ebooks.json
  def create
    @ebook = Ebook.new(ebook_params)

    respond_to do |format|
      if @ebook.save
        EbookWorker.perform_async(@ebook.id)

        format.html { redirect_to @ebook, notice: 'Ebook was successfully created.' }
        format.json { render :show, status: :created, location: @ebook }
      else
        format.html { render :new }
        format.json { render json: @ebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ebooks/1
  # PATCH/PUT /ebooks/1.json
  def update
    respond_to do |format|
      if @ebook.update(ebook_params)
        @ebook.update(generated: false)
        EbookWorker.perform_async(@ebook.id)

        format.html { redirect_to @ebook, notice: 'Ebook was successfully updated.' }
        format.json { render :show, status: :ok, location: @ebook }
      else
        format.html { render :edit }
        format.json { render json: @ebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ebooks/1
  # DELETE /ebooks/1.json
  def destroy
    @ebook.destroy
    respond_to do |format|
      format.html { redirect_to ebooks_url, notice: 'Ebook was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Access Violation Page
  def error
  end

  def my_books
    @ebooks = current_user.ebooks.order('lower(title)')
  end

  def download
    filename = @ebook.title + "_" + @ebook.version + ".epub"
    send_data @ebook.epub, disposition: "attachment", filename: "#{filename}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ebook
      @ebook = Ebook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ebook_params
      params.require(:ebook).permit(:user_id, :title, :description, :version, :url, :generated, :language, :publisher, :subject, :rights, :readability, :markdown, :epub)
    end

    def authenticate_user_id!
      redirect_to ebook_error_path unless @ebook.user_id == current_user.id
    end
end
