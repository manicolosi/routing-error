class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params[:question])

    if @question.save
      flash[:notice] = 'Successfully asked your question.'
      redirect_to @question
    else
      render :action => 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update_attributes(params[:question])
      flash[:notice] = "Updated question successfully."
      redirect_to @question
    else
      render :action => 'edit'
    end
  end
end
