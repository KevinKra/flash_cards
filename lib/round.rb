require "../lib/turn"

class Round
  attr_reader :deck, :turns, :current_card, :number_correct

  def initialize(deck)
    @deck = deck
    @turns = []
    @current_card = @deck.cards.slice!(0)
    @number_correct = 0
  end 

  def take_turn(guess)
    new_turn = Turn.new(guess, @current_card)
    @turns << new_turn
    if new_turn.correct?
      @number_correct += 1
    end
    @current_card = @deck.cards.slice!(0)
    new_turn
  end

  def number_correct_by_category(category)
    correct = 0
    @turns.each do |turn|
      if turn.card.category == category
        if turn.guess == turn.card.answer
          correct += 1
        end
      end
    end
    correct
  end
 
  def percent_correct_by_category(category)
    correct = 0
    related_cards = 0
    @turns.each do |turn|
      if turn.card.category == category
        related_cards += 1
        if turn.guess == turn.card.answer
          correct += 1
        end
      end
    end
    calculate_percentage(correct, related_cards)
  end

  def percent_correct
    calculate_percentage(@number_correct, @turns.length)
  end
    
  def calculate_percentage(correct, total)
    result = (correct.to_f / total.to_f) * 100
    result.floor(1)
  end
end
