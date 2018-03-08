# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
    # Exceptions
    raise(TriangleError, "all sides must be longer than 0") if (a == 0) || (b == 0) || (c == 0)
    raise(TriangleError, "all sides must be positive integers") if (a < 0) || (b < 0) || (c < 0)
    raise(TriangleError, "any two sides of a triangle should add up to more than the third side") if (a + b <= c) || (b + c <= a) || (a + c <= b)

    # Valid logic
    return :equilateral if (a == b) && (b == c)
    return :isosceles   if (a == b) || (b == c) || (a == c)
    return :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
