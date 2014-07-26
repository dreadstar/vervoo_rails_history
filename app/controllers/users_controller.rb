class UsersController < ApplicationController

  # GET /users/1
  # GET /users/1.xml
  def show
    if !params[:id].nil? then
      @user = User.find(params[:id])
    else
      @user = User.find(session[:user_id])
    end
    #@group_users = GroupUser.find_all_by_user_id(params[:id])
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if session[:user_id].to_s == params[:id].to_s then
      @user = User.find(params[:id])
      @states = State.find(:all, :order => :name)
      @countries = Country.find(:all, :conditions => { :printable_name => "United States" }, :order => :printable_name)
    else
      flash[:error_message] = "You can only edit your own profile."
      render "errors/index"
    end
  end

  # POST /users
  # POST /users.xml
  def create
    params[:user][:ip_address] = request.remote_ip
    params[:user][:last_login] = DateTime.now
    if !params[:user][:floater].nil? then
      floater = params[:user][:floater]
      params[:user].delete("floater")
    else
      floater = nil
    end
    @user = User.new(params[:user])
    if @user.save then
      session[:user_id] = @user.id
      params[:user_role] = Hash.new
      params[:user_role][:user_id] = @user.id
      params[:user_role][:role_id] = Role.find_by_name("USER").id
      @user_role = UserRole.new(params[:user_role])
      @user_role.save
      if floater.nil? then
        redirect_to(@user)
      else
        render :partial => "index/floater_thanks"
      end
      #redirect_to :controller => "challenges", :action => "index"
    else
      if floater.nil? then
        render :action => "new"
      else
        render :partial => "index/floater"
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    if session[:user_id].to_s == params[:id].to_s then
      @user = User.find(params[:id])
      if !params[:user][:image_url].nil? && params[:user][:image_url] != "" then
        uploaded_io = params[:user][:image_url]
        if uploaded_io != "" then
          upload_dir = image_upload_path + "users/#{@user.id}/"
          if !File.exists?(upload_dir) then
            Dir.mkdir(upload_dir)
          end
          File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
            file.write(uploaded_io.read)
            params[:user][:image_url] = "/uploads/users/#{@user.id}/" + File.basename( file.path )
          end
        end
      end
      if @user.update_attributes(params[:user]) then
        flash[:notice] = "User was successfully updated."
        redirect_to(@user)
      else
        @states = State.find(:all, :order => :name)
        @countries = Country.find(:all, :conditions => { :printable_name => "United States" }, :order => :printable_name)
        render :action => "edit", :locals => { :states => @states, :countries => @countries }
      end
    else
      flash[:error_message] = "You can only update your own profile."
      render "errors/index"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    if session[:user_id].to_s == params[:id].to_s then
      @user = User.find(params[:id])
      @user.destroy
      format.html { redirect_to(users_url) }
    else
      flash[:error_message] = "You can only delete your own profile."
      render "errors/index"
    end
  end

  protected
  def secure?
    ["show","edit","update","destroy"].include?(action_name)
  end

end
