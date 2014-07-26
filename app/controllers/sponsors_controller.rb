class SponsorsController < ApplicationController

  # GET /sponsors
  # GET /sponsors.xml
  def index
    @limit = get_limit
    @offset = get_offset(params)
    @sponsors_count = Sponsor.count
    if !params[:sort].nil? then
      if !params[:asc].nil? then
        asc = params[:asc]
      else
        asc = ""
      end
      if params[:sort] == "alpha" then
        @sponsors = Sponsor.find_all_order_by_with_limit_and_offset("name", asc, true, @limit, @offset)
      elsif params[:sort] == "date" then
        @sponsors = Sponsor.find_all_order_by_with_limit_and_offset("created_at", asc, true, @limit, @offset)
      else
        @sponsors = Sponsor.find_all_with_limit_and_offset(true, @limit, @offset)
      end
    else
      @sponsors = Sponsor.find_all_with_limit_and_offset(true, @limit, @offset)
    end
    @results_pages = @sponsors_count.fdiv(@limit)
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @sponsors }
    end
  end

  # GET /sponsors/1
  # GET /sponsors/1.xml
  def show
    if !params[:id].to_s.match(/^\d+$/)
      @sponsor = Sponsor.find_by_seo_name_and_enabled(params[:id], true)
    else
      @sponsor = Sponsor.find_by_id_and_enabled(params[:id], true)
    end
    if !@sponsor.nil? then
      respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @sponsor }
      end
    else
      flash[:error_message] = "This sponsor is not active."
      respond_to do |format|
        format.html { render "errors/index" }
        format.xml { render :xml => flash[:error_message] }
      end
    end
  end

  # GET /sponsors/new
  # GET /sponsors/new.xml
  def new
    @sponsor = Sponsor.new
    @states = State.find(:all, :order => :name)
    @countries = Country.find(:all, :conditions => {:printable_name => "United States"}, :order => :printable_name)
    @tags = Tag.find(:all, :order => :name)
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @sponsor }
    end
  end

  # GET /sponsors/1/edit
  def edit
    if !params[:id].to_s.match(/^\d+$/)
      sponsor = Sponsor.find_by_seo_name_and_enabled(params[:id], true)
    else
      sponsor = Sponsor.find_by_id_and_enabled(params[:id], true)
    end
    if !sponsor.nil? && sponsor.user.id.to_s == session[:user_id].to_s then
      @sponsor = sponsor
      @states = State.find(:all, :order => :name)
      @countries = Country.find(:all, :conditions => {:printable_name => "United States"}, :order => :printable_name)
      @tags = Tag.find(:all, :order => :name)
    else
      flash[:error_message] = "You cannot edit this sponsor."
      respond_to do |format|
        format.html { render "errors/index" }
        format.xml { render :xml => flash[:error_message] }
      end
    end
  end

  # POST /sponsors
  # POST /sponsors.xml
  def create
    @sponsor = Sponsor.new(params[:sponsor])
    if !params[:sponsor][:image_url].nil? && params[:sponsor][:image_url] != "" then
      uploaded_io = params[:sponsor][:image_url]
      if uploaded_io != "" then
        upload_dir = image_upload_path + "sponsors/#{@sponsor.id}/"
        if !File.exists?(upload_dir) then
          Dir.mkdir(upload_dir)
        end
        File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
          file.write(uploaded_io.read)
          params[:sponsor][:image_url] = "/uploads/sponsors/#{@sponsor.id}/" + File.basename(file.path)
        end
      end
    end
    if !params[:sponsor][:img_thumb_url].nil? && params[:sponsor][:img_thumb_url] != "" then
      uploaded_io = params[:sponsor][:img_thumb_url]
      if uploaded_io != "" then
        upload_dir = image_upload_path + "sponsors/#{@sponsor.id}/"
        if !File.exists?(upload_dir) then
          Dir.mkdir(upload_dir)
        end
        File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
          file.write(uploaded_io.read)
          params[:sponsor][:img_thumb_url] = "/uploads/sponsors/#{@sponsor.id}/" + File.basename(file.path)
        end
      end
    end
    respond_to do |format|
      if @sponsor.save then
        flash[:notice] = 'Sponsor was successfully created.'
        format.html { redirect_to(@sponsor) }
        format.xml { render :xml => @sponsor, :status => :created, :location => @sponsor }
      else
        @states = State.find(:all, :order => :name)
        @countries = Country.find(:all, :conditions => {:printable_name => "United States"}, :order => :printable_name)
        @tags = Tag.find(:all, :order => :name)
        format.html { render :action => "new", :locals => {:states => @states, :countries => @countries, :tags => @tags} }
        format.xml { render :xml => @sponsor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sponsors/1
  # PUT /sponsors/1.xml
  def update
    @sponsor = Sponsor.find_by_id_and_enabled(params[:id], true)
    if !@sponsor.nil? && @sponsor.user.id.to_s == session[:user_id].to_s then
      if !params[:sponsor][:image_url].nil? && params[:sponsor][:image_url] != "" then
        uploaded_io = params[:sponsor][:image_url]
        if uploaded_io != "" then
          upload_dir = image_upload_path + "sponsors/#{@sponsor.id}/"
          if !File.exists?(upload_dir) then
            Dir.mkdir(upload_dir)
          end
          File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
            file.write(uploaded_io.read)
            params[:sponsor][:image_url] = "/uploads/sponsors/#{@sponsor.id}/" + File.basename(file.path)
          end
        end
      end
      if !params[:sponsor][:img_thumb_url].nil? && params[:sponsor][:img_thumb_url] != "" then
        uploaded_io = params[:sponsor][:img_thumb_url]
        if uploaded_io != "" then
          upload_dir = image_upload_path + "sponsors/#{@sponsor.id}/"
          if !File.exists?(upload_dir) then
            Dir.mkdir(upload_dir)
          end
          File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
            file.write(uploaded_io.read)
            params[:sponsor][:img_thumb_url] = "/uploads/sponsors/#{@sponsor.id}/" + File.basename(file.path)
          end
        end
      end
      respond_to do |format|
        if @sponsor.update_attributes(params[:sponsor]) then
          flash[:notice] = 'Sponsor was successfully updated.'
          format.html { redirect_to(@sponsor) }
          format.xml { head :ok }
        else
          @states = State.find(:all, :order => :name)
          @countries = Country.find(:all, :conditions => {:printable_name => "United States"}, :order => :printable_name)
          @tags = Tag.find(:all, :order => :name)
          format.html { render :action => "edit", :locals => {:states => @states, :countries => @countries, :tags => @tags} }
          format.xml { render :xml => @sponsor.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:error_message] = "You cannot update this sponsor."
      respond_to do |format|
        format.html { render "errors/index" }
        format.xml { render :xml => flash[:error_message] }
      end
    end
  end

  protected
  def secure?
    ["new", "edit", "create", "update", "destroy"].include?(action_name)
  end

end
