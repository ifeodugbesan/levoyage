class AlternativesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def create
    @alternative = Alternative.create(alternative_params)
    @alternative.user = current_user
    @alternative.issue = Issue.friendly.find(params[:issue_id])
    if @alternative.save!
      authorize @alternative
      redirect_to issue_path(@alternative.issue)
    else
      render 'issue/show'
    end
  end

  def edit
    @issue = Issue.friendly.find(params[:id])
    authorize @issue
  end

  def update
    @issue = Issue.friendly.find(params[:id])
    authorize @issue
    @issue.update(issue_params)
    redirect_to issue_path(@issue)
  end

  def destroy
    @issue = Issue.friendly.find(params[:id])
    authorize @issue
    @issue.destroy
    redirect_to issues_path
  end

  def upvote
    @alternative = Alternative.find(params[:id])
    authorize @alternative
    @alternative.liked_by current_user
    redirect_to request.referrer
  end

  def remove_upvote
    @alternative = Alternative.find(params[:id])
    authorize @alternative
    @alternative.unliked_by current_user
    redirect_to request.referrer
  end

  private

  def alternative_params
    params.require(:alternative).permit(:content)
  end
end
