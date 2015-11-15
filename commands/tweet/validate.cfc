/**
 * Validate the settings stored for your Twitter command.
 * .
 * {code:bash}
 * tweet validate
 * {code}
 *
 **/
component extends="base" aliases="validate" excludeFromHelp=false {

  /**
	* Constructor
	*/
  function init() { 
    super.init();
    variables.configName = "config.ini";
    return this;
  }
  
  function onDIComplete() {
    variables.configLocation = shell.getConfigSettings().modules.tweetbox.path & "/config";
  }

  function run( ) {
    print.line('Checking your Twitter auth credentials have been set...');
    var isGo = validateConfig();
    print.line('Done');
  }


}
