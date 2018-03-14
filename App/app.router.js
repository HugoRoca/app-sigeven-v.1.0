// Hugo Roca
(function () {

  'use strict';

  angular.module('app').config(routeConfig);

  routeConfig.$inject = ['$stateProvider', '$urlRouterProvider'];

  function routeConfig($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('portal', {
        url: '/portal',
        templateUrl: 'App/private/portal/portal.html'
      })
      .state('articulo', {
        url: '/articulo',
        templateUrl: 'App/private/articulo/articulo.html'
      })
      .state('venta', {
        url: '/venta',
        templateUrl: 'App/private/venta/venta.html'
      })
      .state('gasto',{
        url: '/gasto',
        templateUrl: 'App/private/gasto/gasto.html'
      })
      .state('otro',{
        url: '/otro',
        templateUrl:'App/private/otros/otro.html'
      })
      .state('proveedor',{
        url: '/proveedor',
        templateUrl: 'App/private/proveedor/proveedor.html'
      })
      .state('consultaVenta', {
        url: '/consultaVenta',
        templateUrl: 'App/private/consultas/consultaVenta.html'
      })
      .state('consultaGasto', {
        url: '/consultaGasto',
        templateUrl: 'App/private/consultas/consultaGasto.html'
      })
      .state('consultaProveedor', {
        url: '/consultaProveedor',
        templateUrl: 'App/private/consultas/consultaProveedor.html'
      })
      .state('otherwise', {
        url: '*path',
        templateUrl: 'App/private/portal/portal.html'
      });

  }

})();