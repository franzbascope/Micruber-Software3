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
    <asp:HiddenField ID="lineaRep" ClientIDMode="Static" runat="server" Value="" />
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
</asp:Content>

