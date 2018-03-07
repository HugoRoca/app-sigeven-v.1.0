(function () {
  'use strict';

  angular
    .module('app')
    .controller('articuloController', articuloController);

  articuloController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function articuloController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;

    vm.Articulos = {
      cDescripcion: '',
      nStock: '',
      nMarca: '',
      nTipo: '',
      nPrecioCompra: '',
      nPrecioVenta: ''
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

    vm.llenaMarca = llenaMarca;
    vm.llenaTipo = llenaTipo;
    vm.llenaArticulo = llenaArticulo;
    vm.insertar = insertar;

    activate();

    ////////////////

    function activate() {
      llenaArticulo();
      llenaMarca();
      llenaTipo();
    }

    function llenaMarca() {
      dataService.postData('Server/catalogoCodigo_Lista.php', {
        Id: 2000
      }).then(function (marca) {
        vm.Marca = marca.data;
      }, function (error) {
        console.log(error);
      });
    }

    function llenaTipo() {
      dataService.postData('Server/catalogoCodigo_Lista.php', {
        Id: 1000
      }).then(function (tipo) {
        vm.Tipos = tipo.data
      }, function (error) {
        console.log(error);
      });
    }

    function llenaArticulo() {
      dataService.getData('Server/articulo_lista.php').then(function (data) {
        vm.lista = data.data;
      }, function (error) {
        console.log(error);
      });
    }

    function insertar(valid) {
      if (valid) {
        if (isNaN(vm.Articulos.nStock)) return toastr.warning('Cantidad no permitida.', 'Validación');
        if (isNaN(vm.Articulos.nPrecioCompra)) return toastr.warning('Precio de compra no permitida.', 'Validación');
        if (isNaN(vm.Articulos.nPrecioVenta)) return toastr.warning('Precio de venta no permitida.', 'Validación');

        bootbox.confirm("¿Desea continuar?", function (result) {
          if(result){
            dataService.postData('Server/articulo_insert.php', {
              articulo: vm.Articulos
            }).then(function (data) {
              llenaArticulo();
              $('#Articulo').modal('hide');
              vm.Articulos = {
                cDescripcion: '',
                nStock: '',
                nMarca: '',
                nTipo: '',
                nPrecioCompra: '',
                nPrecioVenta: ''
              }
            }, function (error) {
              console.log(error);
            });
          }
        });
      } else {
        toastr.warning('Debe de completar los campos obligatorios.', 'Validación');
      }
    }
  }
})();