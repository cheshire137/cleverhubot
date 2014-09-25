# Description:
#   Get colors
#
# Dependencies:
#    "tinycolor" : "https://github.com/bgrins/TinyColor/tarball/master",
#
# Configuration:
#   None
#
# Commands:
#   hubot color <color> - Translate color from hex, a name, or rgb to other formats
#
# Notes:
#
# Author:
#   moneypenny

tinycolor = require('tinycolor2')

module.exports = (robot) ->
  robot.respond /color (.+)/i, (msg) ->
    raw_color = msg.match[1].trim().toLowerCase()
    color = tinycolor(raw_color)
    hex_color = color.toHexString()
    rgb_color = color.toRgbString()
    color_name = color.toName()
    fields = []
    fields.push
      value: "Hex: #{hex_color}"
      short: true
    fields.push
      value: "RGB: #{rgb_color}"
      short: true
    if color_name
      fields.push
        value: "Name: #{color_name}"
        short: true
    payload =
      message: msg.message
      content:
        text: "color #{raw_color}"
        fallback: raw_color
        color: hex_color
        fields: fields
    robot.emit 'slack-attachment', payload
