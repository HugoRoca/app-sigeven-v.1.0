// Hugo Roca   
(function () {

  'use strict';

  angular.module('app').controller('applicationController', applicationController);

  applicationController.$inject = ['configService', 'authenticationService', 'localStorageService', '$state'];

  function applicationController(configService, authenticationService, localStorageService, $state) {
    var vm = this;
    vm.logueado = true;

    vm.logout = logout;

    init();

    function init() {
      if (!configService.getLogin()) return location.href = 'login.html';
      $state.go('portal');
    }

    function logout(){
      authenticationService.logout();
    }

  }

})();