(function () {
    'use strict';

    angular
        .module('app')
        .controller('consultaController', consultaController);

    consultaController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

    function consultaController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
        var vm = this;
        vm.Consulta = {
            dDesde: '',
            dHasta: '',
            cTitulo: '',
            nTotal: 0,
            nCantidad: 0
        }
        vm.Venta;
        vm.VentaDetalle;

        vm.buscaVentas = buscaVentas;
        vm.modalVenta = modalVenta;

        activate();

        ////////////////

        function activate() {
            authenticationService.validarSesion();
            var f = getDateFormat(new Date());
            vm.Consulta.dDesde = f;
            vm.Consulta.dHasta = f;
            loadjQuery();
        }

        function loadjQuery() {
            $('#txtFechaDesde').mask('00/00/0000');
            $('#txtFechaHasta').mask('00/00/0000');
        }

        function buscaVentas() {
            vm.Consulta.dDesde = PasarFechaGuionesMySql(vm.Consulta.dDesde);
            vm.Consulta.dHasta = PasarFechaGuionesMySql(vm.Consulta.dHasta);

            dataService.postData('Server/venta_consulta.php', vm.Consulta).then(function (data) {
                vm.Venta = data.data;
                vm.Consulta.dDesde = PasarFechaBarraMySql(vm.Consulta.dDesde);
                vm.Consulta.dHasta = PasarFechaBarraMySql(vm.Consulta.dHasta);
            }, function (error) {
                console.log(error);
            });
        }

        function modalVenta(id, tot, fech, cant) {
            vm.Consulta.cTitulo = fech;
            vm.Consulta.nTotal = 'S/ ' + formatoMiles(tot);
            vm.Consulta.nCantidad = cant;

            dataService.postData('Server/ventaDetalle_consulta.php', {nIdVenta: id}).then(function(data){
                vm.VentaDetalle = data.data;
            }, function(error){
                console.log(error);
            });

            $('#VentasDetalle').modal('show');
        }
    }
})();