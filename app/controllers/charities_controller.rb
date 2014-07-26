class CharitiesController < ApplicationController

  # GET /charities
  # GET /charities.xml
  def index
    @limit = get_limit
    @offset = get_offset(params)
    @charities_count = Charity.count
    if !params[:sort].nil? then
      if !params[:asc].nil? then
        asc = params[:asc]
      else
        asc = ""
      end
      if params[:sort] == "alpha" then
        @charities = Charity.find_all_order_by_with_limit_and_offset("name", asc, true, @limit, @offset)
      elsif params[:sort] == "date" then
        @charities = Charity.find_all_order_by_with_limit_and_offset("created_at", asc, true, @limit, @offset)
      else
        @charities = Charity.find_all_with_limit_and_offset(true, @limit, @offset)
      end
    else
      @charities = Charity.find_all_with_limit_and_offset(true, @limit, @offset)
    end
    @results_pages = @charities_count.fdiv(@limit)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @charities }
    end
  end
  
  # GET /charities/1
  # GET /charities/1.xml
  def show
    if !params[:id].to_s.match(/^\d+$/)
      @charity = Charity.find_by_seo_name_and_enabled(params[:id], true)
    else
      @charity = Charity.find_by_id_and_enabled(params[:id], true)
    end
    if !@charity.nil? then
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @charity }
      end
    else
      flash[:error_message] = "This charity is not active."
      respond_to do |format|
        format.html { render "errors/index" }
        format.xml  { render :xml => flash[:error_message] }
      end
    end
  end
  
  # GET /charities/new
  # GET /charities/new.xml
  def new
    @charity = Charity.new
    @states = State.find(:all, :order => :name)
    @countries = Country.find(:all, :conditions => { :printable_name => "United States" }, :order => :printable_name)
    @tags = Tag.find(:all, :order => :name)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @charity }
    end
  end
  
  # GET /charities/1/edit
  def edit
    if !params[:id].to_s.match(/^\d+$/)
      charity = Charity.find_by_seo_name_and_enabled(params[:id], true)
    else
      charity = Charity.find_by_id_and_enabled(params[:id], true)
    end
    if !charity.nil? && charity.user.id.to_s == session[:user_id].to_s then
      @charity = charity
      @states = State.find(:all, :order => :name)
      @countries = Country.find(:all, :conditions => { :printable_name => "United States" }, :order => :printable_name)
      @tags = Tag.find(:all, :order => :name)
    else
      flash[:error_message] = "You cannot edit this charity."
      respond_to do |format|
        format.html { render "errors/index" }
        format.xml  { render :xml => flash[:error_message] }
      end
    end
  end
  
  # POST /charities
  # POST /charities.xml
  def create
    @charity = Charity.new(params[:charity])
    if !params[:charity][:image_url].nil? && params[:charity][:image_url] != "" then
      uploaded_io = params[:charity][:image_url]
      if uploaded_io != "" then
        upload_dir = image_upload_path + "charities/#{@charity.id}/"
        if !File.exists?(upload_dir) then
          Dir.mkdir(upload_dir)
        end
        File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
          file.write(uploaded_io.read)
          params[:charity][:image_url] = "/uploads/charities/#{@charity.id}/" + File.basename( file.path )
        end
      end
    end
    respond_to do |format|
      if @charity.save then
        flash[:notice] = 'Charity was successfully created.'
        format.html { redirect_to(@charity) }
        format.xml  { render :xml => @charity, :status => :created, :location => @charity }
      else
        @states = State.find(:all, :order => :name)
        @countries = Country.find(:all, :conditions => { :printable_name => "United States" }, :order => :printable_name)
        @tags = Tag.find(:all, :order => :name)
        format.html { render :action => "new", :locals => { :states => @states, :countries => @countries, :tags => @tags } }
        format.xml  { render :xml => @charity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /charities/1
  # PUT /charities/1.xml
  def update
    @charity = Charity.find_by_id_and_enabled(params[:id], true)
    if !@charity.nil? && @charity.user.id.to_s == session[:user_id].to_s then
      if !params[:charity][:image_url].nil? && params[:charity][:image_url] != "" then
        uploaded_io = params[:charity][:image_url]
        if uploaded_io != "" then
          upload_dir = image_upload_path + "charities/#{@charity.id}/"
          if !File.exists?(upload_dir) then
            Dir.mkdir(upload_dir)
          end
          File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
            file.write(uploaded_io.read)
            params[:charity][:image_url] = "/uploads/charities/#{@charity.id}/" + File.basename( file.path )
          end
        end
      end
      respond_to do |format|
        if @charity.update_attributes(params[:charity]) then
          flash[:notice] = 'Charity was successfully updated.'
          format.html { redirect_to(@charity) }
          format.xml  { head :ok }
        else
          @states = State.find(:all, :order => :name)
          @countries = Country.find(:all, :conditions => { :printable_name => "United States" }, :order => :printable_name)
          @tags = Tag.find(:all, :order => :name)
          format.html { render :action => "edit", :locals => { :states => @states, :countries => @countries, :tags => @tags } }
          format.xml  { render :xml => @charity.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:error_message] = "You cannot update this charity."
      respond_to do |format|
        format.html { render "errors/index" }
        format.xml  { render :xml => flash[:error_message] }
      end
    end
  end

  protected
  def secure?
    ["new","edit","create","update","destroy"].include?(action_name)
  end

end
