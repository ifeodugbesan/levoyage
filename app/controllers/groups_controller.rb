class GroupsController < ApplicationController
  before_action :set_connection, only: [:new, :create]
  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    authorize @group
    @group.words.map!(&:downcase)
    @group.user = current_user
    if @group.save
      GroupConnection.create(connection: @connection, group: @group)
      redirect_to new_connection_group_path(@connection)
    else
      render :new, status: 422
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_connection
    @connection = Connection.find(params[:connection_id])
  end

  def group_params
    params.require(:group).permit(:title, :level, words: [])
  end
end
