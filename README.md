# Tweet-Box

Tweet-Box is a ColdBox Command that lets you post status updates and send direct messages through Twitter via the CLI.

## Installation

Firstly, you must have [CommandBox installed](http://ortus.gitbooks.io/commandbox-documentation/content/setup/installation.html)

Install this command into CommandBox CLI like so:
```bash
box install tweetbox
```

or

```bash
install tweetbox
```
if you are already inside the box environment.

You will also need to set up an app on Twitter to generate your oauth credentials (token and token secret values) as well as your consumer token and token secret values.

To do so, head over to https://apps.twitter.com, log in with your Twitter account and create a new application. Make a note of the values as you will be asked by the command to enter them before you can make any status updates.


## Functions

The following commands are available:


### tweet post

Posts a status update (or direct message) to Twitter

```bash
tweet post message="Posting from CommandBox!"
```

also available via the following aliases:

```bash
post message="foo"
```

or

```bash
status message="foo"
```


To send a direct message you will need to set the <code>dm</code> attribute to true and provide a <code>recipient</code> screen name, like so:

```bash
tweet post message="Hey!" dm=true recipient="@coldfumonkeh"
```

At present the command does nothing but repeat the posted message content into the console.

### tweet validate

Performs a validation check on the configuration file (saved locally within the custom command directory)
and prompts the user to input any missing required information from the config file:

* consumerKey
* consumerSecret
* oauthToken
* oauthTokenSecret
* userAccountName


## Why?

This was built for fun to experiment with the CommandBox architecture and to create something that others may find useful.

You could use it to:

* send a direct message to you after a test suite has been run
* post new build information to the general masses
* impress your friends
