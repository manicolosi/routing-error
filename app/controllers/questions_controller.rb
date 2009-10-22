class QuestionsController < ApplicationController
  before_filter :require_user, :except => [ :index, :show ]

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new(:question => @question)
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(params[:question])

    if @question.save
      flash[:success] = "Your question has been asked. Sit back and" +
                        "wait for the answers to come in!"
      redirect_to @question
    else
      render :action => 'new'
    end
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])

    if @question.update_attributes(params[:question])
      flash[:success] = "Your question has been updated."
      redirect_to @question
    else
      render :action => 'edit'
    end
  end
end
