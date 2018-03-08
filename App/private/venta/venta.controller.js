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
      cDescripcion:'',
      nArticulo: '',
      nPrecioVenta: 0,
      nCantidad: 0
    }

    vm.Articulo;

    vm.buscaPrecio = buscaPrecio;
    vm.agregaFila = agregaFila;

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
        yearRange: "-100:-17",
        defaultDate: "-17y-m-d"
      });


    }

    function buscaPrecio() {
      for (let index = 0; index < vm.Articulo.length; index++) {
        const element = vm.Articulo[index];
        if (element.Id == vm.Ventas.nArticulo) {
          vm.Ventas.nPrecioVenta = element.nPrecioVenta;
          vm.Ventas.cDescripcion = element.cDescripcion;
          $('#txtCantidad').focus();
        }
      }
    }

    function cargaComboArticulo() {
      dataService.getData('Server/articulo_lista.php').then(function (data) {
        vm.Articulo = data.data;
        console.log(data.data);
        //$('#cmbArticulos').selectpicker('render');
      }, function (error) {
        console.log(error);
      });
    }

    function agregaFila() {
      var table = document.getElementById("tblVentas");

      var row = document.createElement("tr");
      var td1 = document.createElement("td");//ID
      var td2 = document.createElement("td");//Articulo
      var td3 = document.createElement("td");//Precio
      var td4 = document.createElement("td");//Cantidad
      var td5 = document.createElement("td");//Total

      td1.innerHTML = vm.Ventas.nArticulo;
      td2.innerHTML = vm.Ventas.cDescripcion;
      td3.innerHTML = vm.Ventas.nPrecioVenta;
      td4.innerHTML = vm.Ventas.nCantidad;
      td5.innerHTML = parseInt(vm.Ventas.nCantidad) * parseFloat(vm.Ventas.nPrecioVenta);

      row.appendChild(td1);
      row.appendChild(td2);
      row.appendChild(td3);
      row.appendChild(td4);
      row.appendChild(td5);

      table.children[0].appendChild(row);
    }
  }
})();