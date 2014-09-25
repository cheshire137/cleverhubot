# Description:
#   Translate colors to hex and RGB values
#
# Dependencies:
#    "tinycolor" : "https://github.com/bgrins/TinyColor/tarball/master",
#    "randomColor" : "https://github.com/davidmerfield/randomColor/tarball/master"
#
# Configuration:
#   None
#
# Commands:
#   hubot color - Get a random color in hex and RGB formats
#   hubot color <color> - Translate color from hex, a name, or RGB to other formats
#   hubot colors - Get five random colors
#   hubot colors <count> - Get <count> random colors
#   hubot colors <hue> - Get five colors of <hue> hue; <hue> can be green, blue, random, red, orange, yellow, purple, pink, or monochrome
#   hubot colors <count> <hue> - Get <count> colors of <hue> hue
#
# Notes:
#
# Author:
#   moneypenny

tinycolor = require('tinycolor2')
randomColor = require('randomcolor')

module.exports = (robot) ->
  robot.respond /color(s?)\s*(\d*)(.*)/i, (msg) ->
    single_color = !msg.match[1]
    if single_color
      raw_color = msg.match[3]
      raw_color = randomColor() unless raw_color
      raw_color = raw_color.trim().toLowerCase()
      color = tinycolor(raw_color)
      hex_color = color.toHexString()
      color_name = color.toName()
      fields = []
      fields.push
        title: 'Hex'
        value: hex_color
        short: true
      fields.push
        title: 'RGB'
        value: color.toRgbString()
        short: true
      payload =
        message: msg.message
        content:
          color: hex_color
          fields: fields
      robot.emit 'slack-attachment', payload
    else
      count = msg.match[2] || 5
      count = parseInt(count, 10)
      count = 1 if count < 1
      count = 10 if count > 10
      hue = msg.match[3] || 'random'
      hue = hue.trim().toLowerCase()
      valid_hues = ['green', 'blue', 'random', 'red', 'orange', 'yellow',
                    'purple', 'pink', 'monochrome']
      hue = 'random' unless valid_hues.indexOf(hue) > -1
      colors = randomColor
        count: count
        hue: hue
      for raw_color in colors
        color = tinycolor(raw_color)
        fields = []
        fields.push
          title: 'Hex'
          value: color.toHexString()
          short: true
        fields.push
          title: 'RGB'
          value: color.toRgbString()
          short: true
        payload =
          message: msg.message
          content:
            color: raw_color
            fields: fields
        robot.emit 'slack-attachment', payload
