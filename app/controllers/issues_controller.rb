class IssuesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @issues = Issue.all
    @issues = @issues.search_by_fields(params[:search][:query]) if params[:search][:query].present? && params[:search][:query] != ""
    @issues = @issues.tagged_with(params[:search][:tags], :any => true) if params[:search][:tags].present? && params[:search][:tags] != [""]
    # @listings = @listings.where("listing_targets.target_id = ?", params[:target_id]) if params[:target_id].present? && params[:target_id] != ""

    # raise
    # if params[:search][:query].present?
    #   @issues = Issue.search_by_fields(params[:search][:query])
    #   tagged_with
    # else
    #   @issues = Issue.all
    # end
  end

  def show
    @issue = Issue.friendly.find(params[:id])
  end

  def new
    @issue = Issue.new
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

  def update
  end

  def destroy
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :error_message, :content)
  end
end
