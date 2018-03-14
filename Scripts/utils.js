// ┌────────────────────────────────────────────────────────────────────┐ \\
// │ Soy Lucas v1.0                                                     │ \\
// ├────────────────────────────────────────────────────────────────────┤ \\
// │ Copyright © 2017 Hugo Roca - Tibox (hugo.roca@tibox.com.pe)        │ \\
// ├────────────────────────────────────────────────────────────────────┤ \\
// └────────────────────────────────────────────────────────────────────┘ \\
var URL = {
    BASE: 'http://localhost:81/',
    INICIO: 'http://localhost:81/Inicio'
}

$(document).ready(function () {
    $('*').bind("cut copy paste", function (e) {
        e.preventDefault();
    });
});

function pintaConsola() {

    //console.API;

    //if (typeof console._commandLineAPI !== 'undefined') {
    //    console.API = console._commandLineAPI; //chrome
    //} else if (typeof console._inspectorCommandLineAPI !== 'undefined') {
    //    console.API = console._inspectorCommandLineAPI; //Safari
    //} else if (typeof console.clear !== 'undefined') {
    //    console.API = console;
    //}

    //console.API.clear();

    /*var codeStyle = 'background: #454544; font-size: 14px; font-weight: bold;font-family: Courier; color: #FFB700;  border-radius: 4px; padding: 5px 5px;';

    log('[c="font-family: Courier; color: #FFB700; font-size: 70px; padding: 5px 5px; background: #454544; border-radius: 4px; line-height: 100px; font-weight: Bold;text-shadow: 0 1px #000"]¡Alto![c]');
    log.l('%cEsta funcion está pensada solo para desarrolladores, si alguien te indicó que', codeStyle);
    log.l('%ccopiaras y pegaras algo aquí para habilitar una funcion o para "hackear" la  ', codeStyle);
    log.l('%ccuenta de alguien, se trata de un fraude. Si lo haces esta persona podrá     ', codeStyle);
    log.l('%cacceder a tu cuenta.                                                         ', codeStyle);*/
}


function SoloLetrasInputs(e) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = " áéíóúabcdefghijklmnñopqrstuvwxyz";
    especiales = [8, 37, 39, 46];

    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
}

function LimpiaInputsSoloLetras() {
    var val = document.getElementById("miInput").value;
    var tam = val.length;
    for (i = 0; i < tam; i++) {
        if (!isNaN(val[i]))
            document.getElementById("miInput").value = '';
    }
}

function SoloNumerosInputs(e) {
    var key = window.Event ? e.which : e.keyCode
    return ((key >= 48 && key <= 57) || (key == 8))
}

var formatNumber = {
    separador: ",",
    sepDecimal: '.',
    formatear: function (num) {
        num += '';
        var splitStr = num.split('.');
        var splitLeft = splitStr[0];
        var splitRight = splitStr.length > 1 ? this.sepDecimal + splitStr[1] : '';
        var regx = /(\d+)(\d{3})/;
        while (regx.test(splitLeft)) {
            splitLeft = splitLeft.replace(regx, '$1' + this.separador + '$2');
        }

        var res = splitLeft + splitRight;
        var splitPrueba = res.split(".");
        if (splitPrueba.length < 2) res = splitLeft + splitRight + ".00"
        return res;

    },
    new: function (num, simbol) {
        this.simbol = simbol || '';
        return this.formatear(num);
    }
}

function formatoMiles(valor) {
    return formatNumber.new(valor);
}

function getDateFormat(fechaTime) {
    if (fechaTime == "0001-01-01T00:00:00") {
        return null;
    } else {
        var date = new Date(fechaTime);
        var Year = date.getFullYear();
        var Month = (1 + date.getMonth()).toString();
        Month = Month.length > 1 ? Month : '0' + Month;
        var Day = date.getDate().toString();
        Day = Day.length > 1 ? Day : '0' + Day;

        return Day + "/" + Month + "/" + Year;
    }
}

function getdate1(fecha) {
    var data = fecha;
    var Day = data.substring(0, 2);
    var Month = data.substring(3, 5);
    var Year = data.substring(6, 10);
    return Year + "/" + Month + "/" + Day;
}

function YYYYMMDDConvert(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}

function DiferenciaDias2(fechaDesembolso, dFechaCalen) {
    var date1 = new Date(fechaDesembolso);
    var date2 = new Date(dFechaCalen);

    var timeDiff = Math.abs(date1.getTime() - date2.getTime());
    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
    return diffDays;
}

function DiferenciaDias(fechaDesembolso, dFechaCalen) {
    var date1 = new Date(fechaDesembolso);
    var date2 = new Date(dFechaCalen);
    var timeDiff = Math.abs(date1.getTime() - date2.getTime());
    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
    return diffDays;
}

function codigoAleatorio() {
    var inferior = 1000;
    var superior = 9999;
    var numPosibilidades = 9999 - 1000
    var aleat = Math.random() * numPosibilidades
    aleat = Math.round(aleat)
    console.log(parseInt(inferior) + aleat);
    return parseInt(inferior) + aleat
}

function createObjectURL(file) {
    if (window.webkitURL) {
        return window.webkitURL.createObjectURL(file);
    } else if (window.URL && window.URL.createObjectURL) {
        return window.URL.createObjectURL(file);
    } else {
        return null;
    }
}

function abrirArchivoPDF(b64Data, nombreArchivo) {
    try {
        var contentType = 'application/pdf'; //contentType || '';
        var sliceSize = sliceSize || 512;

        var byteCharacters = atob(b64Data);
        var byteArrays = [];

        for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
            var slice = byteCharacters.slice(offset, offset + sliceSize);

            var byteNumbers = new Array(slice.length);
            for (var i = 0; i < slice.length; i++) {
                byteNumbers[i] = slice.charCodeAt(i);
            }

            var byteArray = new Uint8Array(byteNumbers);

            byteArrays.push(byteArray);
        }

        var blob = new Blob(byteArrays, {
            type: contentType
        });

        download(blob, nombreArchivo, 'application/pdf');

        //var blobUrl = createObjectURL(blob);

        //window.open = blobUrl;
        //location.href = blobUrl;
        //window.open("data:application/pdf;base64," + b64Data);


    } catch (err) {
        console.log(err.message);
    }
}

function validarContraseña(pass) {
    var espacios = false;
    var cont = 0;
    while (!espacios && (cont < pass.length)) {
        if (pass.charAt(cont) == " ")
            espacios = true;
        cont++;
    }
    return espacios;
}

function validaFechaNacimiento(Fecha) {
    var values = Fecha.split("/");
    var dia = values[0];
    var mes = values[1];
    var ano = values[2];

    var fecha_hoy = new Date();
    var ahora_ano = fecha_hoy.getYear();
    var ahora_mes = fecha_hoy.getMonth() + 1;
    var ahora_dia = fecha_hoy.getDate();

    var edad = (ahora_ano + 1900) - ano;
    if (ahora_mes < mes) {
        edad--;
    }
    if ((mes == ahora_mes) && (ahora_dia < dia)) {
        edad--;
    }
    if (edad > 1900) {
        edad -= 1900;
    }

    if (edad > 18) {
        return true;
    } else {
        return false;
    }
}

function validarRUC(texto) {

}

function emailCuerpo(titulo, nombre, resumen, descripcion1, texto1, texto2, descripcion2) {
    var body = '<table border="0" style="width: 100%; background: #f1f1f1; font-family: verdana">' +
        '<tr>' +
        '<td>' +
        '<table cellspacing="0" cellpadding="0" border="0" style="margin: 0 auto; width: 85%">' +
        '<tr style="background: #FD293F">' +
        '<td colspan="3" style="padding: 30px">' +
        '<h1 style="text-transform: uppercase; text-align: center; color: white; margin: 0 auto; font-family: verdana">' + titulo + '</h1>' +
        '</td>' +
        '</tr>' +
        '<tr style="background: white">' +
        '<td colspan="3" style="padding: 15px;">' +
        '<h2 style="background: white; text-transform: uppercase; text-align: center; font-family: verdana">hola ' + nombre + '</h2>' +
        '<h4 style="font-weight: 500; text-transform: uppercase; text-align: center; font-family: verdana"><i>' + resumen + '</i></h4>' +
        '<p style="text-align: justify; padding: 15px; font-family: verdana">' + descripcion1 + '</p>';
    if (texto1 != '' || texto2 != '') {
        body = body + '<ul>';
        if (texto1 != '') {
            body = body + '<li><b>' + texto1 + '</b></li>';
        }
        if (texto2 != '') {
            body = body + '<li><b>' + texto2 + '</b></li>';
        }
        body = body + '<ul>';
    }

    if (descripcion2 != '') {
        body = body + '<p>' + descripcion2 + '</p>';
    }
    body = body + '</td>' +
        '</tr>' +
        '<tr style="background: #454544; text-transform: uppercase; text-align: center">' +
        '<td style="padding: 25px">' +
        '<button style="text-align: center; color: #fff; font-size: 14px; font-weight: 500;  border:none; padding: 10px 20px; background-color: #FFB700; font-size: 25px">' +
        '<span style="color: #454544; text-transform: uppercase; font-weight: bold; font-size: 25px">Al&oacute; Lucas:</span> 01 615-7030</button>' +
        '</td>' +
        '</tr>' +
        '</table>' +
        '</td>' +
        '</tr>' +
        '</table>';
    return body;
}

function valoresReglaNegocio(ListaReglas) {
    var valores = [];
    var xml = '';
    var idRule = 0;
    console.log(ListaReglas);
    debugger;
    if (ListaReglas != null) {
        for (var i = 0; i < ListaReglas.length; i++) {
            var rules = ListaReglas[i];
            idRule = rules.nIdNeg;
            xml = '<GENESYS>';

            for (var j = 0; j < ListaReglas.length; j++) {
                if (idRule == ListaReglas[j].nIdNeg) {
                    var data = document.getElementById(ListaReglas[j].cNomCom).value;
                    xml = xml + '<DATA parametro="' + ListaReglas[j].cNombrePar + '" valor="' + data + '"></DATA>';
                }
            }


            xml = xml + '</GENESYS>';
            valores.push(rules.cStored + '|' + xml + '|' + idRule);
        }
    }

    return valores;

}

/*Modal carga*/
var progress;
var $bar = $('.bar');

function modalCargaLlamar(texto) {
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
    document.getElementById('modalCargandoTexto').innerHTML = texto;
    $bar.css('width', '1%')
    $bar.text('1%');
    $('#modalCarga').modal({
        backdrop: 'static',
        keyboard: false
    });
}

$('#modalCarga').on('shown.bs.modal', function () {
    var i = 0;
    $bar.css('width', '1%')
    $bar.text('1%');
    progress = setInterval(function () {
        if (i == 100) {
            clearInterval(progress);
            $('.progress').removeClass('active');
            $('#modalCarga').modal('hide');
        } else {
            i = i + 1;
            $bar.css('width', i + '%')
        }
        $bar.text(i + "%");
    }, 1000);

});

function modalCargaCerrar() {
    clearInterval(progress);
    $bar.css('width', '100%')
    $bar.text('100%');
    $('.progress').removeClass('active');
    $('#modalCarga').modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
}
/*Modal carga*/

function ocultarModal(val) {
    $('#' + val).modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
}

function validaFechaExiste(fecha) {
    var fechaf = fecha.split("/");
    var d = fechaf[0];
    var m = fechaf[1];
    var y = fechaf[2];
    return m > 0 && m < 13 && y > 0 && y < 32768 && d > 0 && d <= (new Date(y, m, 0)).getDate();
}

function calcularTCEA(calendario) {
    var irr = 0.1;
    var pvPrev = hallapvPRev(calendario);
    var pv = hallaPV(irr, 360, calendario);
    var t = 0;
    var irrPrev = 0;

    while (Math.abs(pv) >= 0.0001) {
        t = irrPrev;
        irrPrev = irr;
        irr = irr + (t - irr) * pv / (pv - pvPrev);
        pvPrev = pv;
        pv = hallaPV(irr, 365, calendario);
    }

    return (irr * 100.00);
}

function hallaRestaFecha(fecha, fechaPrincipal) {
    var date1 = new Date(fecha).getTime();
    var date2 = new Date(fechaPrincipal).getTime();
    var dif = date1 - date2;
    return (dif / (1000 * 60 * 60 * 24));
}

function hallaPV(irr, dias, calendario) {
    var suma = 0;
    var amt = 0;
    var exponente = 0;
    var base = 0;
    var potencia = 0;

    for (var i = 0; i < calendario.length; i++) {
        amt = calendario[i].monto;
        base = parseFloat(1.00 + irr);
        exponente = parseFloat(hallaRestaFecha(calendario[i].fecha, calendario[0].fecha) / dias);
        potencia = Math.pow(base, exponente);
        suma = suma + parseFloat(amt / potencia);
    }

    return suma;
}

function hallapvPRev(calendario) {
    var suma = 0;
    var amt = 0;
    for (var index = 0; index < calendario.length; index++) {
        amt = calendario[index].monto;
        suma = suma + amt;
    }
    return suma;
}

function ponerADecimales(val, decimal) {
    var valor = val.toFixed(parseInt(decimal + 1));
    var valorsplit = valor.split('.');
    var dec = valorsplit[1].substring(0, decimal);
    return valorsplit[0] + '.' + dec;
}

function TextoCombo(val) {
    var combo = document.getElementById(val);
    var selected = combo.options[combo.selectedIndex].text;
    return selected;
}

function PasarFechaGuionesMySql(val) {
    var fecha = val.split('/');
    return fecha[2] + '-' + fecha[1] + '-' + fecha[0];
}

function PasarFechaBarraMySql(val) {
    var fecha = val.split('-');
    return fecha[2] + '/' + fecha[1] + '/' + fecha[0];
}