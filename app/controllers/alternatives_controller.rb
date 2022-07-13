class AlternativesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def new
    @issue = Issue.friendly.find(params[:issue_id])
    @alternative = Alternative.new
    authorize @alternative
  end

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
    @alternative = Alternative.find(params[:id])
    authorize @alternative
  end

  def update
    @alternative = Alternative.find(params[:id])
    authorize @alternative
    @alternative.update(issue_params)
    redirect_to issue_path(@alternative.issue)
  end

  def destroy
    @alternative = Alternative.find(params[:id])
    authorize @alternative
    @alternative.destroy
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
