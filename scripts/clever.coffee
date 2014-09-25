# Description:
#   Interact with Cleverbot
#
# Dependencies:
#    "cleverbot-node" : "https://github.com/fojas/cleverbot-node/tarball/master",
#
# Configuration:
#   None
#
# Commands:
#   hubot clever <message> - Sends <message> to Cleverbot
#
# Notes:
#
# Author:
#   moneypenny

Cleverbot = require('cleverbot-node')

module.exports = (robot) ->
  robot.respond /clever (.+)/i, (msg) ->
    query = msg.match[1]
    bot = new Cleverbot()
    callback = (response) ->
      msg.send response.message
    bot.write(query, callback)
