class AnswersController < ApplicationController
  before_action :authenticate_user!, :load_question
  before_action :load_answer, only: [:edit, :update, :destroy]

  def index
    @answers = @question.answers.order('created_at')
  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      flash[:success] = "Creation successful"
      redirect_to question_answers_path(@question)
    else
      flash[:error] = @answer.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      flash[:success] = "Update successful"
      redirect_to question_answers_path(@question)
    else
      flash[:error] = @answer.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @answer.delete

    flash[:success] = "Destroy successful"
    redirect_to question_answers_path(@question)
  end

  private
    def load_question
      @question = Question.find(params[:question_id])
    end

    def answer_params
      params.require(:answer).permit(:question_id, :body, :correct)
    end

    def load_answer
      @answer = Answer.find(params[:id])
    end
end
