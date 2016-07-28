class ContestsController < ApplicationController
  include GuideFinder

  before_filter :init_contest, only: [:new, :create]
  before_filter :find_contest, except: [:new, :create, :index]

  def create
    return render json: update_contest
  end

  def update
    return render json: update_contest
  end

  def destroy
    @contest.destroy
    redirect_to guide_contests_path(@guide)
  end

  private

  def update_contest
    @contest.assign_attributes contest_params
    @contest.save
    {
      path: edit_guide_contest_path(@guide, @contest),
      state: { contest: @contest.reload, url: edit_guide_contest_path(@guide, @contest) }
    }
  end

  def init_contest
    @contest = @guide.contests.new
  end

  def find_contest
    @contest = @guide.contests
                     .includes({ questions: [:answers],
                                 candidates: [:endorsements] })
                     .find(params[:id])
  end

  def contest_params
    params.require(:contest).permit(
      :title, :description,
      questions: [:id, :text,
        answers: [:text, :candidate_id, :question_id],
        tags: [:name, :tagged_id, :tagged_type]],
      candidates: [:id, :name, :bio, :photo, :facebook,
                   :twitter, :website, :party,
        endorsements: [:endorser, :endorsed_id, :endorsed_type, :stance]])
  end
end
