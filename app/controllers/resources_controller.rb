class ResourcesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_resources, only: [:edit, :update, :destroy]

  def index
    @tags = ActsAsTaggableOn::Tagging.where(taggable_type: "Resource").map { |tagging| tagging.tag }.uniq
    @resources = policy_scope(Resource)
    @resources = @resources.search_by_title_and_description(params[:search][:query]) if params[:search][:query].present? && params[:search][:query] != [""]
    @resources = @resources.tagged_with(params[:search][:tags]) if params[:search][:tags].present? && params[:search][:tags] != [""]
    @resources = @resources.page params[:page]
  end

  def new
    @resource = Resource.new
    authorize @resource
  end

  def create
    @resource = Resource.new(resource_params)
    @resource.user = current_user
    params[:resource][:tags].reject(&:blank?).each { |tag| @resource.tag_list.add(tag.downcase) }
    if @resource.save
      flash[:success] = "Resource created!"
      redirect_to resources_path(search: {query: ""})
    else
      render :new
    end
    authorize @resource
  end

  def edit
    authorize @resource
  end

  def update
    authorize @resource
    ActsAsTaggableOn::Tagging.where(taggable_type: "Resource", taggable_id: @resource.id).destroy_all
    params[:resource][:tags].reject(&:blank?).each { |tag| @resource.tag_list.add(tag.downcase) }
    @resource.update(resource_params)
    redirect_to resources_path(search: {query: ""})
  end

  def destroy
    @resource.destroy
    flash[:danger] = "Resource deleted!"
    redirect_to resources_path(search: {query: ""}), status: :see_other
    authorize @resource
  end

  def upvote
    @resource = Resource.find(params[:id])
    authorize @resource
    @resource.liked_by current_user
    redirect_to request.referrer
  end

  def remove_upvote
    @resource = Resource.find(params[:id])
    authorize @resource
    @resource.unliked_by current_user
    redirect_to request.referrer
  end

  private

  def set_resources
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:title, :description, :link, :photo)
  end
end
