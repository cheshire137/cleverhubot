# Description:
#   Tracks threat level of threats
#
# Commands:
#   TODO
#
module.exports = (robot) ->

  threat_response = (threat, level) ->
    response = "THREAT #{threat}: #{level}"
    if level == 5
      response = "#{response} MAXIMUM"
    response

  # Set threat level
  # set threat level ants 5
  robot.respond /set threat level\s*(.*)?$/i, (msg) ->
    incoming = msg.match[1]
    words = incoming.split(' ')
    level = parseInt(words.pop(), 10)
    threat = words.join(' ')
    robot.brain.data.threat ||= {}
    if level >= 0 && level <= 5
      robot.brain.data.threat[threat] = level
      msg.send threat_response(threat, level)
    else
      msg.send "Error: Threat Level must be an integer between 0-5."

  # List threat level for an item
  # threat level ants
  robot.respond /threat level \s*(.*)?$/i, (msg) ->
    threat = msg.match[1]
    robot.brain.data.threat ||= {}
    level = robot.brain.data.threat[threat]
    if level
      msg.send threat_response(threat, level)
    else
      msg.send "Threat level for #{threat} not set."

  # List all threat levels
  # threat level
  robot.respond /threat level$/i, (msg) ->
    robot.brain.data.threat ||= {}
    for threat, level of robot.brain.data.threat
      msg.send threat_response(threat, level)

  # Delete threat
  # remove threat level ants
  robot.respond /remove threat level \s*(.*)?$/i, (msg) ->
    threat = msg.match[1]
    robot.brain.data.threat ||= {}
    delete robot.brain.data.threat[threat]
    msg.send "Removed threat, #{threat}."
