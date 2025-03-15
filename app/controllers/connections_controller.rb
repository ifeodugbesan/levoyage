class ConnectionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :check_guess, :connections_and_words]
  before_action :connections_and_words, only: [:show, :check_guess]

  def index
    @connections = policy_scope(Connection)
  end

  def show
    @connection = Connection.find(params[:id])
    authorize @connection
    @attempt = Attempt.find_or_create_by(user: current_user, connection: @connection)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def connections_and_words
    @connection = Connection.find(params[:id])
    authorize @connection

    @group_connections = @connection.group_connections
    @connections = @connection.groups
    @words = @connections.pluck(:words).flatten
    @solved_groups = @group_connections.select(&:solved).sort_by(&:updated_at)
    @unsolved_groups = @group_connections.reject(&:solved)
    @remaining_words = @unsolved_groups.map { |gc| gc.group.words }.flatten.shuffle
  end
end
