(function () {
  'use strict';

  angular
    .module('app')
    .controller('articuloController', articuloController);

  articuloController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function articuloController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;
    vm.lista = {
      Id:0,
      cDescripcion:'',
      cMarca:'',
      cTipo:'',
      nMarca:0,
      nTipo:0,
      nPrecioVenta:0,
      nPrecioCompra:0,
      nStock:0
    }

    activate();

    ////////////////

    function activate() {
      dataService.getData('Server/articulo_lista.php').then(function (data) {
        vm.lista = data.data;
      }, function (error) {
        console.log(error);
      });
      console.log('articulos');
    }
  }
})();