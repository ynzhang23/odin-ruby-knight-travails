# frozen_string_literal: true

require 'pry-byebug'

class Board
  attr_reader :position, :connected

  def initialize(position)
    @position = position
    @connected = possible_moves(position)
  end

  # 1.1 Return if move is possible
  def valid_move?(new_x, new_y)
    return false if new_x < 0 || new_x > 8 || new_y < 0 || new_y > 8

    true
  end

  # 1.2 Adds move to an array of possible moves
  def add_to_possible_moves(new_x, new_y, possible_moves)
    temp_position = [new_x, new_y]
    possible_moves.push(temp_position.dup)
    temp_position.clear
    possible_moves
  end

  # 1.3 Returns an array of possible moves
  def possible_moves(position)
    possible_moves = []

    new_x = position[0] + 2
    new_y = position[1] + 1
    add_to_possible_moves(new_x, new_y, possible_moves) if valid_move?(new_x, new_y)

    new_x = position[0] + 2
    new_y = position[1] - 1
    add_to_possible_moves(new_x, new_y, possible_moves) if valid_move?(new_x, new_y)

    new_x = position[0] + 1
    new_y = position[1] + 2
    add_to_possible_moves(new_x, new_y, possible_moves) if valid_move?(new_x, new_y)

    new_x = position[0] + 1
    new_y = position[1] - 2
    add_to_possible_moves(new_x, new_y, possible_moves) if valid_move?(new_x, new_y)

    new_x = position[0] - 2
    new_y = position[1] + 1
    add_to_possible_moves(new_x, new_y, possible_moves) if valid_move?(new_x, new_y)

    new_x = position[0] - 2
    new_y = position[1] - 1
    add_to_possible_moves(new_x, new_y, possible_moves) if valid_move?(new_x, new_y)

    new_x = position[0] - 1
    new_y = position[1] + 2
    add_to_possible_moves(new_x, new_y, possible_moves) if valid_move?(new_x, new_y)

    new_x = position[0] - 1
    new_y = position[1] - 2
    add_to_possible_moves(new_x, new_y, possible_moves) if valid_move?(new_x, new_y)

    possible_moves
  end
end