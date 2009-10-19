class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(params[:answer])

    if @answer.save
      flash[:notice] = 'Successfully posted your answer.'
      redirect_to @question
    else
      # FIXME: We should redirect to the question and show the form
      # errors, but the below doesn't work.
      #redirect_to @question
      render :xml => @answer.errors, :status => :unprocessable_entity
    end
  end
end
