class Rover
  attr_reader :x, :y, :face, :compass, :plateau

  def initialize(x:, y:, face:, plateau:)
    check_params(x, y, face, plateau)

    @x = x
    @y = y
    @plateau = plateau
    @compass = CompassPoint.new()

    face  = compass.getDirectionFromString(face) if face.is_a?(String)
    @face = compass.getDirectionFromInt(face)
  end

  def go_L
    @face = compass.go_L(face)
  end

  def go_R
    @face = compass.go_R(face)
  end

  def go_M
    send("go_#{@face}".to_sym)
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
    "x: #{@x}, y: #{@y}, face: #{@face}, plateau: #{@plateau}"
  end

  private

  def check_params(x, y, face, plateau)
    args = {x: x, y: y, face: face, plateau: plateau}

    Validations.check(args)
  end
end
