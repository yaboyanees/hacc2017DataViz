class GrantsController < ApplicationController
  before_action :set_grant, only: [:show]
  
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
	
	#These are arrays of the unique values for each parameter. Unique locations, unique fiscal years...
	@uLocations = @grants.select(:location).distinct.pluck(:location)	
	@uYears = @grants.select(:fiscal_year).distinct.order(:fiscal_year).pluck(:fiscal_year)
	
	@sumLocations = Array.new
	@uLocations.each do |loc|
		@sumLocations.push(@grants.where(location: loc).sum("amount").to_f)
	end
		
	#TODO: 2-d array of grants by year, and then by location, specifying amount
	@amountPerYearByLocation = Array.new
	@uLocations.each do |loc|
			@locArray = Array.new
			@uYears.each do |year|
				@locArray.push(@grants.where(location: loc).where(fiscal_year: year).sum("amount").to_f)
			end
			@amountPerYearByLocation.push(@locArray)
	end

#Random Queries that may or may not be adopted	
#fy query
=begin
@fy13 = @grants.where("fiscal_year = ?", 2013)
@fy14 = @grants.where("fiscal_year = ?", 2014)
@fy15 = @grants.where("fiscal_year = ?", 2015)
@fy16 = @grants.where("fiscal_year = ?", 2016)

#by grant type query
@ahahui = @grants.where("grant_type = ?", "Ahahui")
@bot = @grants.where("grant_type = ?", "BOT Initiative")
@community_grant = @grants.where("grant_type = ?", "Community Grant")
@sponsorship = @grants.where("grant_type = ?", "Sponsorship")

#by strategic priority
@land = @grants.where("strategic_priority = ?", "Land & Water")
@edu = @grants.where("strategic_priority = ?", "Education")
@eco = @grants.where("strategic_priority = ?", "Economic Self-Sufficiency").count
@health = @grants.where("strategic_priority = ?", "Health")
@gov = @grants.where("strategic_priority = ?", "Governance")
@culture = @grants.where("strategic_priority = ?", "Culture")
=end
		
 
 	#export to all data to excel
	respond_to do |f|
		f.html
		f.xls
		f.pdf do
			render :pdf => "Report Pulled on" + " " + "#{Time.now.strftime("%m/%d/%Y")}", :orientation => 'Landscape'
		end
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
