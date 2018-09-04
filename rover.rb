class Rover
  attr_accessor :x, :y, :face, :compass, :plateau

  def initialize(x, y, face, plateau)
    @compass = CompassPoint.new()

    raise TypeError, 'First parameter, the X coordinate, must be a number.' unless x.is_a?(Integer)
    raise TypeError, 'Second parameter, the Y coordinate, must be a number.' unless y.is_a?(Integer)
    raise TypeError, 'Third parameter, the direction the rover faces, must be a number or a string.' unless (face.is_a?(String) || face.is_a?(Integer))
    raise TypeError, 'Fourth parameter, the plateau, must be a hash.' unless plateau.class == Hash

    raise 'The plateau hash must have :x and :y values.' if (plateau[:x].nil? || plateau[:y].nil?)
    raise TypeError, 'The :x and :y values of the plateau must be numbers.' unless(plateau[:x].is_a?(Integer) && plateau[:y].is_a?(Integer))

    raise RangeError, 'The :x and :y values of the plateau must be greater than zero.' if (plateau[:x] < 1 || plateau[:y] < 1)
    raise RangeError, 'Invalid value for the X coordinate.' if (x > plateau[:x] || x < 0)
    raise RangeError, 'Invalid value for the Y coordinate.' if (y > plateau[:y] || y < 0)

    if face.class == String then
      @face = @compass.getDirectionFromString(face)
    end

    if face.is_a?(Integer)
      #Let CompassPoint perform its check
      @compass.getDirectionFromInt(face)
      # If it doesn't raise an error, assign it to our value
      @face = face
    end

    @x = x
    @y = y
    @plateau = plateau
  end

  def go_L()
    @face = @compass.go_L(@face)
  end

  def go_R()
    @face = compass.go_R(@face)
  end

  def go_M()
    case @face
    when CompassPoint::N
      go_N()
    when CompassPoint::E
      go_E()
    when CompassPoint::S
      go_S()
    when CompassPoint::W
      go_W()
    end
  end

  def go_N()
    raise "On northern edge of plateau" unless @y < @plateau[:y]
    @y += 1
  end

  def go_E()
    raise "On eastern ege of plateau" unless @x < @plateau[:x]
    @x += 1
  end

  def go_S()
    raise "On southern edge of plateau" unless @y > 0
    @y -= 1
  end

  def go_W()
    raise "On western edge of plateau" unless @x > 0
    @x -= 1
  end

  def to_s
    "x: #@x, y: #@y, face: " + @compass.getDirectionFromInt(@face) + " , plateau: #@plateau"
  end
end
