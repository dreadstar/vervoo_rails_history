class GroupUsersController < ApplicationController

  # GET /group_users/1
  # GET /group_users/1.xml
  def show
    @group_user = GroupUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group_user }
    end
  end

  # GET /group_users/new
  # GET /group_users/new.xml
  def new
    if session[:user_id]
      @group_user = GroupUser.new
      @groups = Group.find(:all)
      if !params[:id].nil?
        @group = Group.find(params[:id])
      end

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @group_user }
      end
    else
      render :partial => "includes/error", :locals => { :error_message => "You can only join a group if you are registered and logged in." }
    end
  end

  # GET /group_users/1/edit
  def edit
    if session[:user_id]
      @group_user = GroupUser.find(params[:id])
      if ( session[:user_id] == @group_user.user_id ) || ( session[:user_id] == @group_user.group.creator_user_id )
        respond_to do |format|
          format.html # new.html.erb
        end
      else
        render :partial => "includes/error", :locals => { :error_message => "You can only modify your own nickname." }
      end
    else
      render :partial => "includes/error", :locals => { :error_message => "You can only modify your nickname if you are registered and logged in." }
    end
  end

  # POST /group_users
  # POST /group_users.xml
  def create
    if session[:user_id]
      @group_user = GroupUser.new(params[:group_user])
      respond_to do |format|
        if @group_user.save
          flash[:notice] = 'GroupUser was successfully created.'
          group_users = GroupUser.find_all_by_user_id(@group_user.user_id)
          if !group_users.nil? && group_users.length > 0
            session[:group_users] = group_users
            if group_users.length == 1
              session[:group_user] = group_users[0]
            end
          end
          format.html { redirect_to :controller => "users", :action => "show", :id => session[:user_id] }
          format.xml  { render :xml => @group_user, :status => :created, :location => @group_user }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @group_user.errors, :status => :unprocessable_entity }
        end
      end
    else
      render :partial => "includes/error", :locals => { :error_message => "You can only join a group if you are registered and logged in." }
    end
  end

  # PUT /group_users/1
  # PUT /group_users/1.xml
  def update
    if session[:user_id]
      @group_user = GroupUser.find(params[:id])
      if ( session[:user_id] == @group_user.user_id ) || ( session[:user_id] == @group_user.group.creator_user_id )

        respond_to do |format|
          if @group_user.update_attributes(params[:group_user])
            flash[:notice] = 'GroupUser was successfully updated.'
            format.html { redirect_to :controller => "users", :action => "show", :id => session[:user_id] }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @group_user.errors, :status => :unprocessable_entity }
          end
        end
      else
        render :partial => "includes/error", :locals => { :error_message => "You can only modify your own nickname." }
      end
    else
      render :partial => "includes/error", :locals => { :error_message => "You can only modify your nickname if you are registered and logged in." }
    end
  end

  # DELETE /group_users/1
  # DELETE /group_users/1.xml
  def destroy
    if session[:user_id]
      @group_user = GroupUser.find(params[:id])
      if ( session[:user_id] == @group_user.user_id ) || ( session[:user_id] == @group_user.group.creator_user_id )
        @group_user.destroy

        respond_to do |format|
          format.html { redirect_to :controller => "users", :action => "show", :id => session[:user_id] }
          format.xml  { head :ok }
        end
      else
        render :partial => "includes/error", :locals => { :error_message => "You can only leave a group that you are in, and you can only remove yourself." }
      end
    else
      render :partial => "includes/error", :locals => { :error_message => "You can only leave a group if you are registered and logged in." }
    end
  end
end
