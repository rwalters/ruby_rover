require 'compass_point'
require 'rover'

class MarsControl
  attr_accessor :plateau, :rovers

  def initialize(filename)
    @rovers = []

    raise "'#{filename}' doesn't exist!" unless File::file?(filename)

    file_data = File::read(filename)
    raise "No data in file '#{filename}'!" if file_data.empty?

    lines = file_data.chomp.split("\n")
    first_line = lines.shift

    # The first line has two numbers, separated by a space
    # Can't just grab single chars, since the number might be greater than one digit.
    platNums = first_line .scan(/\S+/)
    @plateau = {:x => platNums[0].to_i, :y => platNums[1].to_i}

    lines.each.with_index do |line, i|
      if /^[A-Z]/ =~ line
        sendDirections(@rovers.last, line)
      else
        roverParams = line.strip.scan(/\S+/)

        @rovers << Rover.new(x: roverParams[0].to_i, y: roverParams[1].to_i, face: roverParams[2].upcase, plateau: @plateau)
      end
    end
  end

  def sendDirections(rover, directions)
    lDir = directions.strip
    lDir.chars do |c|
      if /^[LRM]$/ =~ c
        rover.send("go_#{c}".to_sym)
      else
        raise "#{c} is an invalid direction. Only L, R, and M are allowed for Left, Right, and Move."
      end
    end
  end
end
