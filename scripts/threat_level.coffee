# Description:
#   Tracks threat level of threats
#
# Commands:
#   set threat level <threat> <level> - Set/create a threat level
#   set threat message <threat>:<message> - Set a threat level message
#   remove threat level <threat> - Remove a threat
#   threat level <threat> - Show one threat
#   threat level - Show all threats
#
module.exports = (robot) ->

  threat_response = (threat) ->
    threat_data = robot.brain.data.threat[threat]
    level = threat_data.level
    response = "THREAT #{threat}: #{level}"
    readiness = switch level
      when 1 then 'MAXIMUM READINESS'
      when 2 then 'READY TO ENGAGE'
      when 3 then 'READY TO MOBILIZE'
      when 4 then 'ABOVE NORMAL READINESS'
      when 5 then 'NORMAL READINESS'
    if threat_data.level == 1
      response = "#{response} "
    response = "#{response} #{readiness}"
    if message = threat_data.message
      response = "#{response} - #{message}"
    response

  # Set threat level
  # set threat level ants 5
  robot.respond /set threat level\s+(.*)?$/i, (msg) ->
    incoming = msg.match[1]
    words = incoming.split(' ')
    level = parseInt(words.pop(), 10)
    threat = words.join(' ')
    robot.brain.data.threat ||= {}
    if level >= 1 && level <= 5
      robot.brain.data.threat[threat] ||= {}
      robot.brain.data.threat[threat].level = level
      msg.send threat_response(threat)
    else
      msg.send "Error: Threat Level must be an integer between 1-5."

  # Set threat level message
  # set threat message ants: Please report any ant sightings to the war-room!
  robot.respond /set threat message\s+(.*)?$/i, (msg) ->
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
  robot.respond /threat level \s+(.*)?$/i, (msg) ->
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
    if Object.keys(robot.brain.data.threat).length > 0
      for threat of robot.brain.data.threat
        msg.send threat_response(threat)
    else
      msg.send 'There are currently no threats.'

  # Delete threat
  # remove threat level ants
  robot.respond /remove threat level \s+(.*)?$/i, (msg) ->
    threat = msg.match[1]
    robot.brain.data.threat ||= {}
    delete robot.brain.data.threat[threat]
    msg.send "Removed threat, #{threat}."

  # Delete all threats
  # remove all threats
  robot.respond /remove all threats$/i, (msg) ->
    delete robot.brain.data.threat
    msg.send "Removed all threats."
