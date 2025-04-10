class IssuesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @tags = ActsAsTaggableOn::Tagging.where(taggable_type: "Issue").map { |tagging| tagging.tag }.uniq.sort_by { |tag| tag.name }
    @issues = policy_scope(Issue).order(created_at: :desc)
    @issues = @issues.search_by_fields(params[:query]) if params[:query].present? && params[:query] != ""
    @issues = @issues.tagged_with(params[:tags]) if params[:tags].present? && params[:tags] != [""]
    @issues = @issues.page params[:page]
  end

  def show
    @issue = Issue.friendly.find(params[:id])
    @alternative = Alternative.new
    authorize @issue
  end

  def new
    @issue = Issue.new
    authorize @issue
  end

  def create
    @issue = Issue.create(issue_params)
    @issue.user = current_user
    params[:issue][:tags].reject(&:blank?).each { |tag| @issue.tag_list.add(tag.downcase) }
    if @issue.save!
      authorize @issue
      redirect_to issue_path(@issue)
    else
      render :new
    end
  end

  def edit
    @issue = Issue.friendly.find(params[:id])
    authorize @issue
  end

  def update
    @issue = Issue.friendly.find(params[:id])
    authorize @issue
    ActsAsTaggableOn::Tagging.where(taggable_type: "Issue", taggable_id: @issue.id).destroy_all
    params[:issue][:tags].reject(&:blank?).each { |tag| @issue.tag_list.add(tag.downcase) }
    @issue.update(issue_params)
    redirect_to issue_path(@issue)
  end

  def destroy
    @issue = Issue.friendly.find(params[:id])
    authorize @issue
    @issue.destroy
    redirect_to issues_path, status: :see_other
  end

  def upvote
    @issue = Issue.friendly.find(params[:id])
    authorize @issue
    @issue.liked_by current_user
    redirect_to request.referrer
  end

  def remove_upvote
    @issue = Issue.friendly.find(params[:id])
    authorize @issue
    @issue.unliked_by current_user
    redirect_to request.referrer
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :error_message, :content)
  end
end
