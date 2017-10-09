class QuestionnairesController < ApplicationController
  before_action :authenticate_user!
  before_filter :load_questionnaire, only: [:edit, :update, :destroy]

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

  private
    def questionnaire_params
      params.require(:questionnaire).permit(:title, :user_id)
    end

    def load_questionnaire
      @questionnaire = Questionnaire.find(params[:id])
    end
end
