(function () {
  'use strict';

  angular
    .module('app')
    .controller('ventaController', ventaController);

  ventaController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function ventaController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;
    vm.fecha;
    vm.Ventas = {
      cDescripcion: '',
      nArticulo: '',
      nPrecioVenta: 0,
      nCantidad: 0,
      nCantidadTotal: 0,
      nTotalVenta: 0,
      nStock: 0
    }

    vm.Articulo;
    vm.user;

    vm.buscaPrecio = buscaPrecio;
    vm.agregaFila = agregaFila;
    vm.eliminarFila = eliminarFila;
    vm.insertarVenta = insertarVenta;

    activate();

    ////////////////

    function activate() {
      authenticationService.validarSesion();
      var s = localStorageService.get('userToken');
      vm.user = s.userName;
      loadjQuery();
      var f = new Date();
      vm.fecha = getDateFormat(f);
      cargaComboArticulo();
    }

    function loadjQuery() {
      $('#txtFecha').mask('00/00/0000');
    }

    function buscaPrecio() {
      vm.Ventas.nPrecioVenta = 0;
      for (let index = 0; index < vm.Articulo.length; index++) {
        const element = vm.Articulo[index];
        if (element.Id == vm.Ventas.nArticulo) {
          vm.Ventas.nPrecioVenta = element.nPrecioVenta;
          vm.Ventas.cDescripcion = element.cDescripcion;
          vm.Ventas.nStock = element.nStock;
          $('#txtCantidad').focus();
        }
      }
    }

    function cargaComboArticulo() {
      dataService.getData('Server/articulo_lista.php').then(function (data) {
        vm.Articulo = data.data;
        //$('#cmbArticulos').selectpicker('render');
      }, function (error) {
        console.log(error);
      });
    }

    function agregaFila() {

      if (vm.Ventas.nPrecioVenta == 0) return toastr.warning('Precio de venta cero, no se puede agregar.', 'Validación');
      if (vm.Ventas.nCantidad == 0) return toastr.warning('Cantidad cero, no se puede agregar.', 'Validación');

      var existe = false;
      $('table tbody').find('input[name="record"]').each(function () {
        var id = parseInt($("td", $(this).parents("tr")).eq(1).text());
        if (id == vm.Ventas.nArticulo) existe = true;
      });

      if (existe) return toastr.warning('Este artículo ya fue agregado.', 'Validación');
      if (vm.Ventas.nCantidad > vm.Ventas.nStock) return toastr.warning('Stock insuficiente, no se puede agregar.', 'Validación');

      var cols = '';
      var total = Math.round(parseInt(vm.Ventas.nCantidad) * parseFloat(vm.Ventas.nPrecioVenta) * 100.00) / 100.00;

      cols += '<tr><td class="text-center"><input type="checkbox" name="record"></td>';
      cols += '<td class="text-right">' + vm.Ventas.nArticulo + '</td>';
      cols += '<td>' + vm.Ventas.cDescripcion + '</td>';
      cols += '<td class="text-right">S/ ' + vm.Ventas.nPrecioVenta + '</td>';
      cols += '<td class="text-right">' + vm.Ventas.nCantidad + '</td>';
      cols += '<td class="text-right">S/ ' + total + '</td></tr>';

      vm.Ventas.nCantidadTotal += vm.Ventas.nCantidad;
      vm.Ventas.nTotalVenta += total;

      //newRow.append(cols);
      $('table tbody').append(cols);

      vm.Ventas.nPrecioVenta = 0;
      vm.Ventas.cDescripcion = '';
      vm.Ventas.nCantidad = 0;
      vm.Ventas.nArticulo = '';
    }

    function eliminarFila() {
      bootbox.confirm("¿Desea continuar?", function (result) {
        if (result) {
          $("table tbody").find('input[name="record"]').each(function () {
            if ($(this).is(":checked")) {
              var cantidad = parseInt($("td", $(this).parents("tr")).eq(4).text());
              var total = $("td", $(this).parents("tr")).eq(5).text();
              total = total.replace('S/ ', '');

              vm.Ventas.nCantidadTotal -= cantidad;
              vm.Ventas.nTotalVenta -= parseFloat(total);

              $(this).parents("tr").remove();
            }
          });
          toastr.success('Los artículos fueron eliminados de la lista.', 'Eliminación');
        }
      });
    }

    function insertarVenta() {
      if (vm.fecha == '') return toastr.warning('Debe de seleccionar una fecha', 'Validación');
      if (vm.Ventas.nCantidadTotal <= 0) return toastr.warning('Debe de agregar artículos.', 'Validación');

      bootbox.confirm("¿Desea continuar?", function (result) {
        if (result) {
          var fecha = vm.fecha.split('/');
          var fechaYMD = fecha[2] + '-' + fecha[1] + '-' + fecha[0];
          var ventaArray = [];
          $('table tbody').find('input[name="record"]').each(function () {
            var cantidad = parseInt($("td", $(this).parents("tr")).eq(4).text());
            var id = parseInt($("td", $(this).parents("tr")).eq(1).text());
            ventaArray.push({
              nId: id,
              nCant: cantidad,
              dFecha: fechaYMD,
              cUser: vm.user
            });
          });

          dataService.postData('Server/venta_insertar.php', ventaArray).then(function (data) {
            console.log(data);
            if (data.data == 'ok') {
              toastr.success('Datos registrados correctamente!', 'Registro');
              $state.go('portal');
            }
          }, function (error) {
            console.log(error);
          });
        }
      });

    }
  }
})();