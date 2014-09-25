# Description:
#   Get pretty colors
#
# Dependencies:
#    "randomColor" : "https://github.com/davidmerfield/randomColor/tarball/master"
#
# Configuration:
#   None
#
# Commands:
#   hubot colors - Get five random colors
#   hubot colors <count> - Get <count> random colors
#   hubot colors <hue> - Get five colors of <hue> hue, where <hue> is one of green, blue, random, red, orange, yellow, purple, pink, or monochrome.
#   hubot colors <count> <hue> - Get <count> colors of <hue> hue. Both parameters are optional
#
# Notes:
#
# Author:
#   moneypenny

randomColor = require('randomcolor')

module.exports = (robot) ->
  robot.respond /colors(\s+)?(\d+)?(\s+)?(green|blue|random|red|orange|yellow|purple|pink|monochrome)?/i, (msg) ->
    count = msg.match[2] || 5
    hue = msg.match[4] || 'random'
    colors = randomColor
      count: count
      hue: hue
    for color in colors
      payload =
        message: msg.message
        content:
          text: color
          color: color
      robot.emit 'slack-attachment', payload
