module Validations
  class Coordinates
    def validate(**args)
      x = args[:x]
      y = args[:y]
      plateau = args[:plateau]

      raise 'The X coordinate must be a number.' unless x.is_a?(Integer)
      raise 'The Y coordinate must be a number.' unless y.is_a?(Integer)

      raise 'X coordinate is not on the plateau' if (x > plateau[:x] || x < 0)
      raise 'Y coordinate is not on the plateau.' if (y > plateau[:y] || y < 0)
    end

    Validations.register self
  end
end
