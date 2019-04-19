Instrucciones para correr el programa
-Requisitos
*Tener windows 7 o mas
*Tener instalado Adnroid studio en su ultima version.
*Tener instalado visual studio 2015 o superior
-Configurar ambiente
1.Activar IIS si es que no se tiene.
Si no se tiene seguir las instrucciones del siguiente  enlace
https://docs.microsoft.com/en-us/aspnet/web-forms/overview/deployment/visual-studio-web-deployment/deploying-to-iis

Adicional dentro de Application Development Feautes seleccionar todas las opciones asp.net 4.5
2.Abrir IIS, dentro del IIS ir a la seccion Sitios , luego a Default Web Site.
hacer click derecho en la opcion Default Web Site, agregar aplicacion.
3.Seleccionar como alias 'micruber', en el grupo de aplicaciones seleccionar '.NET 4.5',
Luego en la opcion ruta de acceso, seleccionar la carpeta servicios dentrl del proyecto.
Ejemplo :' E:\universidad\software3\Micruber-Software3\dev\CompleteSite\Servicios'
*Seleccionar solo la carpeta Servicios*
4. Para verificar si esta funcionando ir a su navegador e ingresas la ruta
localhsot/micruber ,  esto deberia mostrar el sitio web.
5.Luego verificar la IP, con el comando ipconfig en su cmd.
6.Ir al archivo
'E:\universidad\software3\Micruber-Software3\dev\Android\Micruber\app\src\main\res\values\strings.xml'
y cambiar el valor url_master por: http://{su IP}/micruber/api
7.conectar su celular a la misma red de su computadora para que funcione los servicios
8.Abriir la solucion CompleteSite.sln
en la direccion
'E:\universidad\software3\Micruber-Software3\dev\CompleteSite\CompleteSite.sln'
9.en el visual dar a la opcion correr
10.Disfruta la app, crea usuarios, inicia sesion y recupera contraseña
