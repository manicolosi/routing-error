class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(params[:answer])

    if @answer.save
      flash[:success] = 'Successfully posted your answer.'
      redirect_to @question
    else
      flash[:error] = 'Unable to post your answer'
      redirect_to @question
    end
  end
end
