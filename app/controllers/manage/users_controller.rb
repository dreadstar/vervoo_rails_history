class Manage::UsersController < ApplicationController
  layout "manage_layout"

  # GET /manage/users
  # GET /manage/users.xml
  def index
    @limit = get_limit
    @offset = get_offset(params)
    @users_count = UserActivity.count
    @users = User.find(:all, :limit => @limit, :offset => @offset )
    @results_pages = @users_count.fdiv(@limit)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml }
    end
  end

  # GET /manage/users/1
  # GET /manage/users/1.xml
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /manage/users/new
  # GET /manage/users/new.xml
  #def new
  #  @user = User.new
  #  @states = State.find(:all, :order => :name)
  #  @countries = Country.find(:all, :conditions => { :printable_name => "United States" }, :order => :printable_name)
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.xml  { render :xml => @user }
  #  end
  #end

  # GET /manage/users/1/edit
  def edit
    @user = User.find(params[:id])
    @user.password_confirmation = @user.password
    @roles = Role.find(:all)
    @states = State.find(:all, :order => :name)
    @countries = Country.find(:all, :conditions => { :printable_name => "United States" }, :order => :printable_name)
  end

  # POST /manage/users
  # POST /manage/users.xml
  #def create
  #  @user = User.new(params[:user])
  #  respond_to do |format|
  #    if @user.save
  #      @user.update_attribute(:enabled, params[:user][:enabled])
  #      params[:user_role] = Hash.new
  #      params[:user_role][:user_id] = @user.id
  #      params[:user_role][:role_id] = Role.find_by_name("USER").id
  #      @user_role = UserRole.new(params[:user_role])
  #      @user_role.save
  #      flash[:notice] = 'User was successfully created.'
  #      format.html { redirect_to([:manage, @user]) }
  #      format.xml  { render :xml => @user, :status => :created, :location => @user }
  #    else
  #      @user.password_confirmation = @user.password
  #      @roles = Role.find(:all)
  #      @states = State.find(:all, :order => :name)
  #      @countries = Country.find(:all, :conditions => { :printable_name => "United States" }, :order => :printable_name)
  #      format.html { render :action => "new", :locals => { :roles => @roles, :states => @states, :countries => @countries } }
  #      format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end

  # PUT /manage/users/1
  # PUT /manage/users/1.xml
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        @user.update_attribute(:enabled, params[:user][:enabled])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to([:manage, @user]) }
        format.xml  { head :ok }
      else
        @user.password_confirmation = @user.password
        @roles = Role.find(:all)
        @states = State.find(:all, :order => :name)
        @countries = Country.find(:all, :conditions => { :printable_name => "United States" }, :order => :printable_name)
        format.html { render :action => "edit", :locals => { :roles => @roles, :states => @states, :countries => @countries } }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/users/1
  # DELETE /manage/users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to(manage_users_url) }
      format.xml  { head :ok }
    end
  end

  protected
  def secure_manage?
    ["index","search","show","new","edit","update","destroy"].include?(action_name)
  end

end
