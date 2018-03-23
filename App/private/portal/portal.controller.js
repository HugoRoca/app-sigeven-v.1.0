(function () {
  'use strict';

  angular
    .module('app')
    .controller('portalController', portalController);

  portalController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function portalController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;
    vm.mostrar = true;
    vm.promedioVentas = 0;
    vm.promedioGastos;
    vm.totalArticulos;
    vm.totalVentas;

    init();

    function init() {
      listaTopArticulo();
      listaTopVenta();
      consulta();
    }

    function consulta() {
      dataService.getData('Server/dashboard_consulta.php').then(function (data) {
        if (data.data.length > 0) {
          vm.promedioVentas = ponerADecimales(data.data[0].nPromedioVentas,2);
          vm.promedioGastos = ponerADecimales(data.data[0].nPromedioGasto,2);;
          vm.totalArticulos = data.data[0].nArticulos;
          vm.totalVentas = data.data[0].nVentas;
        }
      }, function (error) {
        authenticationService.errorValida(error);
      });
    }

    function listaTopVenta() {
      dataService.getData('Server/venta_listaPorSemana.php').then(function (data) {
        if (data.data.length > 0) {
          Morris.Bar({
            element: 'ventaSemana',
            data: data.data,
            xkey: 'y',
            ykeys: ['a', 'b'],
            labels: ['Ventas', 'Gastos'],
            hideHover: 'auto',
            resize: true
          });
        } else {
          toastr.warning('No hay datos', 'Dashboard');
        }
      }, function (error) {
        authenticationService.errorValida(error);
      });
    }

    function listaTopArticulo() {
      dataService.getData('Server/articulo_top.php').then(function (data) {
        var data = data.data;
        console.log(data);
        if (data.length > 0) {
          var plotObj = $.plot($("#articulosMasVendidos"), data, {
            series: {
              pie: {
                show: true
              }
            },
            grid: {
              hoverable: true
            },
            tooltip: true,
            tooltipOpts: {
              content: "%p.0%, %s",
              shifts: {
                x: 50,
                y: 0
              },
              defaultTheme: false
            }
          });
        }
      }, function (error) {
        authenticationService.errorValida(error);
      });
    }

  }
})();