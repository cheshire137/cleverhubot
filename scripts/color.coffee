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
#   hubot color <color> - Translate color to other formats, display color
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
    if raw_color == hex_color || raw_color == hex_color.replace(/^#/, '')
      msg.send "#{raw_color}:\t#{rgb_color}"
    else
      msg.send "#{raw_color}:\t#{hex_color}\t#{rgb_color}"
