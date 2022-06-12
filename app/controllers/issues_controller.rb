class IssuesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @issues = Issue.all
  end

  def show
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.create(issue_params)
    @issue.user = current_user
    if @issue.save
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
