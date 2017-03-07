using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace SandboxSites.Web.Areas.Shared.Controllers {

public class GeneralController : BaseController
{
    /// <summary>Accept HTTP GET requests.</summary>
    public ActionResult Index()
    {
        return View();
    }

    /// <summary>Accept HTTP GET requests via Sitecore controller rendering.</summary>
    public string EchoString()
    {
        StringBuilder sbResponseBody = new StringBuilder();

        sbResponseBody.AppendFormat("\n<div>\n");
        sbResponseBody.AppendFormat("Sitecore Controller Rendering");
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("Sitecore Controller Rendering, Field Name : Controller, Field Value : General");
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("Sitecore Controller Rendering, Field Name : Controller Action, Field Value : EchoString");
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("Sitecore Controller Rendering, Field Name : Area, Field Value : Shared");
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("ContextItem.Paths.FullPath : {0}", Sitecore.Mvc.Presentation.RenderingContext.Current.ContextItem.Paths.FullPath);
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("PageContext.Item.Paths.FullPath : {0}", Sitecore.Mvc.Presentation.RenderingContext.Current.PageContext.Item.Paths.FullPath);
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("Rendering.Item.Paths.FullPath : {0}", Sitecore.Mvc.Presentation.RenderingContext.Current.Rendering.Item.Paths.FullPath);
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("PageContext.Item[\"ContentTitle\"] : {0}",  Sitecore.Mvc.Presentation.RenderingContext.Current.PageContext.Item["ContentTitle"]);
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("Rendering.Item[\"WidgetTitle\"] : {0}", Sitecore.Mvc.Presentation.RenderingContext.Current.Rendering.Item["WidgetTitle"]);
        sbResponseBody.AppendFormat("\n</div>\n");

        return sbResponseBody.ToString();
    }

    /// <summary>Accept HTTP GET requests via Sitecore controller rendering using a partial view.</summary>
    [AcceptVerbs(HttpVerbs.Get)]
    public PartialViewResult EchoView()
    {
        StringBuilder sbResponseBody = new StringBuilder();

        sbResponseBody.AppendFormat("\n<div>\n");
        sbResponseBody.AppendFormat("Sitecore Controller Rendering");
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("Sitecore Controller Rendering, Field Name : Controller, Field Value : General");
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("Sitecore Controller Rendering, Field Name : Controller Action, Field Value : EchoView");
        sbResponseBody.AppendFormat("\n<br />\n");
        sbResponseBody.AppendFormat("Sitecore Controller Rendering, Field Name : Area, Field Value : Shared");
        sbResponseBody.AppendFormat("\n</div>\n");

        ViewBag.Whoami = sbResponseBody.ToString();
        ViewBag.Message = "This page is using a controller and view.";

        return PartialView("EchoRendering");
    }
}

}
