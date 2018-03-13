(function () {
    'use strict';

    angular
        .module('app')
        .controller('proveedorController', proveedorController);

    proveedorController.$inject = ['configService', 'authenticationService', 'localStorageService', 'dataService', 'toastr', '$state'];

    function proveedorController(configService, authenticationService, localStorageService, dataService, toastr, $state) {
        var vm = this;
        vm.Proveedor = {
            dFecha: '',
            cNomProveedor: '',
            cArticulo: '',
            nArticulo: 0,
            nPrecioCompra: 0,
            nPrecioVenta: 0,
            nCantidad: 0,
            nStock: 0,
            cUser: ''
        }
        vm.Articulo;

        vm.seleccionaArticulo = seleccionaArticulo;
        vm.llamaModal = llamaModal;
        vm.agregarFila = agregarFila;

        activate();

        ////////////////

        function activate() {
            authenticationService.validarSesion();
            var s = localStorageService.get('userToken');
            vm.Proveedor.cUser = s.userName;
            var f = new Date();
            vm.Proveedor.dFecha = getDateFormat(f);
            loadjQuery();
            cargaArticulos();
        }

        function loadjQuery() {
            $('#txtFecha').mask('00/00/0000');

            $("#txtBuscarArticulo").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#tblArticuloProveedor tbody tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }

        function cargaArticulos() {
            dataService.getData('Server/articulo_lista.php').then(function (data) {
                vm.Articulo = data.data;
                //$('#cmbArticulos').selectpicker('render');
            }, function (error) {
                console.log(error);
            });
        }

        function seleccionaArticulo(id, precio, descripcion, stock, compra) {
            vm.Proveedor.nPrecioVenta = 0;
            vm.Proveedor.nArticulo = id;
            vm.Proveedor.nPrecioVenta = ponerADecimales(precio, 2);
            vm.Proveedor.cArticulo = descripcion;
            vm.Proveedor.nStock = stock;
            vm.Proveedor.nPrecioCompra = ponerADecimales(compra, 2);
            $('#ArticulosProveedor').modal('hide');
            $('#txtCantidad').focus();
        }

        function llamaModal() {
            $('#ArticulosProveedor').modal('show');
        }

        function agregarFila() {
            if (vm.Proveedor.nArticulo == 0) return toastr.warning('Falta seleccionar artículo.', 'Validación');
            if (isNaN(vm.Proveedor.nPrecioCompra)) return toastr.warning('Precio de compra no permitida.', 'Validación');
            if (isNaN(vm.Proveedor.nPrecioVenta)) return toastr.warning('Precio de venta no permitida.', 'Validación');
            if (vm.Proveedor.nCantidad == 0) return toastr.warning('Falta cantidad del artículo.', 'Validación');

            

        }
    }
})();