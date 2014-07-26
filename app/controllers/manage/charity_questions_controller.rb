class Manage::CharityQuestionsController < ApplicationController
  layout "manage_layout"

  # GET /manage/charity_questions
  # GET /manage/charity_questions.xml
  def index
    @charity_questions = CharityQuestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @charity_questions }
    end
  end

  # GET /manage/charity_questions/1
  # GET /manage/charity_questions/1.xml
  def show
    @charity_question = CharityQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @charity_question }
    end
  end

  # GET /manage/charity_questions/new
  # GET /manage/charity_questions/new.xml
  def new
    @charity_question = CharityQuestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @charity_question }
    end
  end

  # GET /manage/charity_questions/1/edit
  def edit
    @charity_question = CharityQuestion.find(params[:id])
  end

  # POST /manage/charity_questions
  # POST /manage/charity_questions.xml
  def create
    @charity_question = CharityQuestion.new(params[:charity_question])

    respond_to do |format|
      if @charity_question.save
        flash[:notice] = 'CharityQuestion was successfully created.'
        format.html { redirect_to(@charity_question) }
        format.xml  { render :xml => @charity_question, :status => :created, :location => @charity_question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @charity_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /manage/charity_questions/1
  # PUT /manage/charity_questions/1.xml
  def update
    @charity_question = CharityQuestion.find(params[:id])

    respond_to do |format|
      if @charity_question.update_attributes(params[:charity_question])
        flash[:notice] = 'CharityQuestion was successfully updated.'
        format.html { redirect_to(@charity_question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @charity_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/charity_questions/1
  # DELETE /manage/charity_questions/1.xml
  def destroy
    @charity_question = CharityQuestion.find(params[:id])
    @charity_question.destroy

    respond_to do |format|
      format.html { redirect_to(charity_questions_url) }
      format.xml  { head :ok }
    end
  end
end
