class ConnectionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :check_guess, :connections_and_words]
  before_action :connections_and_words, only: [:show, :check_guess]

  def index
    @connections = policy_scope(Connection)
  end

  def show
    @connection = Connection.find(params[:id])
    authorize @connection
  end

  def check_guess
    @success = false
    @message = ""
    @group_connections.each do |group_connection|
      group = group_connection.group
      if (group.words - params[:guess]).empty?
        group_connection.update(solved: true)
        @success = true
      elsif (group.words - params[:guess]).length == 1
        @message = "One away..."
      end
    end
    @connection.update(mistakes_remaining: @connection.mistakes_remaining - 1) unless @success
    @connection.update(completed: true) if @connection.mistakes_remaining.zero? || @group_connections.reject(&:solved).empty?

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append(:messages, partial: "connections/form",
                                                            target: "form",
                                                            locals: { solved_connections: @solved_connections, remaining_words: @remaining_words })
      end
      format.html { redirect_to connection_path(@connection) }
    end
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
    @solved_connections = @group_connections.select(&:solved).sort_by(&:updated_at)
    @unsolved_connections = @group_connections.reject(&:solved)
    @remaining_words = @unsolved_connections.map { |gc| gc.group.words }.flatten.shuffle
  end
end
