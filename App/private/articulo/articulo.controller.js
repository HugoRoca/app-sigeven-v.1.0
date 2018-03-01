(function () {
  'use strict';

  angular
    .module('app')
    .controller('articuloController', articuloController);

  articuloController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function articuloController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;


    activate();

    ////////////////

    function activate() {console.log('articulos');}
  }
})();