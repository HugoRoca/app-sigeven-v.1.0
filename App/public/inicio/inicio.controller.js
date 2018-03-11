(function () {
  'use strict';

  angular
    .module('app')
    .controller('inicioController', inicioController);

  inicioController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function inicioController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;


    activate();

    ////////////////

    function activate() {
      if(configService.getLogin()) return $state.go('portal');
    }
  }
})();