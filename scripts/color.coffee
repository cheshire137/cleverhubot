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
    if raw_color != hex_color && raw_color != hex_color.replace(/^#/, '')
      fields.push
        title: 'Hex'
        value: hex_color
        short: true
    if raw_color != rgb_color
      fields.push
        title: 'RGB'
        value: rgb_color
        short: true
    title = raw_color
    title = color_name if color_name
    payload =
      message: msg.message
      content:
        text: title
        fallback: "color #{raw_color}"
        color: hex_color
        fields: fields
    robot.emit 'slack-attachment', payload
