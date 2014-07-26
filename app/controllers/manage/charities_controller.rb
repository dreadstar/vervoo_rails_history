class Manage::CharitiesController < ApplicationController
  layout "manage_layout"

  # GET /manage/charities
  # GET /manage/charities.xml
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
        @charities = Charity.find_all_order_by_with_limit_and_offset("name", asc, "", @limit, @offset)
      elsif params[:sort] == "date" then
        @charities = Charity.find_all_order_by_with_limit_and_offset("created_at", asc, "", @limit, @offset)
      else
        @charities = Charity.find_all_with_limit_and_offset("", @limit, @offset)
      end
    else
      @charities = Charity.find_all_with_limit_and_offset("", @limit, @offset)
    end
    @results_pages = @charities_count.fdiv(@limit)
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @charities }
    end
  end

  # GET /manage/charities/1
  # GET /manage/charities/1.xml
  def show
    if !params[:id].to_s.match(/^\d+$/)
      @charity = Charity.find_by_seo_name(params[:id])
    else
      @charity = Charity.find(params[:id])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @charity }
    end
  end

  # GET /manage/charities/new
  # GET /manage/charities/new.xml
  def new
    @charity = Charity.new
    @states = State.find(:all, :order => :name)
    @countries = Country.find(:all, :conditions => {:printable_name => "United States"}, :order => :printable_name)
    @tags = Tag.find(:all, :order => :name)
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @charity }
    end
  end

  # GET /manage/charities/1/edit
  def edit
    logger.debug "TRACE: #{__LINE__} : params.inspect #{params.inspect} "
    if !params[:id].to_s.match(/^\d+$/)
      @charity = Charity.find_by_seo_name(params[:id])
      logger.info "TRACE: #{__LINE__} : @charity.id #{@charity.id}"
    else
      @charity = Charity.find(params[:id])
    end
    @states = State.find(:all, :order => :name)
    @countries = Country.find(:all, :conditions => {:printable_name => "United States"}, :order => :printable_name)
    @tags = Tag.find(:all, :order => :name)
  end

  # POST /manage/charities
  # POST /manage/charities.xml
  def create
    logger.debug "TRACE: #{__LINE__} : params.inspect #{params.inspect} "
    @charity = Charity.new(params[:charity])

    respond_to do |format|
      if @charity.save then
        iurl = nil ## debug
        if !params[:charity][:image_url].nil? && params[:charity][:image_url] != "" then
          uploaded_io = params[:charity][:image_url]
          if uploaded_io != "" then
            upload_dir = image_upload_path + "charities/#{@charity.id}/"
            if !File.exists?(upload_dir) then
              Dir.mkdir(upload_dir)
            end
            File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
              file.write(uploaded_io.read)
              foo = File.basename(file.path) ## debug
              iurl = "/uploads/charities/#{@charity.id}/" + File.basename(file.path) ## debug
              params[:charity][:image_url] = "/uploads/charities/#{@charity.id}/" + File.basename(file.path)
            end
          end
        end
        params[:charity][:image_url] = iurl ## debug
        if !params[:charity][:img_thumb_url].nil? && params[:charity][:img_thumb_url] != "" then
          uploaded_io = params[:charity][:img_thumb_url]
          if uploaded_io != "" then
            upload_dir = image_upload_path + "charities/#{@charity.id}/"
            if !File.exists?(upload_dir) then
              Dir.mkdir(upload_dir)
            end
            File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
              file.write(uploaded_io.read)
              params[:charity][:img_thumb_url] = "/uploads/charities/#{@charity.id}/" + File.basename(file.path)
            end
          end
        end
        @charity.update_attribute(:image_url,params[:charity][:image_url])
        @charity.update_attribute(:img_thumb_url,params[:charity][:img_thumb_url])
        @charity.update_attribute(:enabled, params[:charity][:enabled])
        flash[:notice] = 'Charity was successfully created.'
        format.html { redirect_to([:manage, @charity]) }
        format.xml { render :xml => @charity, :status => :created, :location => @charity }
      else
        @states = State.find(:all, :order => :name)
        @countries = Country.find(:all, :conditions => {:printable_name => "United States"}, :order => :printable_name)
        @tags = Tag.find(:all, :order => :name)
        format.html { render :action => "new", :locals => {:states => @states, :countries => @countries, :tags => @tags} }
        format.xml { render :xml => @charity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /manage/charities/1
  # PUT /manage/charities/1.xml
  def update
    @charity = Charity.find(params[:id])
    logger.debug "TRACE: #{__LINE__} : @charity.id #{@charity.id}"
    if !params[:id].to_s.match(/^\d+$/)
      @charity = Charity.find_by_seo_name(params[:id])
      logger.info "TRACE: #{__LINE__} : @charity.id #{@charity.id}"
    else
      @charity = Charity.find(params[:id])
    end
    if !params[:charity][:image_url].nil? && params[:charity][:image_url] != "" then
      uploaded_io = params[:charity][:image_url]
      if uploaded_io != "" then
        upload_dir = image_upload_path + "charities/#{@charity.id}/"
        if !File.exists?(upload_dir) then
          Dir.mkdir(upload_dir)
        end
        File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
          file.write(uploaded_io.read)
          params[:charity][:image_url] = "/uploads/charities/#{@charity.id}/" + File.basename(file.path)
        end
      end
    end
    if !params[:charity][:img_thumb_url].nil? && params[:charity][:img_thumb_url] != "" then
      uploaded_io = params[:charity][:img_thumb_url]
      if uploaded_io != "" then
        upload_dir = image_upload_path + "charities/#{@charity.id}/"
        if !File.exists?(upload_dir) then
          Dir.mkdir(upload_dir)
        end
        File.open(upload_dir + uploaded_io.original_filename, 'w') do |file|
          file.write(uploaded_io.read)
          params[:charity][:img_thumb_url] = "/uploads/charities/#{@charity.id}/" + File.basename(file.path)
        end
      end
    end
    respond_to do |format|
      if @charity.update_attributes(params[:charity]) then
        @charity.update_attribute(:enabled, params[:charity][:enabled])
        flash[:notice] = 'Charity was successfully updated.'
        format.html { redirect_to([:manage, @charity]) }
        format.xml { head :ok }
      else
        @states = State.find(:all, :order => :name)
        @countries = Country.find(:all, :conditions => {:printable_name => "United States"}, :order => :printable_name)
        @tags = Tag.find(:all, :order => :name)
        format.html { render :action => "edit", :locals => {:states => @states, :countries => @countries, :tags => @tags} }
        format.xml { render :xml => @charity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/charities/1
  # DELETE /manage/charities/1.xml
  def destroy
    if !params[:id].to_s.match(/^\d+$/)
      @charity = Charity.find_by_seo_name(params[:id])
    else
      @charity = Charity.find(params[:id])
    end
    @charity.destroy
    respond_to do |format|
      format.html { redirect_to([:manage, charities_url]) }
      format.xml { head :ok }
    end
  end

  protected
  def secure_manage?
    ["index", "show", "new", "edit", "create", "update", "destroy"].include?(action_name)
  end

end
