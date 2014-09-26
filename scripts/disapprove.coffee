# Description:
#   Disapprove of things
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot disapprove <optional subject>
#   hubot disapproves <optional subject>
#   hubot disapproval <optional subject>
#
# Notes:
#
# Author:
#   moneypenny
module.exports = (robot) ->
  robot.respond /disapprov(es?|al)(\s+(.*))?/i, (msg) ->
    msg.send 'ಠ_ಠ'
