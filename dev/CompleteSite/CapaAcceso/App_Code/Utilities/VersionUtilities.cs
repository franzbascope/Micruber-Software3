using System;
using System.Configuration;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace App.Utilities
{
    /// <summary>
    /// Summary description for VersionUtilities
    /// </summary>
    public class VersionUtilities
    {
        public VersionUtilities()
        {
            
        }

        private static Version GetAppVersion()
        {
            int versionMayor = -1;
            int versionMenor = -1;
            int patch = -1;
            try
            {
                versionMayor = string.IsNullOrEmpty(ConfigurationSettings.AppSettings["VersionMayor"]) ?
                    -1 : Convert.ToInt32(ConfigurationSettings.AppSettings["VersionMayor"]);
                versionMenor = string.IsNullOrEmpty(ConfigurationSettings.AppSettings["VersionMenor"]) ?
                    -1 : Convert.ToInt32(ConfigurationSettings.AppSettings["VersionMenor"]);
                patch = string.IsNullOrEmpty(ConfigurationSettings.AppSettings["Patch"]) ? 
                    -1 : Convert.ToInt32(ConfigurationSettings.AppSettings["Patch"]);
            }
            catch (Exception ex)
            {
                
            }

            if(versionMayor < 0 || versionMenor < 0 || patch < 0)
            {
                return null;
            }
            return new Version()
            {
                VersionMayor = versionMayor,
                VersionMenor = versionMenor,
                Patch = patch
            };
        }

        public static bool AppIsValidVersion()
        {
            Version dbVersion = null;
            Version appVersion = null;
            try
            {
                dbVersion = VersionBLL.GetDataBaseVersion();
                appVersion = VersionUtilities.GetAppVersion();
            }
            catch (Exception ex)
            {
                
            }

            if (dbVersion == null || appVersion == null)
                throw new Exception("El sistema no está correctamente configurado");

            return dbVersion.VersionMayor == appVersion.VersionMayor &&
                dbVersion.VersionMenor == appVersion.VersionMenor;
        }
    }
}