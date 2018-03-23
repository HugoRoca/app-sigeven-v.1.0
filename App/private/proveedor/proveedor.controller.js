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
            nCantidadTotal: 0,
            nTotalProveedor: 0,
            cUser: ''
        }
        vm.Articulo;

        vm.seleccionaArticulo = seleccionaArticulo;
        vm.llamaModal = llamaModal;
        vm.agregarFila = agregarFila;
        vm.eliminarFila = eliminarFila;
        vm.insertarProveedor = insertarProveedor;

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
                authenticationService.errorValida(error);
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

            var existe = false;
            $('#tblProveedor tbody').find('input[name="record"]').each(function () {
                var id = parseInt($("td", $(this).parents("tr")).eq(1).text());
                if (id == vm.Proveedor.nArticulo) existe = true;
            });

            if (existe) return toastr.warning('Este artículo ya fue agregado.', 'Validación');

            var cols = '';
            var total = Math.round(parseInt(vm.Proveedor.nCantidad) * parseFloat(vm.Proveedor.nPrecioVenta) * 100.00) / 100.00;

            cols += '<tr><td class="text-center"><input type="checkbox" name="record"></td>';
            cols += '<td class="text-right">' + vm.Proveedor.nArticulo + '</td>';
            cols += '<td>' + vm.Proveedor.cArticulo + '</td>';
            cols += '<td class="text-right">S/ ' + vm.Proveedor.nPrecioCompra + '</td>';
            cols += '<td class="text-right">S/ ' + vm.Proveedor.nPrecioVenta + '</td>';
            cols += '<td class="text-right">' + vm.Proveedor.nCantidad + '</td>';
            cols += '<td class="text-right">S/ ' + total + '</td></tr>';

            vm.Proveedor.nCantidadTotal += vm.Proveedor.nCantidad;
            vm.Proveedor.nTotalProveedor += total;

            $('#tblProveedor tbody').append(cols);

            vm.Proveedor.nPrecioCompra = 0;
            vm.Proveedor.nPrecioVenta = 0;
            vm.Proveedor.nArticulo = 0;
            vm.Proveedor.cArticulo = '';
            vm.Proveedor.nCantidad = 0;
        }

        function eliminarFila() {
            bootbox.confirm("¿Desea continuar?", function (result) {
                if (result) {
                    $("#tblProveedor tbody").find('input[name="record"]').each(function () {
                        if ($(this).is(":checked")) {
                            var cantidad = parseInt($("td", $(this).parents("tr")).eq(5).text());
                            var total = $("td", $(this).parents("tr")).eq(6).text();
                            total = total.replace('S/ ', '');

                            vm.Proveedor.nCantidadTotal -= cantidad;
                            vm.Proveedor.nTotalProveedor -= parseFloat(total);

                            $(this).parents("tr").remove();
                        }
                    });
                    toastr.success('Los artículos fueron eliminados de la lista.', 'Eliminación');
                }
            });
        }

        function insertarProveedor() {
            if (vm.Proveedor.nCantidadTotal <= 0) return toastr.warning('Debe de agregar artículos.', 'Validación');
            if (vm.Proveedor.dFecha == '') return toastr.warning('Falta fecha.', 'Validación');
            if (vm.Proveedor.cNomProveedor == '') return toastr.warning('Falta nombre de proveedor.', 'Validación');

            bootbox.confirm("¿Desea continuar?", function (result) {
                if (result) {
                    var fecha = vm.Proveedor.dFecha.split('/');
                    var fechaYMD = fecha[2] + '-' + fecha[1] + '-' + fecha[0];
                    var ventaArray = [];

                    $('#tblProveedor tbody').find('input[name="record"]').each(function () {
                        var id = parseInt($("td", $(this).parents("tr")).eq(1).text());
                        var pcompra = ($("td", $(this).parents("tr")).eq(3).text()).replace('S/ ', '');
                        var pventa = ($("td", $(this).parents("tr")).eq(4).text()).replace('S/ ', '');
                        var cantidad = parseInt($("td", $(this).parents("tr")).eq(5).text());
                        var ptotal = ($("td", $(this).parents("tr")).eq(6).text()).replace('S/ ', '');

                        ventaArray.push({
                            dFech: fechaYMD,
                            cNomProv: vm.Proveedor.cNomProveedor,
                            idArt: id,
                            nCant: cantidad,
                            nPxC: pcompra,
                            nPxV: pventa,
                            nPTotal: ptotal,
                            cUsu: vm.Proveedor.cUser
                        });
                    });

                    dataService.postData('Server/proveedor_insertar.php', ventaArray).then(function (data) {
                        if (data.data == 'ok') {
                            toastr.success('Datos registrados correctamente!', 'Registro');
                            $state.go('portal');
                        }else{
                            toastr.error('Hubo un error al registrar. Comuníquese con el administrador de sistemas.','Error');
                        }
                    }, function (error) {
                        authenticationService.errorValida(error);
                    });
                }
            });

            toastr.success('Articulos y proveedor registrados correctamente.', 'Registro Proveedor');
        }
    }
})();