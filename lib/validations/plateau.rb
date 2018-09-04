module Validations
  class Plateau
    def validate(**args)
      plateau = args[:plateau]

      raise 'The plateau hash must have :x and :y values.' if (plateau[:x].nil? || plateau[:y].nil?)

      raise 'The plateau must be a hash.' unless plateau.is_a?(Hash)
      raise 'The :x and :y values of the plateau must be numbers.' unless(plateau[:x].is_a?(Integer) && plateau[:y].is_a?(Integer))

      raise 'The :x and :y values of the plateau must be greater than zero.' if (plateau[:x] < 1 || plateau[:y] < 1)
    end

    Validations.register self
  end
end
