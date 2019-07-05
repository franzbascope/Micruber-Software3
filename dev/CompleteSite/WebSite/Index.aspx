<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
        }

        #cantidad_gente_mes {
            width: 100%;
            height: 500px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="card">
        <div id="cantidad_gente_mes" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>
    </div>
    <div class="card">
        <div id="ganancias_ultimo_mes" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>
    </div>
    <asp:HiddenField ID="lineaRep" ClientIDMode="Static" runat="server" Value="" />
    <asp:HiddenField ID="fechaMes" ClientIDMode="Static" runat="server" Value="" />

    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script>
        (function () {

            var lineas = JSON.parse(document.getElementById("lineaRep").value)

            var name = Array();
            var nro = Array();
            var dataArrayFinal = Array();
            for (i = 0; i < lineas.length; i++) {
                name[i] = lineas[i].numeroLinea;
                nro[i] = lineas[i].nroVeces;
            }

            for (j = 0; j < name.length; j++) {
                var temp = new Array(name[j], nro[j]);
                dataArrayFinal[j] = temp;
            }


            Highcharts.chart('cantidad_gente_mes', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: 0,
                    plotShadow: false
                },
                title: {
                    text: 'Lineas<br>mas usadas<br>del ultimo mes',
                    align: 'center',
                    verticalAlign: 'middle',
                    y: 40
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: true,
                            distance: -50,
                            style: {
                                fontWeight: 'bold',
                                color: 'white'
                            }
                        },
                        startAngle: -90,
                        endAngle: 90,
                        center: ['50%', '75%'],
                        size: '110%'
                    }
                },
                series: [{
                    type: 'pie',
                    name: 'Browser share',
                    innerSize: '50%',
                    data: dataArrayFinal
                }]
            });

        })()
    </script>
    <script>

     
            var todo = JSON.parse(document.getElementById("fechaMes").value)

            var fecha = Array();
            var dia = Array();
            var mes = Array();
            var anho = Array();

            var plata = Array();
            var dataArrayFinal = Array();
            for (i = 0; i < todo.length; i++) {
                debugger

                fecha[i] = todo[i].fecha;
                plata[i] = todo[i].ingreso;
                var getdia = fecha[i];

                dia[i] = parseInt(getdia.substring(0, 2));
                mes[i] = getdia.substring(3, 5);
                anho[i] = getdia.substring(6, 10);


            }

            for (j = 0; j < fecha.length; j++) {
                var temp = new Array(fecha[j], plata[j]);
                debugger
                dataArrayFinal[j] = temp;
            }
            Highcharts.chart('ganancias_ultimo_mes', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: 'Ganancias totales'
                },
                subtitle: {
                    text: 'Source: WorldClimate.com'
                },
                xAxis: {
                    categories: fecha
                },
                yAxis: {
                    title: {
                        text: ""
                    }
                },
                plotOptions: {
                    line: {
                        dataLabels: {
                            enabled: true
                        },
                        enableMouseTracking: false
                    }
                },
                series: [{
                    name: 'Plata',
                    data: plata
                    }]
                });

    </script>
</asp:Content>

