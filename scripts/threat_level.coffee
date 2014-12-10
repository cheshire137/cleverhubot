# Description:
#   Tracks threat level of threats
#
# Commands:
#   TODO
#
module.exports = (robot) ->

  threat_response = (threat) ->
    threat_data = robot.brain.data.threat[threat]
    response = "THREAT #{threat}: #{threat_data.level}"
    if threat_data.level == 5
      response = "#{response} MAXIMUM"
    if message = threat_data.message
      response = "#{response} - #{message}"
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
      robot.brain.data.threat[threat] ||= {}
      robot.brain.data.threat[threat].level = level
      msg.send threat_response(threat)
    else
      msg.send "Error: Threat Level must be an integer between 0-5."

  # Set threat level message
  # set threat message ants
  robot.respond /set threat message\s*(.*)?$/i, (msg) ->
    incoming = msg.match[1]
    words = incoming.split(':')
    message = words.pop()
    threat = words
    if threat
      robot.brain.data.threat ||= {}
      robot.brain.data.threat[threat] ||= {}
      robot.brain.data.threat[threat].message = message
      msg.send threat_response(threat)

  # List threat level for an item
  # threat level ants
  robot.respond /threat level \s*(.*)?$/i, (msg) ->
    threat = msg.match[1]
    robot.brain.data.threat ||= {}
    level = robot.brain.data.threat[threat].level
    if level
      msg.send threat_response(threat)
    else
      msg.send "Threat level for #{threat} not set."

  # List all threat levels
  # threat level
  robot.respond /threat level$/i, (msg) ->
    robot.brain.data.threat ||= {}
    for threat of robot.brain.data.threat
      msg.send threat_response(threat)

  # Delete threat
  # remove threat level ants
  robot.respond /remove threat level \s*(.*)?$/i, (msg) ->
    threat = msg.match[1]
    robot.brain.data.threat ||= {}
    delete robot.brain.data.threat[threat]
    msg.send "Removed threat, #{threat}."
