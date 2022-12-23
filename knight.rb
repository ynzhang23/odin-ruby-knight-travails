# frozen_string_literal: true

require 'pry-byebug'

# Creates a knight piece
class Knight
  attr_reader :position, :next_position

  def initialize(position)
    @position = position
    @next_position = generate_next_positions(position)
  end

  def valid_position?(new_x, new_y)
    return false if new_x < 0 || new_x > 8 || new_y < 0 || new_y > 8
    true
  end

  def add_to_possible_positions(new_x, new_y, possible_positions)
    temp_position = [new_x, new_y]
    possible_positions.push(temp_position.dup)
    temp_position.clear
    possible_positions
  end

  def generate_next_positions(position)
    possible_positions = []

    new_x = position[0] + 2
    new_y = position[1] + 1
    add_to_possible_positions(new_x, new_y, possible_positions) if valid_position?(new_x, new_y)

    new_x = position[0] + 2
    new_y = position[1] - 1
    add_to_possible_positions(new_x, new_y, possible_positions) if valid_position?(new_x, new_y)

    new_x = position[0] + 1
    new_y = position[1] + 2
    add_to_possible_positions(new_x, new_y, possible_positions) if valid_position?(new_x, new_y)

    new_x = position[0] + 1
    new_y = position[1] - 2
    add_to_possible_positions(new_x, new_y, possible_positions) if valid_position?(new_x, new_y)

    new_x = position[0] - 2
    new_y = position[1] + 1
    add_to_possible_positions(new_x, new_y, possible_positions) if valid_position?(new_x, new_y)

    new_x = position[0] - 2
    new_y = position[1] - 1
    add_to_possible_positions(new_x, new_y, possible_positions) if valid_position?(new_x, new_y)

    new_x = position[0] - 1
    new_y = position[1] + 2
    add_to_possible_positions(new_x, new_y, possible_positions) if valid_position?(new_x, new_y)

    new_x = position[0] - 1
    new_y = position[1] - 2
    add_to_possible_positions(new_x, new_y, possible_positions) if valid_position?(new_x, new_y)

    possible_positions
  end
end


knight = Knight.new([0, 0])
p knight.next_position