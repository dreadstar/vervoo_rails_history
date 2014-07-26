class GetInfoController < ApplicationController
  layout "application-old"

  def index
    render :action => "new"
  end

  # GET /get_info/1
  # GET /get_info/1.xml
  def show
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
  end

  # GET /get_info/new
  # GET /get_info/new.xml
  def new
    @newsletter_subscriber = NewsletterSubscriber.new
  end

  # GET /get_info/1/edit
  def edit
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
  end

  # POST /get_info
  # POST /get_info.xml
  def create
    @newsletter_subscriber = NewsletterSubscriber.new(params[:newsletter_subscriber])
    if @newsletter_subscriber.save
      render :action => "thanks"
    else
      render :action => "new"
    end
  end

  def thanks
  end

  # PUT /get_info/1
  # PUT /get_info/1.xml
  def update
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
    if @newsletter_subscriber.update_attributes(params[:newsletter_subscriber])
      render :action => "thanks"
    else
      render :action => "edit"
    end
  end

end
