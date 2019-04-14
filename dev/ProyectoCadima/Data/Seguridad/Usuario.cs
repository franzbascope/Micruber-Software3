using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ENTSEG = Entidades.Seguridad;
using ENT = Entidades;
using Data;
using MySql.Data.MySqlClient;

namespace Data.Seguridad
{
    public class Usuario : DataEntity
    {
        public Usuario()
        {

        }
        public void Save(ENTSEG.User BEObj)
        {
            string strQuery = "";

            if (BEObj.statusType == ENT.Accion.Insert)
                strQuery = " INSERT INTO tblusuarios(Id,nombre,telefono,email) " +
                           " VALUES( @Id,@nombre,@telefono,@email) ";
            else if (BEObj.statusType == ENT.Accion.Update)
                strQuery = "UPDATE tblusuarios SET " +
                        " TypeIdc = @TypeIdc,CompanyId = @CompanyId,Code = @Code,Name = @Name,Email = @Email,Login = @Login,PasswordSalt = @PasswordSalt,Password = @Password,Phone = @Phone,Active = @Active  " +
                        " WHERE Id = @Id ";
            else if (BEObj.statusType == ENT.Accion.Delete)
                strQuery = "DELETE FROM tblusuarios WHERE Id = @Id";

            try
            {
                Conexion conexion = new Conexion();
                MySqlDataAdapter adapter = new MySqlDataAdapter();
                MySqlCommand commando = new MySqlCommand();
                MySqlDataReader dato;
                if (BEObj.statusType == ENT.Accion.Insert)
                    BEObj.UsuarioId = (int)base.GenID("tblusuario");

                if (BEObj.statusType != ENT.Accion.NoAction)
                {
                    
                    String finalQuery = String.Format(strQuery, BEObj.UsuarioId, BEObj.Nombre);

                    commando.Connection = conexion.conexion;
                    commando.CommandText = finalQuery;
                    adapter.SelectCommand = commando;          
                    dato = commando.ExecuteReader();
                    dato.Dispose();
                    dato.Close();
                }
            }
            catch (Exception ex)
            {
                
                throw new Exception(ex.Message, ex.InnerException);
            }
            
        }
    }
}
