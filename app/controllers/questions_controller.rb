class QuestionsController < ApplicationController
  before_action :authenticate_user!

  before_filter :load_question, only: [:edit, :update, :destroy]

  def index
    @search = Question.search do
      fulltext params[:search]
    end
    @questions = Kaminari.paginate_array(@search.results).page(params[:page]).per(PER_PAGE)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Creation successful"
      redirect_to questions_path
    else
      flash[:error] = @question.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @question.update(question_params)
      flash[:success] = "Update successful"
      redirect_to questions_path
    else
      flash[:error] = @question.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @question.delete

    flash[:success] = "Destroy successful"
    redirect_to questions_path
  end

  private
    def question_params
      params.require(:question).permit(:title, :user_id, :body)
    end

    def load_question
      @question = Question.find(params[:id])
    end
end
