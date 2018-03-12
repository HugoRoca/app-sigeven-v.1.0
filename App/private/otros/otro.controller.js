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

        activate();

        function activate() {
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
                console.log(error);
            });
        }

        function llenaTipo() {
            dataService.postData('Server/catalogoCodigo_Lista.php', {
                Id: 1000,
                nTip: 0
            }).then(function (tipo) {
                vm.Tipos = tipo.data
            }, function (error) {
                console.log(error);
            });
        }

        function registrar() {

        }

        function editar(id, desc, val, est) {
            vm.Otros = {
                nId: id + '',
                cValor: val,
                cDescripcion: desc,
                nEstado: (est ? true : false)
            }
        }
    }
})();