using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class ConfigDash
    {
        public int ConfigDashId { get; set; }
        public int DashId { get; set; }
        public int UserId { get; set; }
        public int ProductoId { get; set; }
        public int EmpresaId { get; set; }
        public decimal Cantidad { get; set; }
        public DateTime Fecha { get; set; }
        public string Latitud { get; set; }
        public string Longitud { get; set; }
        public ConfigDash() { }
    }
}
