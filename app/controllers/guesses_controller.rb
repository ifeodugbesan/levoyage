class GuessesController < ApplicationController
  before_action :connections_and_words, only: :create
  def create
    @guess = Guess.new(guess_params)
    authorize @guess
    @guess.attempt = @attempt
    @current_guesses = @attempt.guesses.map(&:words)
    if @guess.save
      check_guess
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def check_guess
    @success = false
    @wrong = false
    if @current_guesses.include?(@guess.words)
      @already_guessed = true
    else
      @group_connections.each do |group_connection|
        group = group_connection.group
        if (group.words - @guess.words).empty?
          group_connection.update(solved: true)
          @solved_group = { title: group_connection.group.title, words: group_connection.group.words.join(", "), level: group_connection.group.level }
          @success = true
          @wrong = false
          break
        elsif (group.words - @guess.words).length == 1
          @message = "One away..."
        elsif (group.words - @guess.words).length > 1
          @wrong = true unless @success
        end
      end
      @unsolved_groups = @group_connections.reject(&:solved)
      @remaining_words = @unsolved_groups.map { |gc| gc.group.words }.flatten.shuffle
      @solved_groups = @group_connections.select(&:solved).sort_by(&:updated_at)
      @attempt.update(completed: true) if @solved_groups.size == 4
      @attempt.update(mistakes_remaining: @attempt.mistakes_remaining - 1) unless @success
      if @attempt.mistakes_remaining.zero?
        @attempt.update(failed: true)
        @failed = true
      end
    end
  end

  private

  def connections_and_words
    @attempt = Attempt.find(params[:attempt_id])
    @connection = @attempt.connection

    @group_connections = @connection.group_connections
    @connections = @connection.groups
    @words = @connections.pluck(:words).flatten
    @solved_groups = @group_connections.select(&:solved).sort_by(&:updated_at)
    @unsolved_groups = @group_connections.reject(&:solved)
    @remaining_words = @unsolved_groups.map { |gc| gc.group.words }.flatten.shuffle
  end

  def guess_params
    params.require(:guess).permit(words: [])
  end
end
