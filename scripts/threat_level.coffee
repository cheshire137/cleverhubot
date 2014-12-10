# Description:
#   Tracks threat level of threats
#
# Commands:
#   TODO
#
module.exports = (robot) ->
  # Set threat level
  # add threat level ants 5
  robot.respond /add threat level\s*(.*)?$/i, (msg) ->
    incoming = msg.match[1]
    words = incoming.split(' ')
    level = words.pop()
    threat = words.join(' ')
    robot.brain.data['threat'] ||= {}
    robot.brain.data['threat'][threat] = level
    msg.send "Threat Level #{level} set for #{threat}"

  # List threat level for an item
  # threat level ants
  robot.respond /threat level \s*(.*)?$/i, (msg) ->
    threat = msg.match[1]
    robot.brain.data['threat'] ||= {}
    level = robot.brain.data['threat'][threat]
    if level
      msg.send "Threat level #{level} for #{threat}"
    else
      msg.send "Threat level for #{threat} not set"

  # List all threat levels
  # threat level
  robot.respond /threat level$/i, (msg) ->
    robot.brain.data['threat'] ||= {}
    for threat, level of robot.brain.data['threat']
      msg.send "THREAT #{threat}: #{level}"
  
  # Delete threat
  # remove threat level ants
  robot.respond /remove threat level \s*(.*)?$/i, (msg) ->
    threat = msg.match[1]
    robot.brain.data['threat'] ||= {}
    delete robot.brain.data['threat'][threat]
