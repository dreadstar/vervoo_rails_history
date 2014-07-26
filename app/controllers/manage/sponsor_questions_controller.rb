class Manage::SponsorQuestionsController < ApplicationController
  layout "manage_layout"

  # GET /manage/sponsor_questions
  # GET /manage/sponsor_questions.xml
  def index
    @sponsor_questions = SponsorQuestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sponsor_questions }
    end
  end

  # GET /manage/sponsor_questions/1
  # GET /manage/sponsor_questions/1.xml
  def show
    @sponsor_question = SponsorQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sponsor_question }
    end
  end

  # GET /manage/sponsor_questions/new
  # GET /manage/sponsor_questions/new.xml
  def new
    @sponsor_question = SponsorQuestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sponsor_question }
    end
  end

  # GET /manage/sponsor_questions/1/edit
  def edit
    @sponsor_question = SponsorQuestion.find(params[:id])
  end

  # POST /manage/sponsor_questions
  # POST /manage/sponsor_questions.xml
  def create
    @sponsor_question = SponsorQuestion.new(params[:sponsor_question])

    respond_to do |format|
      if @sponsor_question.save
        flash[:notice] = 'SponsorQuestion was successfully created.'
        format.html { redirect_to(@sponsor_question) }
        format.xml  { render :xml => @sponsor_question, :status => :created, :location => @sponsor_question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sponsor_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /manage/sponsor_questions/1
  # PUT /manage/sponsor_questions/1.xml
  def update
    @sponsor_question = SponsorQuestion.find(params[:id])

    respond_to do |format|
      if @sponsor_question.update_attributes(params[:sponsor_question])
        flash[:notice] = 'SponsorQuestion was successfully updated.'
        format.html { redirect_to(@sponsor_question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sponsor_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/sponsor_questions/1
  # DELETE /manage/sponsor_questions/1.xml
  def destroy
    @sponsor_question = SponsorQuestion.find(params[:id])
    @sponsor_question.destroy

    respond_to do |format|
      format.html { redirect_to(sponsor_questions_url) }
      format.xml  { head :ok }
    end
  end
end
