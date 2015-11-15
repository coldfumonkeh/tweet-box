component extends="commandbox.system.BaseCommand" {

  function init() {
    super.init();
    return this;
  }

  /**
  * Copies the skeleton config.ini file into the config directory if it does not exist.
  */
  private function copySkeletonConfig() {
    FileCopy( shell.getConfigSettings().modules.tweetbox.path & "/resources/config.ini.bak", variables.configLocation & '/' & variables.configName);
  }

  /**
  * Validates the configuration file and contents. If no file exists it will create it
  * then ask for all credentials. If the file exists it will ask the user for all missing credentials.
  * Validation will be recursive until all values are set, at which point we can proceed with Tweeting.
  */
  private any function validateConfig() {
    var arrAuthErrs = [];
    var isGo = false;

    if ( !DirectoryExists(configLocation) ) {
      print.line('Config directory does not exist. Creating...').line();
      DirectoryCreate(variables.configLocation);
      print.boldWhiteTextOnGreen('Done').line();
      print.line('Copying skeleton configuration file...').line();
      copySkeletonConfig();
      print.boldWhiteTextOnGreen('Done').line();
      validateConfig();
    }


    if ( !FileExists(variables.configLocation & '\' & variables.configName) ) {
      print.line('Copying skeleton configuration file...').line();
      copySkeletonConfig();
      print.boldWhiteTextOnGreen('Done').line();
      validateConfig();

    } else {
      var sections = GetProfileSections(variables.configLocation & '\' & variables.configName);
      var items = sections['cbtweet'];

      for (item in ListToArray(items, ",")) {
        if ( !len(GetProfileString(variables.configLocation & '\' & variables.configName, 'cbtweet', item)) ) {
          arrAuthErrs.append(item);
        }
      }

      if (arrAuthErrs.len()) {
        print
          .line()
          .boldRed('To run the tweet post command you must set the following authentication values.')
          .line()
          .boldRed('You can create and get your oauth and client tokens after you have created an app on Twitter.')
          .line()
          .boldRed('Please visit https://apps.twitter.com to set up your application (it is free to do so)')
          .line()
          .boldRed('----------')
          .line();

        arrAuthErrs.each(function(element, index, array) {
          var missingAnswer = ask('Please enter the ' & element & ': ');
          SetProfileString(variables.configLocation & '\' & variables.configName, 'cbtweet', element, missingAnswer);
        });

        print
          .line()
          .boldRed('----------')
          .line();

      } else {
        isGo = true;
      }

    }
    return isGo;
  }


  /**
  * Returns a struct containing the authentication values from the config file which can
  * then be passed into the constructor method of the monkehTweets package.
  */
  private struct function getInitArgs() {
    var sections = GetProfileSections(variables.configLocation & '\' & variables.configName);
    var items = sections['cbtweet'];
    var stuArgs = {};
    for (item in ListToArray(items, ",")) {
      StructInsert(stuArgs, item, GetProfileString(variables.configLocation & '\' & variables.configName, 'cbtweet', item));
    }
    StructInsert(stuArgs, 'parseResults', true);
    return stuArgs;
  }



}
