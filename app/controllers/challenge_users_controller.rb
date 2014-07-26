class ChallengeUsersController < ApplicationController

  # GET /challenge_users/1
  # GET /challenge_users/1.xml
  def show
    if !params[:id].to_s.match(/^\d+$/) then
      @challenge_users = ChallengeUser.find_all_by_challenge_name(params[:id])
    else
      @challenge_users = ChallengeUser.find_all_by_challenge_id(params[:id])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @challenge_users }
    end
  end

  # POST /challenge_users
  # POST /challenge_users.xml
  def create
    @challenge_user = ChallengeUser.new(params[:challenge_user])
    logger.warn "challenge_user:" + @challenge_user.to_s
    respond_to do |format|
      if @challenge_user.save then
        flash[:notice] = 'ChallengeUser was successfully created.'
        format.html { render :partial => "created", :locals => { :challenge => @challenge_user.challenge } }
        format.xml  { render :xml => @challenge_user, :status => :created, :location => @challenge_user }
      else
        format.html { render :partial => "error" }
        format.xml  { render :xml => @challenge_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chalenge_users/1
  # DELETE /chalenge_users/1.xml
  def destroy
    @chalenge_user = ChallengeUser.find(params[:id])
    if !@challenge_user.nil? &&
      ( @challenge_user.user.id.to_s == session[:user_id].to_s ||
        @challenge_user.challenge.user.id.to_s == session[:user_id].to_s ) then
      @challenge_user.destroy
      respond_to do |format|
        format.html { redirect_to(challenge_users_url) }
        format.xml  { head :ok }
      end
    else
      flash[:error_message] = "You cannot remove this user from this challenge."
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
