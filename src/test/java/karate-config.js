function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiURL: 'https://conduit.productionready.io/api/',

  }
  if (env == 'dev') {
    config.userEmail = 'vkykarate@karate.com'
    config.userPassword = 'karate123'
  } else if (env == 'qa') {
    config.userEmail = 'kkarate@karate.com'
    config.userPassword = 'karate12345'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).commonAuthToken //get the auth token from helper feature file, all these settings in config.js are global
  karate.configure('headers', {Authorization: 'Token ' + accessToken}) //Header is required for many request as well, so have it here 

  return config;
}