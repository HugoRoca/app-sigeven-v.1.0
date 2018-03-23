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

        vm.user;

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
            if (isNaN(vm.Gasto.nMonto)) return toastr.warning('Monto incorrecto.', 'Validación');
            if (vm.Gasto.cDescripcion == '') return toastr.warning('Debe de ingresar una descripción del gasto.', 'Validación');
            if (vm.Gasto.nMonto == 0) return toastr.warning('Debe de ingresar en monto.', 'Validación');

            var cols = '';

            cols += '<tr><td class="text-center"><input type="checkbox" name="record"></td>';
            cols += '<td>' + vm.Gasto.cDescripcion + '</td>';
            cols += '<td class="text-right">S/ ' + formatoMiles(vm.Gasto.nMonto) + '</td>';

            vm.Gasto.nGastos += 1;
            vm.Gasto.nTotalGasto += parseFloat(vm.Gasto.nMonto);

            $('table tbody').append(cols);

            vm.Gasto.cDescripcion = '';
            vm.Gasto.nMonto = 0;

            $('#txtDescripcion').focus();

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
            if (vm.Gasto.dFecha == '') return toastr.warning('Debe de colocar una fecha.', 'Validación');
            if (vm.Gasto.nGastos <= 0) return toastr.warning('Debe de agregar gastos.', 'validación');

            bootbox.confirm("¿Desea continuar?", function (result) {
                if (result) {
                    var fecha = vm.Gasto.dFecha.split('/');
                    var fechaYMD = fecha[2] + '-' + fecha[1] + '-' + fecha[0];
                    var gastoArray = [];
                    $('table tbody').find('input[name="record"]').each(function () {
                        var cDesc = $("td", $(this).parents("tr")).eq(1).text();
                        var nTot = $("td", $(this).parents("tr")).eq(2).text();

                        gastoArray.push({
                            cDesc: cDesc,
                            nTot: parseFloat(nTot.replace('S/ ', '')),
                            dFecha: fechaYMD,
                            cUser: vm.user
                        });
                    });

                    dataService.postData('Server/gasto_insertar.php', gastoArray).then(function (data) {
                        console.log(data);
                        if (data.data == 'ok') {
                            toastr.success('Datos registrados correctamente!', 'Registro');
                            $state.go('portal');
                        }
                    }, function (error) {
                        authenticationService.errorValida(error);
                    });
                }
            });
        }
    }
})();