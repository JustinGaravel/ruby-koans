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
  # WRITE THIS CODE
  # Taken from https://gist.github.com/beckyrussoniello/3658924
  # With slight modifications for my understanding...
  args = [a,b,c].sort

  #A triangle should not have any sides of length 0.
  raise TriangleError if args[0] <= 0

  # The sum of the smallest two sides shall not be greater than or equal to the
  # longest side.
  raise TriangleError if args[2] >= args[0] + args [1]
  # I am not sure what this last line means...
  [nil, :equilateral, :isosceles, :scalene][args.uniq.size]

end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError

end
