(function () {
  'use strict';

  angular
    .module('app')
    .controller('ventaController', ventaController);

  ventaController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function ventaController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;
    vm.fecha;

    activate();

    ////////////////

    function activate() {
      var f = new Date();
      vm.fecha = getDateFormat(f);
    }
  }
})();