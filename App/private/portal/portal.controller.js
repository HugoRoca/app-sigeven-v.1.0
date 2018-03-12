(function () {
  'use strict';

  angular
    .module('app')
    .controller('portalController', portalController);

  portalController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function portalController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;

    init();

    function init() {
      console.log('portal');
      lista();
    }

    function lista(){
      dataService.getData('Server/articulo_top.php').then(function (data) {
        var data = data.data;
  console.log(data);
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
            content: "%p.0%, %s", // show percentages, rounding to 2 decimal places
            shifts: {
              x: 50,
              y: 0
            },
            defaultTheme: false
          }
        });
      }, function (error) {
        console.log(error);
      });
    }

  }
})();