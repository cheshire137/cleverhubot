# My Hubot

A Hubot set up for use in Slack with some custom scripts.

## How to Run

1. `npm install`
1. `bin/hubot`

## Custom Scripts

### Cleverbot

Inside `bin/hubot`:

    % bin/hubot
    Hubot> [Wed Sep 24 2014 22:09:29 GMT-0400 (EDT)] INFO Data for hubot brain retrieved from Redis

    Hubot> hubot clever good evening
    Hubot> Good evening to you also.
    Hubot> hubot clever "what is for dinner?"
    Hubot> Dinner is for to eat.
    Hubot> hubot clever tell me a joke
    Hubot> A quiet woman walked into a room.

### Colors

Inside `bin/hubot`:

    % bin/hubot
    Hubot> [Thu Sep 25 2014 00:20:08 GMT-0400 (EDT)] INFO Data for hubot brain retrieved from Redis
    Hubot> hubot color purple
    Hubot> purple:  #800080 rgb(128, 0, 128)
    Hubot> hubot color #ff00ff
    Hubot> #ff00ff: rgb(255, 0, 255)

## How to Deploy to Heroku

    heroku create

Make note of the URL Heroku puts it on, then use that URL:

    heroku config:set HEROKU_URL=http://some-heroku-name-1234.herokuapp.com

Then:

    heroku config:add HUBOT_SLACK_TOKEN=123abc
    heroku config:add HUBOT_SLACK_TEAM=myteam
    heroku config:add HUBOT_SLACK_BOTNAME=slackbot
    heroku ps:scale web=1
    heroku addons:add redistogo:nano
