// Hugo Roca
(function () {

  'use strict';

  angular.module('app').factory('dataService', dataService);

  dataService.$inject = ['$http', '$state', 'localStorageService', 'configService'];

  function dataService($http, $state, localStorageService, configService) {
    var service = {};
    service.getData = getData;
    service.postData = postData;
    service.putData = putData;
    service.deleteData = deleteData;

    return service;

    function salir() {
      if (configService.getLogin()) {
        var user = localStorageService.get('userToken');
        if (user && user.token != '') {} else {
          $http.defaults.headers.common.Authorization = '';
          configService.setLogin(false);
          configService.setShowLogin(false);
        }
      } else {
        //pintaConsola();
      }
    }

    function getData(url) {
      return $http.get(url);
    }

    function postData(url, data) {
      return $http.post(url, data);
    }

    function putData(url, data) {
      return $http.put(url, data);
    }

    function deleteData(url) {
      return $http.delete(url);
    }
  }

})();