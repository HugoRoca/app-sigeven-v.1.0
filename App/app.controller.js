// Hugo Roca   
(function () {

  'use strict';

  angular.module('app').controller('applicationController', applicationController);

  applicationController.$inject = ['configService', 'authenticationService', 'localStorageService'];

  function applicationController(configService, authenticationService, localStorageService) {
    var vm = this;
    vm.logueado = true;

    vm.logout = logout;

    init();

    function init() {
      if (!configService.getLogin()) return vm.logueado = false;
    }

    function logout(){
      authenticationService.logout();
    }

  }

})();