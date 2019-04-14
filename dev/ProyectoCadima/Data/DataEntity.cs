using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data
{
    public abstract class DataEntity : IDisposable
    {
        protected long GenID(string strTableName)
        {
            long lngGenId = 0;

            Conexion conexion = new Conexion();
            MySqlDataAdapter adapter = new MySqlDataAdapter();
            String sql;
            try
            {
                sql = " SELECT max(Id) FROM  " + strTableName;
                MySqlCommand commando = new MySqlCommand();
                commando.Connection = conexion.conexion;
                commando.CommandText = sql;
                adapter.SelectCommand = commando;
                MySqlDataReader dato = commando.ExecuteReader();            

                if (dato.Read())
                {
                    lngGenId = dato.GetInt64(0);
                }
                else
                {
                    return lngGenId;
                }


                dato.Close();
               // conexion.dispose();
                return lngGenId;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex.InnerException);
            }
        }
            
        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}
