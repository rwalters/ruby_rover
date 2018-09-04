class CompassPoint
  CARDINALS = %w[ N E S W ]

  def getDirectionFromInt(int_point)
    # Since we store the direction the rover faces as an int, we have to have a way to translate.

    if int_point >= CARDINALS.count
      raise RangeError, "#{int_point} does not correspond with one of the cardinal directions"
    end

    CARDINALS[int_point]
  end

  def getDirectionFromString(string_point)
    # This is used to translate from the letters N, S, E, and W into the "enum."
    unless CARDINALS.include?(string_point)
      raise ArgumentError, "#{string_point} is not one of the cardinal directions"
    end

    CARDINALS.index(string_point)
  end

  def go_L(curr_face)
    # This will take the current direction the rover is facing,
    # and returns the direction the rover will face after turning left.
    curr_face = getDirectionFromString(curr_face)
    newFace = (curr_face - 1)

    if (newFace < 0)
      newFace += CARDINALS.count
    end

    return getDirectionFromInt(newFace)
  end

  def go_R(curr_face)
    # This will take the current direction the rover is facing,
    # and returns the direction the rover will face after turning right.
    curr_face = getDirectionFromString(curr_face)
    return getDirectionFromInt((curr_face + 1) % CARDINALS.count)
  end
end
