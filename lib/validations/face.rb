module Validations
  class Face
    def validate(**args)
      face = args[:face]

      raise 'The direction the rover faces must be a number or a string.' unless (face.is_a?(String) || face.is_a?(Integer))
    end

    Validations.register self
  end
end
