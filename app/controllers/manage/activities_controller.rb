class Manage::ActivitiesController < ApplicationController
  layout "manage_layout"

  # GET /manage/activities
  # GET /manage/activities.xml
  def index
    @limit = get_limit
    @offset = get_offset(params)
    @activities_count = Activity.count
    if !params[:sort].nil? then
      if !params[:asc].nil? then
        asc = params[:asc]
      else
        asc = ""
      end
      if params[:sort] == "alpha" then
        @activities = Activity.find(:all, :order => "name " + asc, :limit => @limit, :offset => @offset )
      elsif params[:sort] == "date" then
        @activities = Activity.find(:all, :order => "created_at " + asc, :limit => @limit, :offset => @offset )
      else
        @activities = Activity.find(:all, :limit => @limit, :offset => @offset )
      end
    else
      @activities = Activity.find(:all, :limit => @limit, :offset => @offset )
    end
    @results_pages = @activities_count.fdiv(@limit)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end

  # GET /manage/activities/1
  # GET /manage/activities/1.xml
  def show
    @activity = Activity.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  # GET /manage/activities/new
  # GET /manage/activities/new.xml
  def new
    @activity = Activity.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  # GET /manage/activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
  end

  # POST /manage/activities
  # POST /manage/activities.xml
  def create
    @activity = Activity.new(params[:activity])
    respond_to do |format|
      if @activity.save
        @activity.update_attribute(:enabled,params[:activity][:enabled])
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to([:manage, @activity]) }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
      else
        format.html { render :activity => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /manage/activities/1
  # PUT /manage/activities/1.xml
  def update
    @activity = Activity.find(params[:id])
    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        @activity.update_attribute(:enabled,params[:activity][:enabled])
        flash[:notice] = 'Activity was successfully updated.'
        format.html { redirect_to([:manage, @activity]) }
        format.xml  { head :ok }
      else
        format.html { render :activity => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/activities/1
  # DELETE /manage/activities/1.xml
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to([:manage, activities_url]) }
      format.xml  { head :ok }
    end
  end

  protected
  def secure_manage?
    ["index","show","new","edit","create","update","destroy"].include?(action_name)
  end
  
end
