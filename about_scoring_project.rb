require File.expand_path(File.dirname(__FILE__) + '/neo')
require 'colorize'
# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.


def score(dice)
  puts "Game currently testing: ".blue.on_magenta
  print dice
  puts ""
  score = 0
  threed = Array.new
  # iterate through each item in the array dice
  dice.each do |item|
    puts "traversing item: #{item}"
    # A set of three ones in 1000 points; if one has never been encountered before
    if dice.count(item) >= 3 and item == 1 and !(threed.include? item)
      threed.push(item) #This number has now been encountered, if we see it again, skip
      puts "Found a set of three ones(1000pts)"
      score += 1000
      puts score
      3.times{ dice.delete_at(dice.index(item)) }
      puts "Current state of array: "
      print dice
      puts "　→　Three #{item}s have been removed from the array."
      #dice.delete(1)
    # A set of three numbers (other than ones) is worth 100 times the number.
    # (e.g. three fives is 500 points)
    elsif dice.count(item) >= 3 and !(threed.include? item)
      threed.push(item) #This number has now been encountered, if we see it again, skip
      puts "Found a set of three numbers(n * 100pts)"
      score += item * 100
      3.times{ dice.delete_at(dice.index(item)) }
      puts "Current state of array: "
      print dice
      puts "　→　Three #{item}s have been removed from the array."
      puts score
    # A one ( that is not part of a set of three) is worth 100 points.
  elsif item == 1 and (dice.count(item)%3 != 0) and !(threed.include? item)
      puts "Found a single one(100pts)"
      score += 100
      puts score
    # A five (that is not part of a set of three) is worth 50 points.
  elsif item == 5 and (dice.count(item) % 3 != 0) and !(threed.include? item)
      puts "Found a single five(50pts)"
      score += 50
      puts score
    end
    # Everything else is worth 0 points.
  end
  return score
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    puts "START: test_score_of_single_2s_3s_4s_and_6s_are_zero".yellow.on_blue
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    puts "START: test_score_of_a_triple_1_is_1000".yellow.on_blue
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    puts "START: test_score_of_other_triples_is_100x".yellow.on_blue
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    puts "START: test_score_of_mixed_is_sum".yellow.on_blue
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
