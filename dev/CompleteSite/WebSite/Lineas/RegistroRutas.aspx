<%@ Page Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="RegistroRutas.aspx.cs" Inherits="Lineas_RegistroRutas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <style>
        /* Set the size of the div element that contains the map */
        #map {
            height: 500px; /* The height is 400 pixels */
            width: 100%; /* The width is the width of the web page */
        }
    </style>
    <h4 class="card-title">Ruta</h4>
    <asp:HyperLink runat="server" NavigateUrl="~/Lineas/ListaLineas.aspx">
                Volver a la Lista de Líneas
    </asp:HyperLink>
    <!--The div element for the map -->
    <div id="map"></div>
    <script>
        var map, polyline, markers = new Array();

        function enviarCoordenadas() {
            var lineaId = JSON.stringify({ 'lineaId': document.getElementById("<%= LineaIdHiddenField.ClientID %>").value });
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "RegistroRutas.aspx/deleteCoordenadas",
                data: lineaId,
                dataType: "json",
                async: false,                success: function (msg) {                    message = msg.d;                }
            });

            for (var i = 0; i < markers.length; i++) {
                var param = JSON.stringify({
                    'lineaId': document.getElementById("<%= LineaIdHiddenField.ClientID %>").value,
                    'latitud': markers[i].getPosition().lat(),
                    'longitud': markers[i].getPosition().lng()
                });
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "RegistroRutas.aspx/InsertarCoordenadas",
                    data: param,
                    dataType: "json",
                    async: false,                    success: function (msg) {                        message = msg.d;                    }
                });
            }
            window.location = "ListaLineas.aspx";
        }

        function cargarMapa() {
            var param = JSON.stringify({ 'lineaId': document.getElementById("<%= LineaIdHiddenField.ClientID %>").value });
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "RegistroRutas.aspx/mostrarCoordenadas",
                data: param,
                dataType: "json",
                async: false,                success: function (coordenadas) {                    //console.log(coordenadas.d.length);                    if (coordenadas.d.length <= 0) {                        initialize();
                    } else {                        agregarMarcadores(coordenadas.d);                    }                }
            });
        }

        function agregarMarcadores(coordenadas) {
            var mapOptions = {
                zoom: 15,
                center: new google.maps.LatLng(coordenadas[0].latitud, coordenadas[0].longitud)
            };

            map = new google.maps.Map(document.getElementById('map'),
                mapOptions);

            polyline = new google.maps.Polyline({
                strokeColor: 'red',
                strokeWeight: 1,
                map: map
            });

            google.maps.event.addListener(map, 'click', function (event) {

                addPoint(event.latLng);
            });

            for (var i = 0; i < coordenadas.length; i++) {
                var latLng = new google.maps.LatLng(coordenadas[i].latitud, coordenadas[i].longitud);
                addPoint(latLng)
            }

        }

        function initialize() {

            var mapOptions = {
                zoom: 15,
                center: new google.maps.LatLng(-17.784823, -63.180726)
            };

            map = new google.maps.Map(document.getElementById('map'),
                mapOptions);

            polyline = new google.maps.Polyline({
                strokeColor: 'red',
                strokeWeight: 1,
                map: map
            });

            google.maps.event.addListener(map, 'click', function (event) {

                addPoint(event.latLng);
            });
        }

        function removePoint(marker) {

            for (var i = 0; i < markers.length; i++) {

                if (markers[i] === marker) {

                    markers[i].setMap(null);
                    markers.splice(i, 1);

                    polyline.getPath().removeAt(i);
                }
            }
        }

        function addPoint(latlng) {

            var marker = new google.maps.Marker({
                position: latlng,
                map: map
            });

            markers.push(marker);

            polyline.getPath().setAt(markers.length - 1, latlng);

            google.maps.event.addListener(marker, 'click', function (event) {

                removePoint(marker);
            });
        }

    </script>
    <!--Load the API from the specified URL
    * The async attribute allows the browser to render the page while the API loads
    * The key parameter will contain your own API key (which is not needed for this tutorial)
    * The callback parameter executes the initMap() function
    -->
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDc8lBL2lenObLSRhhyAQ3Qw-JvWti6isU&callback=cargarMapa">
    </script>

    <button type="button" class="btn btn-dark" onclick="enviarCoordenadas()">Guardar Ruta</button>
    <asp:HiddenField ID="LineaIdHiddenField" runat="server" Value="0" />
</asp:Content>
