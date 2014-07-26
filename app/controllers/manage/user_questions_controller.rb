class Manage::UserQuestionsController < ApplicationController
  layout "manage_layout"

  # GET /manage/user_questions
  # GET /manage/user_questions.xml
  def index
    @user_questions = UserQuestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_questions }
    end
  end

  # GET /manage/user_questions/1
  # GET /manage/user_questions/1.xml
  def show
    @user_question = UserQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_question }
    end
  end

  # GET /manage/user_questions/new
  # GET /manage/user_questions/new.xml
  def new
    @user_question = UserQuestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_question }
    end
  end

  # GET /manage/user_questions/1/edit
  def edit
    @user_question = UserQuestion.find(params[:id])
  end

  # POST /manage/user_questions
  # POST /manage/user_questions.xml
  def create
    @user_question = UserQuestion.new(params[:user_question])

    respond_to do |format|
      if @user_question.save
        flash[:notice] = 'UserQuestion was successfully created.'
        format.html { redirect_to(@user_question) }
        format.xml  { render :xml => @user_question, :status => :created, :location => @user_question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /manage/user_questions/1
  # PUT /manage/user_questions/1.xml
  def update
    @user_question = UserQuestion.find(params[:id])

    respond_to do |format|
      if @user_question.update_attributes(params[:user_question])
        flash[:notice] = 'UserQuestion was successfully updated.'
        format.html { redirect_to(@user_question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/user_questions/1
  # DELETE /manage/user_questions/1.xml
  def destroy
    @user_question = UserQuestion.find(params[:id])
    @user_question.destroy

    respond_to do |format|
      format.html { redirect_to(user_questions_url) }
      format.xml  { head :ok }
    end
  end
end
