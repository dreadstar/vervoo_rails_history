class Manage::UserActivitiesController < ApplicationController
  layout "manage_layout"

  # GET /manage/user_activities
  # GET /manage/user_activities.xml
  def index
    @limit = get_limit
    @offset = get_offset(params)
    @user_activities_count = UserActivity.count
    @user_activities = UserActivity.find(:all, :limit => @limit, :offset => @offset )
    @results_pages = @user_activities_count.fdiv(@limit)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_activities }
    end
  end

  # GET /manage/user_activities/1
  # GET /manage/user_activities/1.xml
  def show
    @user_activity = UserActivity.find(params[:id])
  end

  # GET /manage/user_activities/new
  # GET /manage/user_activities/new.xml
  def new
    @users = User.find(:all)
    @challenge_activities = ChallengeActivity.find(:all)
    @user_activity = UserActivity.new
  end

  # GET /manage/user_activities/1/edit
  def edit
    @users = User.find(:all)
    @challenge_activities = ChallengeActivity.find(:all)
    @user_activity = UserActivity.find(params[:id])
  end

  # POST /manage/user_activities
  # POST /manage/user_activities.xml
  def create
    @user_activity = UserActivity.new(params[:user_activity])
    respond_to do |format|
      if @user_activity.save
        flash[:notice] = 'UserActivity was successfully created.'
        format.html { redirect_to([:manage, @user_activity]) }
        format.xml  { render :xml => @user_activity, :status => :created, :location => @user_activity }
      else
        @users = User.find(:all)
        @challenge_activities = ChallengeActivity.find(:all)
        format.html { render :action => "new", :locals => { :users => @users, :challenge_activities => @challenge_activities } }
        format.xml  { render :xml => @user_activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /manage/user_activities/1
  # PUT /manage/user_activities/1.xml
  def update
    @user_activity = UserActivity.find(params[:id])
    respond_to do |format|
      if @user_activity.update_attributes(params[:user_activity])
        flash[:notice] = 'UserActivity was successfully updated.'
        format.html { redirect_to([:manage, @user_activity]) }
        format.xml  { head :ok }
      else
        @users = User.find(:all)
        @challenge_activities = ChallengeActivity.find(:all)
        format.html { render :action => "edit", :locals => { :users => @users, :challenge_activities => @challenge_activities } }
        format.xml  { render :xml => @user_activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  protected
  def secure_manage?
    ["index","show","new","edit","create","update"].include?(action_name)
  end

end