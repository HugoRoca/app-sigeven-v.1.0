(function () {
  'use strict';

  angular
    .module('app')
    .controller('articuloController', articuloController);

  articuloController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function articuloController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;

    vm.Articulos = {
      nId: 0,
      cDescripcion: '',
      nStock: '',
      nMarca: '',
      nTipo: '',
      nPrecioCompra: '',
      nPrecioVenta: '',
      cUser: ''
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
    vm.tituloModal = '';
    vm.accion = '';
    vm.user;

    vm.llenaMarca = llenaMarca;
    vm.llenaTipo = llenaTipo;
    vm.llenaArticulo = llenaArticulo;
    vm.insertarEditar = insertarEditar;
    vm.listaPorId = listaPorId;
    vm.cancelaModal = cancelaModal;
    vm.anular = anular;

    activate();

    ////////////////

    function activate() {
      authenticationService.validarSesion();
      llenaArticulo();
      llenaMarca();
      llenaTipo();
      vm.tituloModal = 'Nuevo Artículo';
      var s = localStorageService.get('userToken');
      vm.user = s.userName;

      cargaJQuery();

    }

    function cargaJQuery() {

      $("#txtBuscar").on("keyup", function () {
        var value = $(this).val().toLowerCase();
        $("#tblArticulo tbody tr").filter(function () {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
      });
    }

    function llenaMarca() {
      dataService.postData('Server/catalogoCodigo_Lista.php', {
        Id: 2000,
        nTip: 1
      }).then(function (marca) {
        vm.Marca = marca.data;
      }, function (error) {
        authenticationService.errorValida(error);
      });
    }

    function llenaTipo() {
      dataService.postData('Server/catalogoCodigo_Lista.php', {
        Id: 1000,
        nTip: 1
      }).then(function (tipo) {
        vm.Tipos = tipo.data
      }, function (error) {
        authenticationService.errorValida(error);
      });
    }

    function llenaArticulo() {
      dataService.getData('Server/articulo_lista.php').then(function (data) {
        vm.lista = data.data;
        vm.accion = 'nuevo';
      }, function (error) {
        authenticationService.errorValida(error);
      });
    }

    function insertarEditar(valid) {
      if (valid) {

        if (isNaN(vm.Articulos.nStock)) return toastr.warning('Cantidad no permitida.', 'Validación');
        if (isNaN(vm.Articulos.nPrecioCompra)) return toastr.warning('Precio de compra no permitida.', 'Validación');
        if (isNaN(vm.Articulos.nPrecioVenta)) return toastr.warning('Precio de venta no permitida.', 'Validación');
        vm.Articulos.cUser = vm.user;
        bootbox.confirm("¿Desea continuar?", function (result) {
          if (result) {
            $('#Articulo').modal('hide');
            if (vm.accion == 'nuevo') {
              dataService.postData('Server/articulo_insert.php', {
                articulo: vm.Articulos
              }).then(function (data) {
                limpiador();
              }, function (error) {
                authenticationService.errorValida(error);
              });
            } else {
              dataService.postData('Server/articulo_actualizar.php', {
                articulo: vm.Articulos
              }).then(function (data) {
                limpiador();
              }, function (error) {
                authenticationService.errorValida(error);
              });
            }
          }
        });
      } else {
        toastr.warning('Debe de completar los campos obligatorios.', 'Validación');
      }
    }

    function limpiador() {
      llenaArticulo();
      
      vm.Articulos = {
        cDescripcion: '',
        nStock: '',
        nMarca: '',
        nTipo: '',
        nPrecioCompra: '',
        nPrecioVenta: ''
      }
    }

    function listaPorId(id) {
      dataService.postData('Server/articulo_listaPorId.php', {
        Id: id
      }).then(function (data) {
        vm.tituloModal = 'Editando Artículo...';
        vm.Articulos.nId = data.data[0].Id;
        vm.Articulos.cDescripcion = data.data[0].cDescripcion;
        vm.Articulos.nMarca = data.data[0].nMarca + '';
        vm.Articulos.nTipo = data.data[0].nTipo + '';
        vm.Articulos.nStock = data.data[0].nStock;
        vm.Articulos.nPrecioCompra = data.data[0].nPrecioCompra;
        vm.Articulos.nPrecioVenta = data.data[0].nPrecioVenta;
        vm.accion = 'editar';
        $('#Articulo').modal('show');
      }, function (error) {
        authenticationService.errorValida(error);
      });
    }

    function cancelaModal() {
      $('#Articulo').modal('hide');
      vm.Articulos = {
        cDescripcion: '',
        nStock: '',
        nMarca: '',
        nTipo: '',
        nPrecioCompra: '',
        nPrecioVenta: ''
      }
      vm.accion = 'nuevo';
    }

    function anular(id) {
      bootbox.confirm("¿Desea continuar?", function (result) {
        if (result) {
          dataService.postData('Server/articulo_anular.php', {
            Id: id
          }).then(function (data) {
            llenaArticulo();
          }, function (error) {
            authenticationService.errorValida(error);
          });
        }
      });
    }

  }
})();