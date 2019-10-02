class Deck
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def cards_in_category(category)
    @cards.find_all do |card|
      card.category == category
    end
  end

  def deck_count
    @cards.length
  end

end