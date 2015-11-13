/**
 * Post status updates to Twitter from CommandBox. Awesome, right?
 * .
 * {code:bash}
 * tweet post {message}
 * {code}
 *
 **/
component extends="base" aliases="status,post" excludeFromHelp=false {

  /**
	* Constructor
	*/
  function init() {
    super.init();
    variables.configLocation = getDirectoryFromPath( getCurrentTemplatePath() )  & "config";
    variables.configName = "config.ini";
    return this;
  }

  /**
  * @message.hint The message you want to tweet to the world
  * @dm.hint Whether or not the message should be a direct message
  * @recipient.hint The name of the recipient of the direct message (if dm is true)
	**/
	function run( string message = '', boolean dm = false, string recipient = '' ) {
    var result = '';
    var isGo = validateConfig();
    var objMonkehTweet = createObject('component', 'monkehTweets.monkehtweets.com.coldfumonkeh.monkehTweet').init(argumentCollection=getInitArgs());

    if ( isGo ) {
      if( len( arguments.message ) ) {
        if ( dm ) {
          if ( len(arguments.recipient) ) {
            result = objMonkehTweet.createDM(text=arguments.message, screen_name=arguments.recipient);
          } else {
            print
              .line()
              .boldRed('You must provide a recipient Twitter user for a direct message.')
              .line();
          }
        } else {
           result = objMonkehTweet.postUpdate(status=arguments.message);
        }
        print
        .line()
        .boldWhiteTextOnGreen( message )
        .line();
      } else {
        print
        .line()
        .boldWhiteTextOnRed( 'You must provide a message to tweet.' )
        .line();
      }
    } else {

    }

	}

}
