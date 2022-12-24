# frozen_string_literal: true

require_relative 'board'
require 'pry-byebug'

# Creates a knight piece
class Knight
  def initialize(start_pos, end_pos)
    @start = Board.new(start_pos)
    @end = Board.new(end_pos)
    # All Nodes
    @travelled = []
    # Tracking Arrays
    @next_step = []
    @latest_positions = []
    @landed = false
  end

  # Checks if the next move is the destination
  def landed_on_destination(pos)
    pos == @end.position
  end

  # First move
  def first_move
    @latest_positions << @start.position

    # Add current positions' next steps to queue and track travelled node to graph
    @latest_positions.each do |pos|
      # Check and return previous step if current positions are the destination
      if landed_on_destination(pos)
        puts pos.to_s
        return @landed = true
      end
      @travelled << Board.new(pos)
      @next_step.push(*Board.new(pos).connected)
    end
    # Reset queue
    @latest_positions.clear
  end

  # Subsequent moves
  def next_move
    @latest_positions = @next_step.dup
    @next_step.clear

    binding.pry
    # Loop across the current positions
    @latest_positions.each do |pos|
      # Check and return previous step if current positions are the destination
      if landed_on_destination(pos)
        puts pos.to_s
        return @landed = true
      end
      # Create and add vertice to graph
      @travelled << Board.new(pos)
      # Add next steps from current step
      @next_step.push(*Board.new(pos).connected)
    end
    # Filter next steps to prevent re-travel
    @next_step.reject! {|pos| extract_positions.include?(pos)}
    @latest_positions.clear
  end

  # Return positions from all vertices
  def extract_positions
    temp_array = []
    @travelled.each do |position_node|
      temp_array << position_node.position 
    end
    temp_array
  end

  def create_path
    first_move
    next_move until @landed == true
  end
end

knight = Knight.new([4, 3], [2, 3])
knight.create_path
