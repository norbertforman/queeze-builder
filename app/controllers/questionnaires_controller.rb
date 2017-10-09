class QuestionnairesController < ApplicationController
  before_action :authenticate_user!, except: [:solve, :solution]
  before_filter :load_questionnaire, only: [:edit, :update, :destroy, :solve, :solution]

  def index
    @search = Questionnaire.search do
      fulltext params[:search]
      with :user_id, current_user.id
      paginate page: params[:page], per_page: PER_PAGE
    end
    @questionnaires = @search.results
  end

  def new
    @questionnaire = Questionnaire.new
  end

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    if @questionnaire.save
      flash[:success] = "Creation successful"
      redirect_to questionnaires_path
    else
      flash[:error] = @questionnaire.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @questionnaire.update(questionnaire_params)
      flash[:success] = "Update successful"
      redirect_to questionnaires_path
    else
      flash[:error] = @questionnaire.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @questionnaire.delete

    flash[:success] = "Destroy successful"
    redirect_to questionnaires_path
  end

  def solve
    @questions = @questionnaire.questions.includes(:answers)
  end

  def solution
    @questions = @questionnaire.questions.includes(:answers)
    @result = Result.new(params.permit(:name, :email, :questionnaire_id))
    score = 0
    @questions.each do |question|
      score += 1 if (params[:answers][question.id.to_s] - question.answers.where(correct: true).map { |a| a.id.to_s }).empty?
    end
    @result.score = score
    if @result.save
      flash[:success] = "Thank you for your submission!"
      redirect_to root_path
    else
      flash[:error] = @result.errors.full_messages.to_sentence
      render :solve
    end
  end

  private
    def questionnaire_params
      params.require(:questionnaire).permit(:title, :user_id, question_ids: [])
    end

    def load_questionnaire
      @questionnaire = Questionnaire.find(params[:id])
    end
end
