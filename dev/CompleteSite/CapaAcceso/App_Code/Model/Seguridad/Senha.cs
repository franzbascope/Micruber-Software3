using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios.Models
{
    public class Senha
    {

        public string userId { get; set; }

        public string oldPassword { get; set; }

        public string newPassword { get; set; }

    }
}