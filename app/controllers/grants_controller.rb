class GrantsController < ApplicationController
  before_action :set_grant, only: [:show, :edit, :update, :destroy]
  
  #rudimentary authentication
  http_basic_authenticate_with name: "oha", password: "progress_bars", except: :index

  #mass upload of data
  def import
  	Grant.import(params[:file])
    respond_to do |format|
      format.html { redirect_to grants_url, notice: 'Successful Upload!' }
      format.json { head :no_content }
    end
  end

  def kill
  	@all = Grant.all
    @all.each do |t|
    	t.destroy
	end
    respond_to do |format|
      format.html { redirect_to grants_url, notice: 'All Grant Data was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
    
  # GET /grants
  # GET /grants.json
  def index
    @grants = Grant.all
    @grant_count = @grants.count
    @year_count = @grants.group(:fiscal_year).order(:fiscal_year).count
    @grant_type_count = @grants.group(:grant_type).order(:grant_type).count
    @strategic_priority_count = @grants.group(:strategic_priority).order(:strategic_priority).count
	@strategic_results_count = @grants.group(:strategic_results).order(:strategic_results).count
	@location_count = @grants.group(:location).order(:location).count
	
	#fy query
    @fy13 = @grants.where("fiscal_year = ?", 2013)
    @fy14 = @grants.where("fiscal_year = ?", 2014)
    @fy15 = @grants.where("fiscal_year = ?", 2015)
    @fy16 = @grants.where("fiscal_year = ?", 2016)
    
    #by grant type query
    @ahahui = @grants.where("grant_type = ?", "Ahahui").count
    @bot = @grants.where("grant_type = ?", "BOT Initiative").count
    @community_grant = @grants.where("grant_type = ?", "Community Grant").count
    @sponsorship = @grants.where("grant_type = ?", "Sponsorship").count
    
    #by strategic priority
    @land = @grants.where("strategic_priority = ?", "Land & Water").count
    @edu = @grants.where("strategic_priority = ?", "Education").count
    @eco = @grants.where("strategic_priority = ?", "Economic Self-Sufficiency").count
    @health = @grants.where("strategic_priority = ?", "Health").count
    @gov = @grants.where("strategic_priority = ?", "Governance").count
    @culture = @grants.where("strategic_priority = ?", "Culture").count
 
 	#export to all data to excel
	respond_to do |f|
		f.html
		f.xls
		f.pdf do
			render :pdf => "Report Pulled on" + " " + "#{Time.now.strftime("%m/%d/%Y")}", :orientation => 'Landscape'
		end
    end
 
  end

  # GET /grants/1
  # GET /grants/1.json
  def show
  end

  # GET /grants/new
  def new
    @grant = Grant.new
  end

  # GET /grants/1/edit
  def edit
  end

  # POST /grants
  # POST /grants.json
  def create
    @grant = Grant.new(grant_params)

    respond_to do |format|
      if @grant.save
        format.html { redirect_to grants_url, notice: 'Grant was successfully created.' }
        format.json { render :index, status: :created, location: @grant }
      else
        format.html { render :new }
        format.json { render json: @grant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grants/1
  # PATCH/PUT /grants/1.json
  def update
    respond_to do |format|
      if @grant.update(grant_params)
        format.html { redirect_to grants_url, notice: 'Grant was successfully updated.' }
        format.json { render :index, status: :ok, location: @grant }
      else
        format.html { render :edit }
        format.json { render json: @grant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grants/1
  # DELETE /grants/1.json
  def destroy
    @grant.destroy
    respond_to do |format|
      format.html { redirect_to grants_url, notice: 'Grant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grant
      @grant = Grant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grant_params
      params.require(:grant).permit(:fiscal_year, :grant_type, :organization, :project, :amount, :location, :strategic_priority, :strategic_results, :total_served, :nh_served, :grantStatusID)
    end
end
