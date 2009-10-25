class AnswersController < ApplicationController
  before_filter :require_user, :except => [ :index, :show ]

  def show
    redirect_to Answer.find(params[:id]).question
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

    redirect_to @answer.question
  end
end
