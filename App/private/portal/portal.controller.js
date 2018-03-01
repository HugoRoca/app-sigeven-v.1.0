(function () {
  'use strict';

  angular
    .module('app')
    .controller('portalController', portalController);

  portalController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function portalController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;

    vm.singOut = singOut;

    function singOut() {
      authenticationService.logout();
    }

  }
})();