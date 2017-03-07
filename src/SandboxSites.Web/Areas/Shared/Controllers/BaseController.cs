using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SandboxSites.Web.Areas.Shared.Controllers {

/// <summary>Base controller (abstract) for all controllers.</summary>
public abstract class BaseController : Controller
{
    public static readonly string ObjectOwner = "SandboxSites";
    public static readonly string ObjectTypeName = "BaseController";
    public static readonly string ObjectTypeNamespace = "SandboxSites.Web.Areas.Shared.Controllers";
    public static readonly string ObjectTypeFullName = String.Concat(ObjectTypeNamespace, ".", ObjectTypeName);

    /// <summary>Default constructor.</summary>
    public BaseController() : base()
    {
        System.Diagnostics.Debug.WriteLine(String.Format("{0} : Constructor Started", ObjectTypeFullName));
        // Do something.
        System.Diagnostics.Debug.WriteLine(String.Format("{0} : Constructor Ended", ObjectTypeFullName));
    }

    /// <summary>Get database connection string.</summary>
    [NonAction]
    public string GetDatabaseString()
    {
        var dbConnectionStringSettings = System.Configuration.ConfigurationManager.ConnectionStrings["Default"];
        if(dbConnectionStringSettings != null && !String.IsNullOrEmpty(dbConnectionStringSettings.ConnectionString)) {
            return dbConnectionStringSettings.ConnectionString;
        } else {
            throw new Exception("Missing connecting string in Web.config file.");
        }
    }

#region Utilities

    [NonAction]
    public static string GetSafeValue(string value, string defaultValue)
    {
        if(!String.IsNullOrEmpty(value)) {
            return value;
        } else {
            return defaultValue;
        }
    }

    [NonAction]
    public static string GetSafeValue(string value, string anotherValue, string defaultValue)
    {
        if(!String.IsNullOrEmpty(value)) {
            return value;
        } else if(!String.IsNullOrEmpty(anotherValue)) {
            return anotherValue;
        } else {
            return defaultValue;
        }
    }

    [NonAction]
    public static string GetSetting(string settingName, string defaultValue)
    {
        return GetSafeValue(System.Configuration.ConfigurationManager.AppSettings.Get(settingName), defaultValue);
    }

#endregion

}

}
