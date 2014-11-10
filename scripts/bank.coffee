# Description:
#   Banker
#
# Commands:
#   hubot bank create_account - Create a bank account
#   hubot bank transfer <amount> <user> - Transfer some money to someone else
#   hubot bank bankruptcy - Close your account
#   hubot bank balance - Show current balance
#
# Author:
#   nuex

module.exports = (bot) ->
  bot.respond /bank create_account/i, (msg) ->
    opening_balance = 100
    today = new Date
    day = today.getDate()
    month = today.getMonth()
    year = today.getYear()
    formatted_date = "#{year}-#{month}-#{day}"
    bank = {}
    bank.balance = opening_balance
    bank.transactions = []
    bank.transactions.push([formatted_date, 'Initial', opening_balance])
    msg.message.user.bank = bank
    msg.send "Created Account for #{msg.message.user.name}"

  bot.respond /bank transfer (.*)/i, (msg) ->
    input = escape(msg.match[1])
    input = input.split(/ /)
    amount = input[0].trim()
    name = input[1].trim()
    msg.send "Amount #{amount} transferred to #{name}"

  bot.respond /bank balance/i, (msg) ->
    user = msg.message.user
    name = user.name
    bank = user.bank 
    msg.send "Balance for #{name} is #{bank.balance}"

  bot.respond /bank register/i, (msg) ->
    name = msg.message.user.name
    heading = "#{name}'s Bank Transactions"
    msg.send heading
    underline = Array(heading.length + 1).join('=')
    msg.send underline
    for transaction in msg.message.user.bank.transactions
      msg.send "#{transaction[0]}: #{transaction[1]} #{transaction[2]}"
    msg.send underline
