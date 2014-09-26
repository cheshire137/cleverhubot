# Description:
#   Play blackjack
#
# Commands:
#   hubot blackjack sitdown - Starts a game
#   hubot blackjack deal - Deals a hand
#   hubot blackjack hitme - Ask for a card
#   hubot blackjack stand - Let the dealer play a card

class Card
  constructor: (suit, rank) ->
    @suit = suit
    @rank = rank
    @id = [rank, suit].join

  id: ->
    @id

Card.ranks = -> ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K']
Card.suits = -> ['H', 'S', 'C', 'D']

class Deck
  constructor: ->
  
  gen: ->
    @cards = []
    for suit in Card.suits
      do (suit) ->
        for rank in Card.ranks
          do (rank) ->
            @cards.push(new Card(suit, rank))

  cards: ->
    @cards

module.exports = (bot) ->
  bet = null
  bot.respond /blackjack sitdown/i, (msg) ->
    
  bot.respond /blackjack bet @?([\w .\-]+)\?*$/i, (msg) ->
    amount = msg.match[1].trim()
    msg.send amount
