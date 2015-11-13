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
    variables.configLocation = getDirectoryFromPath( getCurrentTemplatePath() )  & "config";
    variables.configName = "config.ini";
    return this;
  }

  function run( ) {
    print.line('Checking your Twitter auth credentials have been set...');
    var isGo = validateConfig();
    print.line('Done');
  }


}
