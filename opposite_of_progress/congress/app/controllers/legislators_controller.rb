class LegislatorsController < ApplicationController
  before_action :set_legislator, only: [:show, :edit, :update, :destroy]

  def index
    @results = Legislator.all
  end

  # GET /legislators/1
  # GET /legislators/1.json
  def show
  end

  # GET /legislators/1/edit
  def edit
  end

  # PATCH/PUT /legislators/1
  # PATCH/PUT /legislators/1.json
  def update
    respond_to do |format|
      if @legislator.update(legislator_params)
        format.html { redirect_to @legislator, notice: 'Legislator was successfully updated.' }
        format.json { render :show, status: :ok, location: @legislator }
      else
        format.html { render :edit }
        format.json { render json: @legislator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /legislators/1
  # DELETE /legislators/1.json
  def destroy
    @legislator.destroy
    respond_to do |format|
      format.html { redirect_to legislator_url, notice: 'Legislator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def fetch
    # http = Curl.get("https://congress.api.sunlightfoundation.com/legislators?last_name=Brown&apikey=2d3136f6874046c8ba34d5e2f1a96b03")
    # @results = JSON.parse(http.body_str)

    @results = {"results"=>[{"bioguide_id"=>"B000911", "birthday"=>"1946-11-11", "chamber"=>"house", "contact_form"=>"https://forms.house.gov/corrinebrown/webforms/contact-me.shtml", "crp_id"=>"N00002713", "district"=>5, "facebook_id"=>"179120958813519", "fax"=>"202-225-2256", "fec_ids"=>["H2FL03056", "S0FL00403"], "first_name"=>"Corrine", "gender"=>"F", "govtrack_id"=>"400048", "icpsr_id"=>29328, "in_office"=>true, "last_name"=>"Brown", "middle_name"=>nil, "name_suffix"=>nil, "nickname"=>nil, "oc_email"=>"Rep.Corrinebrown@opencongress.org", "ocd_id"=>"ocd-division/country:us/state:fl/cd:5", "office"=>"2111 Rayburn House Office Building", "party"=>"D", "phone"=>"202-225-0123", "state"=>"FL", "state_name"=>"Florida", "term_end"=>"2015-01-03", "term_start"=>"2013-01-03", "thomas_id"=>"00132", "title"=>"Rep", "twitter_id"=>"RepCorrineBrown", "votesmart_id"=>26797, "website"=>"http://corrinebrown.house.gov", "youtube_id"=>"CongresswomanBrown"}, {"bioguide_id"=>"B000944", "birthday"=>"1952-11-09", "chamber"=>"senate", "contact_form"=>"http://www.brown.senate.gov/contact", "crp_id"=>"N00003535", "district"=>nil, "facebook_id"=>nil, "fax"=>"202-228-6321", "fec_ids"=>["H2OH13033", "S6OH00163"], "first_name"=>"Sherrod", "gender"=>"M", "govtrack_id"=>"400050", "icpsr_id"=>29389, "in_office"=>true, "last_name"=>"Brown", "lis_id"=>"S307", "middle_name"=>nil, "name_suffix"=>nil, "nickname"=>nil, "oc_email"=>"Sen.Brown@opencongress.org", "ocd_id"=>"ocd-division/country:us/state:oh", "office"=>"713 Hart Senate Office Building", "party"=>"D", "phone"=>"202-224-2315", "senate_class"=>1, "state"=>"OH", "state_name"=>"Ohio", "state_rank"=>"senior", "term_end"=>"2019-01-03", "term_start"=>"2013-01-03", "thomas_id"=>"00136", "title"=>"Sen", "twitter_id"=>"SenSherrodBrown", "votesmart_id"=>27018, "website"=>"http://www.brown.senate.gov", "youtube_id"=>"SherrodBrownOhio"}], "count"=>2, "page"=>{"count"=>2, "per_page"=>20, "page"=>1}}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_legislator
      @legislator = Legislator.find(params[:id])
    end
end
