// Hugo Roca
(function () {

  'use strict';

  angular.module('app').controller('loginController', loginController);

  loginController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

  function loginController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
    var vm = this;
    vm.usuario = {
      cUsuario: '',
      cContrasenia: ''
    };

    vm.login = login;

    init();

    function init() {
      if (configService.getLogin()) return location.href = 'index.html#!/portal';;
    }

    function login(val) {
      if (val){
        authenticationService.login(vm.usuario);
      }else{
        toastr.warning('Debe de completar los datos!', 'Logueo');
      }
      
    }

  }
})();