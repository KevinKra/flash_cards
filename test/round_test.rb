require 'minitest/autorun'
require 'minitest/pride'
require "../lib/card"
require '../lib/deck'
require '../lib/round'
require "../lib/turn"

class RoundTest < Minitest::Test
  def setup
    @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)

    @cards = [@card_1, @card_2, @card_3]

    @deck = Deck.new(@cards)
    @round = Round.new(@deck)
  end

  def test_it_exists
    assert_instance_of Round, @round
  end

  def test_it_should_have_a_deck_on_initialize
    assert_equal @deck, @round.deck
  end

  def test_it_should_return_number_correct_by_category
    @round.take_turn("Juneau")
    assert_equal 1, @round.number_correct_by_category(:Geography)
    assert_equal 0, @round.number_correct_by_category(:STEM)
  end

  def test_it_returns_the_correct_overall_percentage
    @round.take_turn("Juneau")
    @round.take_turn("Pandora")
    assert_equal 50.0, @round.percent_correct
    @round.take_turn("North north west")
    assert_equal 66.6, @round.percent_correct
  end

end