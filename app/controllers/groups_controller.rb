class GroupsController < ApplicationController

  # GET /groups
  # GET /groups.xml
  def index
    @groups = Group.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id])
    user_in_this_group = false
    if session[:group_users]
      session[:group_users].each do |sgu|
        @group.group_users.each do |ggu|
          if sgu.id == ggu.id
            user_in_this_group = true
          end
        end
      end
    end
    if session[:user_id] && user_in_this_group
      # Today's date for selecting the current season_week
      query_date = Time.now.year.to_s + "-" + Time.now.month.to_s + "-" + Time.now.day.to_s
      @season_week = SeasonWeek.find_current_season_week(query_date)
      # Group Standings Table
      @weeks = Week.find(:all)
      @sorted_season_grid = Pick.find_sorted_season_grid(@group.id, @season_week.season_id, @group.group_users)
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    if session[:user_id]
      @group = Group.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @group }
      end
    else
      render :partial => "includes/error", :locals => { :error_message => "You can only create a group if you are registered and logged in." }
    end
  end

  # POST /groups
  # POST /groups.xml
  def create
    if session[:user_id]
      @group = Group.new(params[:group])

      respond_to do |format|
        if @group.save
          @group_user = GroupUser.new(:group_id => @group.id, :user_id => @group.creator_user_id, :administrator => 1)
          @group_user.save
          group_users = GroupUser.find_all_by_user_id(@group.creator_user_id)
          session[:group_users] = GroupUser.find_all_by_user_id(@group.creator_user_id)
          if group_users.length == 1
            session[:group_user] = group_users[0]
          end
          flash[:notice] = "Group was successfully created."
          format.html { redirect_to(@group) }
          format.xml  { render :xml => @group, :status => :created, :location => @group }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
        end
      end
    else
      render :partial => "includes/error", :locals => { :error_message => "You can only create a group if you are registered and logged in." }
    end
  end

end
