// HUGO ROCA
(function () {

  'use strict';

  angular.module('app').config(config).run(run);

  config.$inject = ['$compileProvider'];

  function config($compileProvider) {
    $compileProvider.debugInfoEnabled(true);
  }

  run.$inject = ['$http', '$state', 'localStorageService', 'configService', '$rootScope'];

  function run($http, $state, localStorageService, configService, $rootScope) {

    pintaConsola();

    var user = localStorageService.get('userToken');
    if (user && user.token != '') {
      //$http.defaults.headers.common.Authorization = 'Bearer ' + user.token;

      configService.setLogin(true);
      $state.go('portal');
    } else {
      //$state.go('home');
      configService.setLogin(false);
      // location.href = 'login.html';
      // $state.go('inicio');
    }

  }


})();