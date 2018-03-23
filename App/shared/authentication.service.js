// Hugo Roca
(function () {

  'use strict';

  angular.module('app').factory('authenticationService', authenticationService);

  authenticationService.$inject = ['$http', '$state', 'localStorageService', 'configService', 'toastr', 'dataService'];

  function authenticationService($http, $state, localStorageService, configService, toastr, dataService) {
    var service = {};
    service.login = login;
    service.logout = logout;
    service.errorValida = errorValida;
    service.validarSesion = validarSesion;

    return service;

    function login(user) {
      dataService.postData('Server/usuario-validate.php', {
        usuario: user
      }).then(function (data) {
        console.log(data);
        //$http.defaults.headers.common.Authorization = 'Bearer ' + result.data.access_token;
        if (data.data.length > 0) {
          localStorageService.set('userToken', {
            token: 'aqui va un token', //result.data.access_token,
            userName: data.data[0].cNomUsu,
            id: data.data[0].Id
          });
          configService.setLogin(true);
          location.href = 'index.html#!/portal';
          toastr.success('Has ingresado correctamente al sistema.', 'BIENVENIDO');
        } else {
          toastr.warning('Usuario y/o contraseña incorrecto.', 'LOGIN');
        }
      }, function (error) {
        errorValida(error);
      });
    }

    function logout() {
      //$http.defaults.headers.common.Authorization = '';
      localStorageService.remove('userToken');
      configService.setLogin(false);
      location.href = 'login.html';
    }

    function errorValida(error) {
      console.log(error);
      modalCargaCerrar();
      if (error.statusText == 'Unauthorized') {
        toastr.warning('Tu sesion a caducado, por favor vuelve a iniciar!', 'Alerta');
        logout();
      } else if (error.statusText == 'Bad Request') {
        if (error.data.error == 'invalid_grant') {
          console.log('Usuario y/o contrasenia invalidos!!!');
        }
        toastr.error('Sucedió un error inesperado, por favor inténtalo en unos minutos y si el error persiste comuníquese con el ADM.', 'Error');
      } else if (error.statusText == 'Internal Server Error') {
        toastr.error('Tu conexión a internet es muy lenta, por favor verifica tu señal de internet.', 'Soy Lucas');
        logout();
      }
      pintaConsola();
    }

    function validarSesion() {
      var user = localStorageService.get('userToken');
      if (!user) {
        logout();
      } else {
        return true;
      }
    }


  }

})();