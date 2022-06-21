class IssuesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @issues = policy_scope(Issue)
    if params[:search].present?
      @issues = @issues.search_by_fields(params[:search][:query]) if params[:search][:query].present? && params[:search][:query] != ""
      @issues = @issues.tagged_with(params[:search][:tags], :any => true) if params[:search][:tags].present? && params[:search][:tags] != [""]
    end
  end

  def show
    @issue = Issue.friendly.find(params[:id])
    authorize @issue
  end

  def new
    @issue = Issue.new
    authorize @issue
  end

  def create
    @issue = Issue.create(issue_params)
    @issue.user = current_user
    params[:issue][:tags].reject(&:blank?).each { |tag| @issue.tag_list.add(tag) }
    if @issue.save!
      redirect_to issue_path(@issue)
    else
      render :new
    end
  end

  def edit
    @issue = Issue.friendly.find(params[:id])
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

  private

  def issue_params
    params.require(:issue).permit(:title, :error_message, :content)
  end
end
