(function () {
    'use strict';

    angular
        .module('app')
        .controller('gastoController', gastoController);

    gastoController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

    function gastoController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
        var vm = this;
        vm.Gasto = {
            dFecha: '',
            cDescripcion: '',
            nMonto: 0,
            nGastos: 0,
            nTotalGasto: 0
        }

        vm.agregaFila = agregaFila;
        vm.eliminarFila = eliminarFila;
        vm.insertarGasto = insertarGasto;

        activate();

        ////////////////

        function activate() {
            console.log('gasto');
            authenticationService.validarSesion();
            var s = localStorageService.get('userToken');
            vm.user = s.userName;
            loadjQuery();
            var f = new Date();
            vm.Gasto.dFecha = getDateFormat(f);
        }

        function loadjQuery() {
            $('#txtFecha').mask('00/00/0000');
        }

        function agregaFila() {
            if(isNaN(vm.Gasto.nMonto)) return toastr.warning('Monto incorrecto.','Validación');
            if (vm.Gasto.cDescripcion == '') return toastr.warning('Debe de ingresar una descripción del gasto.', 'Validación');
            if (vm.Gasto.nMonto == 0) return toastr.warning('Debe de ingresar en monto.', 'Validación');

            var cols = '';

            cols += '<tr><td class="text-center"><input type="checkbox" name="record"></td>';
            cols += '<td>' + vm.Gasto.cDescripcion + '</td>';
            cols += '<td class="text-right">S/ ' + formatoMiles(vm.Gasto.nMonto) + '</td>';

            vm.Gasto.nGastos += 1;
            vm.Gasto.nTotalGasto += parseFloat(vm.Gasto.nMonto);

            //newRow.append(cols);
            $('table tbody').append(cols);

            vm.Gasto.cDescripcion = '';
            vm.Gasto.nMonto = 0;

        }

        function eliminarFila() {
            bootbox.confirm("¿Desea continuar?", function (result) {
                if (result) {
                    $("table tbody").find('input[name="record"]').each(function () {
                        if ($(this).is(":checked")) {
                            var total = $("td", $(this).parents("tr")).eq(2).text();
                            total = total.replace('S/ ', '');

                            vm.Gasto.nGastos -= 1;
                            vm.Gasto.nTotalGasto -= parseFloat(total);

                            $(this).parents("tr").remove();
                        }
                    });
                    toastr.success('Los gastos fueron eliminados de la lista.', 'Eliminación');
                }
            });
        }

        function insertarGasto() {

        }
    }
})();