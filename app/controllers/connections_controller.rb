class ConnectionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :check_guess, :connections_and_words]
  before_action :connections_and_words, only: [:show, :check_guess]

  def index
    @connections = policy_scope(Connection).select { |c| c.groups.count == 4 }.sort_by { |c| c.created_at }
    @connections = Kaminari.paginate_array(@connections).page(params[:page]).per(10)
  end

  def stats
    @connections = current_user.connections.select { |c| c.complete }
    @connections.each { |connection| authorize connection }
  end

  def show
  end

  def new
    @connection = Connection.new
    authorize @connection
  end

  def create
    @connections = current_user.connections

    if @connections.empty? || current_user.latest_connection_is_built?
      @connection = Connection.create(user: current_user)
    else
      @connection = current_user.connections.last
    end

    authorize @connection

    redirect_to new_connection_group_path(@connection)
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
    @attempt = Attempt.find_or_create_by(user: current_user, connection: @connection)

    @group_connections = @connection.group_connections
    @connections = @connection.groups
    @words = @connections.pluck(:words).flatten
    @solved_groups = SolvedGroup.where(attempt: @attempt)
    @unsolved_groups = @group_connections.reject { |gc| @attempt.groups.include?(gc.group) }
    @remaining_words = @unsolved_groups.map { |gc| gc.group.words }.flatten.shuffle
  end
end
