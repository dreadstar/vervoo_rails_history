class Manage::ChallengesController < ApplicationController
  layout "manage_layout"

  # GET /manage/challenges
  # GET /manage/challenges.xml
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
        @challenges = Challenge.find_all_order_by_with_limit_and_offset("name", asc, "", @limit, @offset)
      elsif params[:sort] == "date" then
        @challenges = Challenge.find_all_order_by_with_limit_and_offset("start_date", asc, "", @limit, @offset)
      elsif params[:sort] == "offer" then
        @challenges = Challenge.find_all_order_by_with_limit_and_offset("total_offer", asc, "", @limit, @offset)
      elsif params[:sort] == "raised" then
        @challenges = Challenge.find_all_order_by_with_limit_and_offset("amount_raised", asc, "", @limit, @offset)
      elsif params[:sort] == "activity" then
        @challenges = Challenge.find_all_order_by_challenge_activities_date("", asc, @limit, @offset)
      else
        @challenges = Challenge.find_all_with_limit_and_offset("", @limit, @offset)
      end
    else
      @challenges = Challenge.find_all_with_limit_and_offset("", @limit, @offset)
    end
    @results_pages = @challenges_count.fdiv(@limit)
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @challenges }
    end
  end

  # GET /manage/challenges/1
  # GET /manage/challenges/1.xml
  def show
    if !params[:id].to_s.match(/^\d+$/)
      @challenge = Challenge.find_by_seo_name(params[:id])
    else
      @challenge = Challenge.find(params[:id])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @challenge }
    end
  end

  # GET /manage/challenges/new
  # GET /manage/challenges/new.xml
  def new
    @challenge = Challenge.new
    @charities = Charity.find(:all, :order => :name)
    @sponsors = Sponsor.find(:all, :order => :name)
    @activities = Activity.find(:all, :order => :name)
    @tags = Tag.find(:all, :order => :name)
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @challenge }
    end
  end

  # GET /manage/challenges/1/edit
  def edit
    if !params[:id].to_s.match(/^\d+$/)
      @challenge = Challenge.find_by_seo_name(params[:id])
    else
      @challenge = Challenge.find(params[:id])
    end
    @charities = Charity.find(:all, :order => :name)
    @sponsors = Sponsor.find(:all, :order => :name)
    @activities = Activity.find(:all, :order => :name)
    @tags = Tag.find(:all, :order => :name)
  end

  # POST /manage/challenges
  # POST /manage/challenges.xml
  def create
    @challenge = Challenge.new(params[:challenge])

    respond_to do |format|
      if @challenge.save then
        if !params[:challenge][:challenge_img].nil? && params[:challenge][:challenge_img] != "" then
          uploaded_io = params[:challenge][:challenge_img]
          if uploaded_io != "" then
            upload_dir = image_upload_path + "challenges/#{@challenge.id}/"
            if !File.exists?(upload_dir) then
              Dir.mkdir(upload_dir)
            end
            File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
              file.write(uploaded_io.read)
              params[:challenge][:challenge_img] = "/uploads/challenges/#{@challenge.id}/" + File.basename(file.path)
            end
          end
        end
        if !params[:challenge][:img_thumb_url].nil? && params[:challenge][:img_thumb_url] != "" then
          uploaded_io = params[:challenge][:img_thumb_url]
          if uploaded_io != "" then
            upload_dir = image_upload_path + "challenges/#{@challenge.id}/"
            if !File.exists?(upload_dir) then
              Dir.mkdir(upload_dir)
            end
            File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
              file.write(uploaded_io.read)
              params[:challenge][:img_thumb_url] = "/uploads/challenges/#{@challenge.id}/" + File.basename(file.path)
            end
          end
        end
        @challenge.update_attribute(:challenge_img,params[:challenge][:challenge_img])
        @challenge.update_attribute(:img_thumb_url,params[:challenge][:img_thumb_url])
        @challenge.update_attribute(:enabled, params[:challenge][:enabled])
        flash[:notice] = 'Challenge was successfully created.'
        format.html { redirect_to([:manage, @challenge]) }
        format.xml { render :xml => @challenge, :status => :created, :location => @challenge }
      else
        @charities = Charity.find(:all, :order => :name)
        @sponsors = Sponsor.find(:all, :order => :name)
        @activities = Activity.find(:all, :order => :name)
        @tags = Tag.find(:all, :order => :name)
        format.html { render :action => "new", :locals => {:charities => @charities, :sponsors => @sponsors, :activities => @activities, :tags => @tags} }
        format.xml { render :xml => @challenge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /manage/challenges/1
  # PUT /manage/challenges/1.xml
  def update
    @challenge = Challenge.find(params[:id])
    if !params[:challenge][:challenge_img].nil? && params[:challenge][:challenge_img] != "" then
      uploaded_io = params[:challenge][:challenge_img]
      if uploaded_io != "" then
        upload_dir = image_upload_path + "challenges/#{@challenge.id}/"
        if !File.exists?(upload_dir) then
          Dir.mkdir(upload_dir)
        end
        File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
          file.write(uploaded_io.read)
          params[:challenge][:challenge_img] = "/uploads/challenges/#{@challenge.id}/" + File.basename(file.path)
        end
      end
    end
    if !params[:challenge][:img_thumb_url].nil? && params[:challenge][:img_thumb_url] != "" then
      uploaded_io = params[:challenge][:img_thumb_url]
      if uploaded_io != "" then
        upload_dir = image_upload_path + "challenges/#{@challenge.id}/"
        if !File.exists?(upload_dir) then
          Dir.mkdir(upload_dir)
        end
        File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
          file.write(uploaded_io.read)
          params[:challenge][:img_thumb_url] = "/uploads/challenges/#{@challenge.id}/" + File.basename(file.path)
        end
      end
    end
    respond_to do |format|
      if @challenge.update_attributes(params[:challenge]) then
        @challenge.update_attribute(:enabled, params[:challenge][:enabled])
        flash[:notice] = 'Challenge was successfully updated.'
        format.html { redirect_to([:manage, @challenge]) }
        format.xml { head :ok }
      else
        @charities = Charity.find(:all, :order => :name)
        @sponsors = Sponsor.find(:all, :order => :name)
        @activities = Activity.find(:all, :order => :name)
        @tags = Tag.find(:all, :order => :name)
        format.html { render :action => "edit", :locals => {:charities => @charities, :sponsors => @sponsors, :activities => @activities, :tags => @tags} }
        format.xml { render :xml => @challenge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/challenges/1
  # DELETE /manage/challenges/1.xml
  def destroy
    if !params[:id].to_s.match(/^\d+$/)
      @challenge = Challenge.find_by_seo_name(params[:id])
    else
      @challenge = Challenge.find(params[:id])
    end
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to([:manage, challenges_url]) }
      format.xml { head :ok }
    end
  end

  protected
  def secure_manage?
    ["index", "show", "new", "edit", "create", "update", "destroy"].include?(action_name)
  end

end
