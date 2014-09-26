# Description:
#   Love things
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot love <optional subject>
#   hubot loves <optional subject>
#
# Notes:
#   See http://www.emoji-cheat-sheet.com/ for a list of emoji.
#
# Author:
#   moneypenny

love_emoji = [':heart_eyes:', ':kissing_heart:', ':love_letter:', ':kiss:',
              ':hearts:', ':heart_decoration:', ':yellow_heart:',
              ':blue_heart:', ':purple_heart:', ':heart:', ':green_heart:',
              ':heartbeat:', ':heartpulse:', ':two_hearts:',
              ':revolving_hearts:', ':cupid:', ':sparkling_heart:',
              ':couple_with_heart:', ':couplekiss:', ':heart_eyes_cat:']

module.exports = (robot) ->
  robot.respond /loves?(\s+(.*))?/i, (msg) ->
    emoji = love_emoji[Math.floor(Math.random() * love_emoji.length)]
    msg.send emoji
