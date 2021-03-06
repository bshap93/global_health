class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
    @projects = current_user.projects
    @project_name = session[:project_name]
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    @projects = current_user.projects
    @project_name = session[:project_name]

    respond_to do |format|
      if @location.save && params[:finish]
        format.html { redirect_to projects_path, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      elsif @location.save && params[:another]
        format.html { redirect_to new_location_path }
      else
        format.html { redirect_to new_location_path}
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update

    @projects = current_user.projects
    @project_name = session[:project_name]
    respond_to do |format|
      if @location.save && params[:finish]
        format.html { redirect_to projects_path, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      elsif @location.save && params[:another]
        format.html { redirect_to new_location_path }
      else
        format.html { redirect_to new_location_path}
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:latitude, :longitude, :project_id, :country_id, :name)
    end
end
