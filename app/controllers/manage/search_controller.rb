class Manage::SearchController < ApplicationController
  layout "manage_layout"

  # GET /manage/search/activities
  # GET /manage/search/activities.xml
  def activities
    @limit = get_limit
    @offset = get_offset(params)
    if !params[:keyword].nil?
      @results_count = Activity.count(:conditions => [ "name like :kw or description like :kw", { :kw => "%" + params[:keyword].to_s + "%" }])
      @activities = Activity.find(:all,
                                :conditions => [ "name like :kw or description like :kw", { :kw => "%" + params[:keyword].to_s + "%" }],
                                :limit => @limit,
                                :offset => @offset)
    end
    @results_pages = @results_count.fdiv(@limit)
    respond_to do |format|
      format.html { render "manage/activities/index" }
      format.xml  { render :xml => @activities }
    end
  end

  # GET /manage/search/challenges
  # GET /manage/search/challenges.xml
  def challenges
    @limit = get_limit
    @offset = get_offset(params)
    if !params[:keyword].nil?
      @results_count = Challenge.count(:conditions => [ "name like :kw or description like :kw", { :kw => "%" + params[:keyword].to_s + "%" }])
      @challenges = Challenge.find(:all,
                                :conditions => [ "name like :kw or description like :kw", { :kw => "%" + params[:keyword].to_s + "%" }],
                                :limit => @limit,
                                :offset => @offset)
    end
    @results_pages = @results_count.fdiv(@limit)
    respond_to do |format|
      format.html { render "manage/challenges/index" }
      format.xml  { render :xml => @challenges }
    end
  end

  # GET /manage/search/charities
  # GET /manage/search/charities.xml
  def charities
    @limit = get_limit
    @offset = get_offset(params)
    if !params[:keyword].nil?
      @results_count = Charity.count(:conditions => [ "name like :kw or email like :kw", { :kw => "%" + params[:keyword].to_s + "%" }])
      @charities = Charity.find(:all,
                                :conditions => [ "name like :kw or email like :kw", { :kw => "%" + params[:keyword].to_s + "%" }],
                                :limit => @limit,
                                :offset => @offset)
    end
    @results_pages = @results_count.fdiv(@limit)
    respond_to do |format|
      format.html { render "manage/charities/index" }
      format.xml  { render :xml => @charities }
    end
  end

  # GET /manage/search/sponsors
  # GET /manage/search/sponsors.xml
  def sponsors
    @limit = get_limit
    @offset = get_offset(params)
    if !params[:keyword].nil?
      @results_count = Sponsor.count(:conditions => [ "name like :kw or email like :kw", { :kw => "%" + params[:keyword].to_s + "%" }])
      @sponsors = Sponsor.find(:all,
                                :conditions => [ "name like :kw or email like :kw", { :kw => "%" + params[:keyword].to_s + "%" }],
                                :limit => @limit,
                                :offset => @offset)
    end
    @results_pages = @results_count.fdiv(@limit)
    respond_to do |format|
      format.html { render "manage/sponsors/index" }
      format.xml  { render :xml => @sponsors }
    end
  end

  # GET /manage/search/user_activities
  # GET /manage/search/user_activities.xml
  def user_activities
    @limit = get_limit
    @offset = get_offset(params)
    if !params[:keyword].nil?
      @results_count = UserActivity.count(:conditions => [ "activity_data like :kw", { :kw => "%" + params[:keyword].to_s + "%" }])
      @user_activities = UserActivity.find(:all,
                                           :conditions => [ "activity_data like :kw", { :kw => "%" + params[:keyword].to_s + "%" }],
                                           :limit => @limit,
                                           :offset => @offset)
    end
    @results_pages = @results_count.fdiv(@limit)
    respond_to do |format|
      format.html { render "manage/user_activities/index" }
      format.xml  { render :xml => @user_activities }
    end
  end

  # GET /manage/search/users
  # GET /manage/search/users.xml
  def users
    @limit = get_limit
    @offset = get_offset(params)
    if !params[:keyword].nil?
      @results_count = User.count(:conditions => [ "email like :kw or first_name like :kw or last_name like :kw", { :kw => "%" + params[:keyword].to_s + "%" }])
      @users = User.find(:all,
                         :conditions => [ "email like :kw or first_name like :kw or last_name like :kw", { :kw => "%" + params[:keyword].to_s + "%" }],
                         :limit => @limit,
                         :offset => @offset)
    end
    @results_pages = @results_count.fdiv(@limit)
    respond_to do |format|
      format.html { render "manage/users/index" }
      format.xml  { render :xml => @users }
    end
  end

end
