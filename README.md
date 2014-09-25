# Shazbot Hubot

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

`hubot color purple` will display message in Slack with the hex and RGB color codes for the given color. Pass it color names, hex values, RGB values, and other formats. Uses [TinyColor](https://github.com/bgrins/TinyColor) for parsing.

## How to Deploy to Heroku

    heroku create

Make note of the URL Heroku puts it on, then use that URL:

    heroku config:set HEROKU_URL=http://some-heroku-name-1234.herokuapp.com
    heroku ps:scale web=1
    heroku addons:add redistogo:nano

In your Slack, set up an integration with Hubot. Point to the Heroku server
where you deployed it. Slack will tell you three environment variables you need
to set:

    heroku config:add HUBOT_SLACK_TOKEN=123abc
    heroku config:add HUBOT_SLACK_TEAM=myteam
    heroku config:add HUBOT_SLACK_BOTNAME=shazbot

In your Slack chat, you should now be able to say:

    shazbot color
    shazbot colors
    shazbot color blue
    shazbot color #ff00ff
    shazbot colors 3
    shazbot colors 4 red
    shazbot clever good morning
