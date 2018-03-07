(function () {
  'use strict';

  angular
    .module('app')
    .controller('articuloController', articuloController);

  articuloController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function articuloController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;

    vm.Articulos = {
      nMarca: 0,
      nTipo: 0
    }
    vm.lista = {
      Id: 0,
      cDescripcion: '',
      cMarca: '',
      cTipo: '',
      nMarca: 0,
      nTipo: 0,
      nPrecioVenta: 0,
      nPrecioCompra: 0,
      nStock: 0
    }

    vm.Marca = [];
    vm.Tipos = [];

    activate();

    ////////////////

    function activate() {
      dataService.getData('Server/articulo_lista.php').then(function (data) {
        vm.lista = data.data;

        dataService.postData('Server/catalogoCodigo_Lista.php', { Id: 2000 }).then(function (marca) {
          vm.Marca = marca.data;
          
          dataService.postData('Server/catalogoCodigo_Lista.php', { Id: 1000 }).then(function(tipo){
            vm.Tipos = tipo.data

          }, function (error){console.log(error);});
        }, function (error) {console.log(error);});
      }, function (error) {console.log(error);});
    }
  }
})();