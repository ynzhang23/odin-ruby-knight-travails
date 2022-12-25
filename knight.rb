# frozen_string_literal: true

require_relative 'board'

# Creates a knight piece
class Knight
  attr_reader :landed

  def initialize(start_pos, end_pos)
    @start = Board.new(start_pos, [])
    @end = Board.new(end_pos, [])
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
    @latest_positions << @start

    # Add current positions' next steps to queue and track travelled node to graph
    @latest_positions.each do |node|
      # Check and return previous step if current positions are the destination
      if landed_on_destination(node.position)
        p 'You think you are funny huh?'
        p "It will take #{node.previous_positions.length - 1} steps to reach #{@end.position} from #{@start.position}"
        @landed = true
        break
      end
      @travelled << node
      # Create nodes for the next step
      node.connected.each do |pos|
        @next_step.push(Board.new(pos, @start.previous_positions))
      end
    end
    # Reset queue
    @latest_positions.clear
  end

  # Subsequent moves on loop until destination is found
  def next_move
    # Update current nodes
    @latest_positions = @next_step.dup
    @next_step.clear
    # Loop across the current nodes
    @latest_positions.each do |node|
      # Stop the loop and return current node if knight is on the destination
      if landed_on_destination(node.position)
        p "It will take #{node.previous_positions.length - 1} steps to reach #{@end.position} from #{@start.position}"
        node.previous_positions.each do |position|
          p position
        end
        @landed = true
        break
      end
      # Add vertex to graph
      @travelled << node
      # Add possible nodes to travel on the next step, and adding current nodes' travel history to it
      node.connected.each do |pos|
        @next_step.push(*Board.new(pos, node.previous_positions))
      end
    end
    # Filter next steps to prevent re-travel
    @next_step.reject! { |node| extract_positions.include?(node.position) }
    @latest_positions.clear
  end

  # Return array of travelled positions
  def extract_positions
    temp_array = []
    @travelled.each do |position_node|
      temp_array << position_node.position 
    end
    temp_array
  end

  # Get start location
  def self.start_position
    puts'
(y)
 7 |_|#|_|#|_|#|_|#|
 6 |#|_|#|_|#|_|#|_|
 5 |_|#|_|#|_|#|_|#|
 4 |#|_|#|_|#|_|#|_|
 3 |_|#|_|#|_|#|_|#|
 2 |#|_|#|_|#|_|#|_|
 1 |_|#|_|#|_|#|_|#|
 0 |#|_|#|_|#|_|#|_|
    0 1 2 3 4 5 6 7 (x)
    '
    start_pos = []
    loop do
      puts 'Where would you like the knight to start? (x-coordinate)'
      start_pos[0] = gets.chomp.to_i
      break if start_pos[0] < 8 && start_pos[0] >= 0
    end
    loop do
      puts 'Where would you like the knight to start? (y-coordinate)'
      start_pos[1] = gets.chomp.to_i
      break if start_pos[1] < 8 && start_pos[1] >= 0
    end
    start_pos
  end

  # Get end location
  def self.end_position
    end_pos = []
    loop do
      puts 'Where would you like the knight to end? (x-coordinate)'
      end_pos[0] = gets.chomp.to_i
      break if end_pos[0] < 8 && end_pos[0] >= 0
    end
    loop do
      puts 'Where would you like the knight to end? (y-coordinate)'
      end_pos[1] = gets.chomp.to_i
      break if end_pos[1] < 8 && end_pos[1] >= 0
    end
    end_pos
  end

  # Get start and end location and create knight
  def self.create_knight_from_input
    start_pos = Knight.start_position
    end_pos = Knight.end_position
    Knight.new(start_pos, end_pos)
  end
end

puts '
█▄▀ █▄░█ █ █▀▀ █░█ ▀█▀
█░█ █░▀█ █ █▄█ █▀█ ░█░

▀█▀ █▀█ ▄▀█ █░█ ▄▀█ █ █░░ █▀
░█░ █▀▄ █▀█ ▀▄▀ █▀█ █ █▄▄ ▄█
'
knight = Knight.create_knight_from_input
knight.first_move
knight.next_move until knight.landed == true
puts '
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⡀⢀⣶⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣟⠙⢿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣷⣄⠻⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠈⠻⠿⠿⣿⣿⣿⣿⣆⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠙⢿⣿⠟⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢰⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'