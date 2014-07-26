class Manage::TagsController < ApplicationController
  layout "manage_layout"

  # GET /manage/tags
  # GET /manage/tags.xml
  def index
    @limit = get_limit
    @offset = get_offset(params)
    @tags_count = Tag.count
    if !params[:sort].nil? then
      if !params[:asc].nil? then
        asc = params[:asc]
      else
        asc = ""
      end
      if params[:sort] == "alpha" then
        @tags = Tag.find(:all, :order => "name " + asc, :limit => @limit, :offset => @offset )
      elsif params[:sort] == "date" then
        @tags = Tag.find(:all, :order => "created_at " + asc, :limit => @limit, :offset => @offset )
      else
        @tags = Tag.find(:all, :limit => @limit, :offset => @offset )
      end
    else
      @tags = Tag.find(:all, :limit => @limit, :offset => @offset )
    end
    @results_pages = @tags_count.fdiv(@limit)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end
  
  # GET /manage/tags/1
  # GET /manage/tags/1.xml
  def show
    @tag = Tag.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end
  
  # GET /manage/tags/new
  # GET /manage/tags/new.xml
  def new
    @tag = Tag.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end
  
  # GET /manage/tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end
  
  # POST /manage/tags
  # POST /manage/tags.xml
  def create
    @tag = Tag.new(params[:tag])
    respond_to do |format|
      if @tag.save
        flash[:notice] = 'Tag was successfully created.'
        format.html { redirect_to([:manage, @tag]) }
        format.xml  { render :xml => @tag, :status => :created, :location => @tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /manage/tags/1
  # PUT /manage/tags/1.xml
  def update
    @tag = Tag.find(params[:id])
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = 'Tag was successfully updated.'
        format.html { redirect_to([:manage, @tag]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /manage/tags/1
  # DELETE /manage/tags/1.xml
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to([:manage, tags_url]) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def secure_manage?
    ["index","show","new","edit","create","update","destroy"].include?(action_name)
  end
  
end
