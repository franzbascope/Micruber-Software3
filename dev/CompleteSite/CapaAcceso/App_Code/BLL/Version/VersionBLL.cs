using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAL.Version.VersionDSTableAdapters;

/// <summary>
/// Summary description for VersionBRL
/// </summary>
public class VersionBLL
{
    public VersionBLL()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static Version GetDataBaseVersion()
    {
        VersionDataTableAdapter adapter =
            new VersionDataTableAdapter();

        int? versionMayor = null;
        int? versionMenor = null;
        int? patch = null;

        adapter.GetVersionData(ref versionMayor, ref versionMenor, ref patch);

        if (versionMenor == null || versionMayor == null || patch == null)
        {
            return null; 
        }

        return new Version()
        {
            VersionMayor = versionMayor.Value,
            VersionMenor = versionMenor.Value,
            Patch = patch.Value
        };

    }
}