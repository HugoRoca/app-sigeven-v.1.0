(function () {
    'use strict';

    angular
        .module('app')
        .controller('otrosController', otrosController);

    otrosController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

    function otrosController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
        var vm = this;
        vm.Otros = {
            nId: 0,
            cValor: 0,
            cDescripcion: '',
            nEstado: 0
        }
        vm.Marca;
        vm.Tipos;

        vm.registrar = registrar;
        vm.editar = editar;
        vm.nuevo = nuevo;

        activate();

        function activate() {
            authenticationService.validarSesion();
            vm.Otros.nId = '';
            vm.Otros.nEstado = true;
            llenaMarca();
            llenaTipo();
        }

        function llenaMarca() {
            dataService.postData('Server/catalogoCodigo_Lista.php', {
                Id: 2000,
                nTip: 0
            }).then(function (marca) {
                vm.Marca = marca.data;
            }, function (error) {
                authenticationService.errorValida(error);
            });
        }

        function llenaTipo() {
            dataService.postData('Server/catalogoCodigo_Lista.php', {
                Id: 1000,
                nTip: 0
            }).then(function (tipo) {
                vm.Tipos = tipo.data
            }, function (error) {
                authenticationService.errorValida(error);
            });
        }

        function registrar() {
            if (vm.Otros.nId == 0) return toastr.warning('Falta seleccionar una clase.', 'Validación');
            if (vm.Otros.cDescripcion == '') return toastr.warning('Debe de tener una descripción.', 'validación');
            console.log(vm.Otros);
            bootbox.confirm("¿Desea continuar?", function (result) {
                if (result) {
                    dataService.postData('Server/catalogoCodigo_insertar.php', {
                        catalogo: vm.Otros
                    }).then(function (data) {
                        if (data.data == 'ok') toastr.success('Se registro correctamente.', 'Registro');
                        llenaMarca();
                        llenaTipo();
                        nuevo();
                    }, function (error) {
                        authenticationService.errorValida(error);
                    });
                }
            });
        }

        function editar(id, desc, val, est) {
            vm.Otros = {
                nId: id + '',
                cValor: val,
                cDescripcion: desc,
                nEstado: (est ? true : false)
            }
        }

        function nuevo() {
            vm.Otros = {
                nId: '',
                cValor: 0,
                cDescripcion: '',
                nEstado: true
            }
            $('#txtDescripcion').focus();
        }
    }
})();