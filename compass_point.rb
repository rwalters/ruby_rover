##  This is an attempt at an enum, with a few convenience methods added on.

class CompassPoint
  # Constants we use to mimic an enum.
  NumPoints = 4
  N = 0
  E = 1
  S = 2
  W = 3

  def getDirectionFromInt(intPoint)
    # Since we store the direction the rover faces as an int, we have to have a way to translate.

    return 'N' if intPoint == N
    return 'E' if intPoint == E
    return 'S' if intPoint == S
    return 'W' if intPoint == W

    raise RangeError, "#{intPoint} does
                                          not correspond with one of the
                                          cardinal directions"
  end

  def getDirectionFromString(stringPoint)
    # This is used to translate from the letters N, S, E, and W into the "enum."
    case stringPoint
    when 'N'
      return N
    when 'E'
      return E
    when 'S'
      return S
    when 'W'
      return W
    else
      raise ArgumentError, "#{stringPoint} is not one of the cardinal directions"
    end
  end

  def go_L(currentFace)
    # This will take the current direction the rover is facing 
    # and returns the direction the rover will face after turning left.
    newFace = (currentFace - 1)

    if (newFace == -1)
      newFace += NumPoints
    end

    return newFace
  end

  def go_R(currentFace)
    # This will take the current direction the rover is facing 
    # and returns the direction the rover will face after turning right.
      return ((currentFace + 1) % NumPoints)
  end
end
