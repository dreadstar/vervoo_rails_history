class NewsletterSubscribersController < ApplicationController

  # GET /newsletter_subscribers/1
  # GET /newsletter_subscribers/1.xml
  def show
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
  end

  # GET /newsletter_subscribers/new
  # GET /newsletter_subscribers/new.xml
  def new
    @newsletter_subscriber = NewsletterSubscriber.new
  end

  # GET /newsletter_subscribers/1/edit
  def edit
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
  end

  # POST /newsletter_subscribers
  # POST /newsletter_subscribers.xml
  def create
    @newsletter_subscriber = NewsletterSubscriber.new(params[:newsletter_subscriber])
    if @newsletter_subscriber.save
      render :partial => "index/floater_thanks"
    else
      render :partial => "index/floater"
    end
  end

  # PUT /newsletter_subscribers/1
  # PUT /newsletter_subscribers/1.xml
  def update
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
    if @newsletter_subscriber.update_attributes(params[:newsletter_subscriber])
      render :partial => "index/floater_thanks"
    else
      render :partial => "index/floater"
    end
  end

end
