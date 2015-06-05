class CampusesController < ApplicationController
  before_action :set_campus, only: [:show, :edit, :update, :destroy]

  # GET /campuses
  # GET /campuses.json
  def index
    @campuses = Campus.order(name: :asc)
  end

  # GET /campuses/1
  # GET /campuses/1.json
  def show
  end

  # GET /campuses/new
  def new
    @campus = Campus.new
  end

  # GET /campuses/1/edit
  def edit
  end

  # POST /campuses
  # POST /campuses.json
  def create
    @campus = Campus.new(campus_params)
    @campus.slug = @campus.name.parameterize

    respond_to do |format|
      if @campus.save
        format.html { redirect_to @campus, notice: 'Campus was successfully created.' }
        format.json { render :show, status: :created, location: @campus }
      else
        format.html { render :new }
        format.json { render json: @campus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campuses/1
  # PATCH/PUT /campuses/1.json
  def update
    respond_to do |format|
      if @campus.update(campus_params)
        format.html { redirect_to @campus, notice: 'Campus was successfully updated.' }
        format.json { render :show, status: :ok, location: @campus }
      else
        format.html { render :edit }
        format.json { render json: @campus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campuses/1
  # DELETE /campuses/1.json
  def destroy
    @campus.destroy
    respond_to do |format|
      format.html { redirect_to action: 'index', status: 303, notice: 'Campus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campus
      @campus = Campus.find_by(slug: params[:slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campus_params
      params.require(:campus).permit(:name, :abbreviation, :institution_type, :director_id, :website_url, :address_1, :address_2, :city, :state, :zip, :image)
    end
end
