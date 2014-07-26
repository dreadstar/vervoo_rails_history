class ChallengesController < ApplicationController

  # GET /challenges
  # GET /challenges.xml
  def index
    @limit = get_limit
    @offset = get_offset(params)
    @challenges_count = Challenge.count
    if !params[:sort].nil? then
      if !params[:asc].nil? then
        asc = params[:asc]
      else
        asc = ""
      end
      if params[:sort] == "alpha" then
        @challenges = Challenge.find_all_order_by_with_limit_and_offset("name", asc, true, @limit, @offset)
      elsif params[:sort] == "date" then
        @challenges = Challenge.find_all_order_by_with_limit_and_offset("start_date", asc, true, @limit, @offset)
      elsif params[:sort] == "offer" then
        @challenges = Challenge.find_all_order_by_with_limit_and_offset("total_offer", asc, true, @limit, @offset)
      elsif params[:sort] == "raised" then
        @challenges = Challenge.find_all_order_by_with_limit_and_offset("amount_raised", asc, true, @limit, @offset)
      elsif params[:sort] == "activity" then
        @challenges = Challenge.find_all_order_by_challenge_activities_date(true, asc, @limit, @offset)
      else
        @challenges = Challenge.find_all_with_limit_and_offset(true, @limit, @offset)
      end
    else
      @challenges = Challenge.find_all_with_limit_and_offset(true, @limit, @offset)
    end
    @results_pages = @challenges_count.fdiv(@limit)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @challenges }
    end
  end

  # GET /challenges/1
  # GET /challenges/1.xml
  def show
    if !params[:id].to_s.match(/^\d+$/) then
      @challenge = Challenge.find_by_seo_name_and_enabled(params[:id], true)
    else
      @challenge = Challenge.find_by_id_and_enabled(params[:id], true)
    end
    if !@challenge.nil? then
      if !session[:user_id].nil? && session[:user_id] != "" then
        @user = User.find(session[:user_id])
        @user_activities = UserActivity.find_all_by_user_id_and_challenge(@user.id, @challenge)
      end
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @challenge }
      end
    else
      flash[:error_message] = "This challenge is not active."
      respond_to do |format|
        format.html { render "errors/index" }
        format.xml  { render :xml => flash[:error_message] }
      end
    end
  end

  # GET /challenges/new
  # GET /challenges/new.xml
  def new
    @challenge = Challenge.new
    @charities = Charity.find(:all, :order => :name)
    @sponsors = Sponsor.find(:all, :order => :name)
    @activities = Activity.find(:all, :order => :name)
    @tags = Tag.find(:all, :order => :name)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @challenge }
    end
  end

  # GET /challenges/1/edit
  def edit
    if !params[:id].to_s.match(/^\d+$/) then
      challenge = Challenge.find_by_seo_name_and_enabled(params[:id], true)
    else
      challenge = Challenge.find_by_id_and_enabled(params[:id], true)
    end
    if !challenge.nil? && challenge.user.id.to_s == session[:user_id].to_s then
      @challenge = challenge
      @charities = Charity.find(:all, :order => :name)
      @sponsors = Sponsor.find(:all, :order => :name)
      @activities = Activity.find(:all, :order => :name)
      @tags = Tag.find(:all, :order => :name)
    else
      flash[:error_message] = "You cannot edit this challenge."
      respond_to do |format|
        format.html { render "errors/index" }
        format.xml  { render :xml => flash[:error_message] }
      end
    end
  end

  # POST /challenges
  # POST /challenges.xml
  def create
    @challenge = Challenge.new(params[:challenge])
    if !params[:challenge][:challenge_img].nil? && params[:challenge][:challenge_img] != "" then
      uploaded_io = params[:challenge][:challenge_img]
      if uploaded_io != "" then
        upload_dir = image_upload_path + "challenges/#{@challenge.id}/"
        if !File.exists?(upload_dir) then
          Dir.mkdir(upload_dir)
        end
        File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
          file.write(uploaded_io.read)
          params[:challenge][:challenge_img] = "/uploads/challenges/#{@challenge.id}/" + File.basename( file.path )
        end
      end
    end
    respond_to do |format|
      if @challenge.save then
        flash[:notice] = 'Challenge was successfully created.'
        format.html { redirect_to(@challenge) }
        format.xml  { render :xml => @challenge, :status => :created, :location => @challenge }
      else
        @charities = Charity.find(:all, :order => :name)
        @sponsors = Sponsor.find(:all, :order => :name)
        @activities = Activity.find(:all, :order => :name)
        @tags = Tag.find(:all, :order => :name)
        format.html { render :action => "new", :locals => { :charities => @charities,:sponsors => @sponsors, :activities => @activities, :tags => @tags } }
        format.xml  { render :xml => @challenge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /challenges/1
  # PUT /challenges/1.xml
  def update
    @challenge = Challenge.find_by_id_and_enabled(params[:id], true)
    if !@challenge.nil? && @challenge.user.id.to_s == session[:user_id].to_s then
      if !params[:challenge][:challenge_img].nil? && params[:challenge][:challenge_img] != "" then
        uploaded_io = params[:challenge][:challenge_img]
        if uploaded_io != "" then
          upload_dir = image_upload_path + "challenges/#{@challenge.id}/"
        if !File.exists?(upload_dir) then
          Dir.mkdir(upload_dir)
        end
          File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
            file.write(uploaded_io.read)
            params[:challenge][:challenge_img] = "/uploads/challenges/#{@challenge.id}/" + File.basename( file.path )
          end
        end
      end
      respond_to do |format|
        if @challenge.update_attributes(params[:challenge]) then
          flash[:notice] = 'Challenge was successfully updated.'
          format.html { redirect_to(@challenge) }
          format.xml  { head :ok }
        else
          @charities = Charity.find(:all, :order => :name)
          @sponsors = Sponsor.find(:all, :order => :name)
          @activities = Activity.find(:all, :order => :name)
          @tags = Tag.find(:all, :order => :name)
          format.html { render :action => "edit", :locals => { :charities => @charities, :sponsors => @sponsors, :activities => @activities, :tags => @tags } }
          format.xml  { render :xml => @challenge.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:error_message] = "You cannot update this challenge."
      respond_to do |format|
        format.html { render "errors/index" }
        format.xml  { render :xml => flash[:error_message] }
      end
    end
  end

  protected
  def secure?
    ["new","edit","create","update"].include?(action_name)
  end

end
