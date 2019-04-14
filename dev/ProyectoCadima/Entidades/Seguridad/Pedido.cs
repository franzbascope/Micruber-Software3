using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class Pedido
    {
        public int PedidoId { get; set; }
        public int ClienteId { get; set; }
        public int EmpresaId { get; set; }
        public int UsuarioId { get; set; }
        public DateTime Fecha { get; set; }
        public bool Atendido { get; set; }
        public string Latitud { get; set; }
        public string Longitud { get; set; }
        public bool IsMovil { get; set; }

        public string T_ClienteName { get; set; }
        public string T_EmpresaName { get; set; }
        public string T_EstadoAtencion { get; set; }
        public string T_Dispositivo { get; set; }

        public decimal TotalPago { get; set; }         
        public List<DetallePedido> lstDetalle { get; set; }
        public Pedido()
        {
        }
    }
}
