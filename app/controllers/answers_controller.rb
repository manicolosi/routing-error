class AnswersController < ApplicationController
  before_filter :require_user, :except => [ :index, :show ]

  def show
    answer = Answer.find(params[:id])
    path = question_path answer.question, :anchor => "answer-#{answer.id}"
    redirect_to path
  end

  def new
    @answer = Question.find(params[:question_id]).answers.build
  end

  def create
    @answer = current_user.answers.build(params[:answer])
    @answer.question = Question.find(params[:question_id])

    if @answer.save
      flash[:success] = 'Successfully posted your answer.'
    else
      flash[:error] = 'Unable to post your answer'
    end

    redirect_to @answer
  end

  def edit
    @answer = current_user.answers.find(params[:id])
  end

  def update
    @answer = current_user.answers.find(params[:id])

    if @answer.update_attributes(params[:answer])
      flash[:success] = "Your answer has been updated."
      redirect_to @answer
    else
      render :action => 'edit'
    end
  end
end
