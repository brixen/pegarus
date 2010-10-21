module Pegarus
  # Implements !patt in a PEG. The pattern succeeds if
  # patt does not match. Does not consume any input.
  class Unless < UnaryOp
  end
end
