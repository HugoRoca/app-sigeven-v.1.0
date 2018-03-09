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

    vm.buscaPrecio = buscaPrecio;
    vm.agregaFila = agregaFila;
    vm.eliminarFila = eliminarFila;

    activate();

    ////////////////

    function activate() {
      loadjQuery();
      var f = new Date();
      vm.fecha = getDateFormat(f);
      cargaComboArticulo();
    }

    function loadjQuery() {
      $('#txtFecha').mask('00/00/0000');

      $("#txtFecha").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd/mm/yy',
      });


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
      if (vm.Ventas.nCantidad > vm.Ventas.nStock) return toastr.warning('Stock insuficiente, no se puede agregar.','Validación');

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
    }
  }
})();