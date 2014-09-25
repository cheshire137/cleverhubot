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
    if raw_color == hex_color || raw_color == hex_color.replace(/^#/, '')
      response = "#{raw_color}: #{rgb_color}"
    else
      response = "#{raw_color}: #{hex_color} / #{rgb_color}"
    if color_name && color_name != raw_color
      response += " / #{color_name}"
    msg.send response
