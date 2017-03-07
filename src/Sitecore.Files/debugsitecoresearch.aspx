<%@ page language="C#" trace="False" tracemode="SortByCategory" %>
<script runat="server" language="C#">
	protected void Page_Init(object sender, EventArgs e)
	{
	}
	protected void Page_Load(object sender, EventArgs e)
	{
	}
	protected void btnReload_Click(object sender, EventArgs e)
	{
		Response.Redirect(Request.RawUrl);
	}
	protected void btnGetSearchIndexInformation_Click(object sender, EventArgs e)
	{
		var name = txtGetSearchIndexInformationName.Text;
		var query = txtGetSearchIndexInformationQuery.Text;
		var pageOffset = Convert.ToInt32(txtGetSearchIndexInformationPageOffset.Text);
		var pageLength = Convert.ToInt32(txtGetSearchIndexInformationPageLength.Text);
		var response = String.Empty;
		if(!String.IsNullOrEmpty(name)) {
			var scIndex = Sitecore.Search.SearchManager.GetIndex(name);
			if(scIndex != null) {
				using(var scSearchContext = scIndex.CreateSearchContext()) {
					Sitecore.Search.SearchHits scHits = null;
					if(!String.IsNullOrEmpty(query)) {
						Sitecore.Search.QueryBase scQuery = null;
						if(query.StartsWith("{")) {
							scQuery = new Sitecore.Search.FieldQuery(Sitecore.Search.BuiltinFields.ID, Sitecore.Data.ShortID.Encode(query).ToLowerInvariant());
						} else {
							scQuery = new Sitecore.Search.FullTextQuery(query);
						}
						scHits = scSearchContext.Search(scQuery);
					} else {
						scHits = scSearchContext.Search(new Lucene.Net.Search.MatchAllDocsQuery());
					}
					if(scHits != null && scHits.Length > 0) {
						var objs = scHits.FetchResults(pageOffset, pageLength).Select(r => r.GetObject<Sitecore.Data.Items.Item>());
						gvGetSearchIndexInformation.DataSource = objs.Select(x => new {
							ItemPath = x.Paths.FullPath,
							ItemId = x.ID.ToString(),
							ItemName = x.Name,
							TemplateId = x.TemplateID.ToString(),
							TemplateName = x.TemplateName
						});
						response = String.Format("<div class=\"response\">Request done. Found {0} documents.</div>", scHits.Length);
					} else {
						gvGetSearchIndexInformation.DataSource = null;
						response = String.Format("<div class=\"response\">Request done. Found 0 documents.</div>");
					}
					gvGetSearchIndexInformation.DataBind();
				}
			} else {
				response = String.Format("<div class=\"response\">Request done. Search index name is not found.</div>");
			}
		} else {
			response = String.Format("<div class=\"response\">Nothing happen. Please try again.</div>");
		}
		litGetSearchIndexInformationResponse.Text = response;
	}
	protected void btnRebuildSearchIndexSitecoreDatabase_Click(object sender, EventArgs e)
	{
		var name = txtRebuildSearchIndexSitecoreDatabaseName.Text;
		var response = String.Empty;
		if(!String.IsNullOrEmpty(name)) {
			var scDatabase = Sitecore.Configuration.Factory.GetDatabase(name);
			if(scDatabase != null) {
				for(int i = 0;i < scDatabase.Indexes.Count;i += 1) {
					scDatabase.Indexes[i].Rebuild(scDatabase); 
				}
				response = String.Format("<div class=\"response\">Request done.</div>");
			}
		} else {
			response = String.Format("<div class=\"response\">Nothing happen. Please try again.</div>");
		}
		litRebuildSearchIndexSitecoreDatabaseResponse.Text = response;
	}
	protected void btnRebuildSearchIndex_Click(object sender, EventArgs e)
	{
		var name = txtRebuildSearchIndexName.Text;
		var response = String.Empty;
		if(!String.IsNullOrEmpty(name)) {
			Sitecore.Search.SearchManager.GetIndex(name).Rebuild();
			response = String.Format("<div class=\"response\">Request done.</div>");
		} else {
			response = String.Format("<div class=\"response\">Nothing happen. Please try again.</div>");
		}
		litRebuildSearchIndexResponse.Text = response;
	}
</script>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
<head> 
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<!--[if ie]><meta http-equiv="X-UA-Compatible" content="chrome=1"><![endif]-->
	<meta name="author" content="William Chang" />
	<title>Debug Sitecore Search</title>
	<!-- BEGIN: Styles -->
	<style type="text/css" media="all">
		dl {}
		dl dt {font-weight:bold;}
		dl dd {}
		table {border-collapse:collapse;}
		table table {margin:0 0 20px 20px;}
		th, td {padding:4px;border:solid 1px #000;text-align:left;}
		div.response {margin:10px 0 10px 0;font-weight:bold;}
	</style>
	<!-- END: Styles -->
</head>
<body>
<form id="form1" runat="server">
<div id="frame">

	<h1>Debug Sitecore Search</h1>
	<p>The current date and time is <%= DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") %></p>
	<p><asp:button id="btnReload" text="Reload" cssclass="btn_command" onclick="btnReload_Click" runat="server" /></p>

	<dl>
		<dt>Instance Name</dt>
		<dd><%= String.Format("{0}-{1}", System.Environment.MachineName, System.Web.Hosting.HostingEnvironment.SiteName) %></dd>
		<dt>Server Host Name</dt>
		<dd><%= System.Net.Dns.GetHostName() %></dd>
		<dt>Server IP Address</dt>
		<dd><%= System.Array.FindLast(System.Net.Dns.GetHostEntry(System.Net.Dns.GetHostName()).AddressList, x => x.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork) %></dd>
		<dt>Client IP Address</dt>
		<dd><%= String.IsNullOrEmpty(System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]) ? System.Web.HttpContext.Current.Request.UserHostAddress : System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] %></dd>
		<dt>Process Identity</dt>
		<dd><%= System.Diagnostics.Process.GetCurrentProcess().Id %></dd>
		<dt>Process Name</dt>
		<dd><%= System.Diagnostics.Process.GetCurrentProcess().ProcessName %></dd>
		<dt>Microsoft .NET Version</dt>
		<dd><%= System.Runtime.InteropServices.RuntimeEnvironment.GetSystemVersion() %></dd>
	</dl>

	<h3>Get Search Index Information</h3>
	<div>
		<div><asp:label id="lblGetSearchIndexInformation" associatedcontrolid="txtGetSearchIndexInformationName">Search Index Name</asp:label></div>
		<div><asp:textbox id="txtGetSearchIndexInformationName" width="512px" runat="server" /></div>
		<div><asp:label id="lblGetSearchIndexInformationQuery" associatedcontrolid="txtGetSearchIndexInformationQuery">Query Item Id (Optional)</asp:label></div>
		<div><asp:textbox id="txtGetSearchIndexInformationQuery" width="512px" runat="server" /></div>
		<div><asp:label id="lblGetSearchIndexInformationPageOffset" associatedcontrolid="txtGetSearchIndexInformationPageOffset">Page Offset</asp:label></div>
		<div><asp:textbox id="txtGetSearchIndexInformationPageOffset" text="0" width="64px" runat="server" /></div>
		<div><asp:label id="lblGetSearchIndexInformationPageLength" associatedcontrolid="txtGetSearchIndexInformationPageLength">Page Length</asp:label></div>
		<div><asp:textbox id="txtGetSearchIndexInformationPageLength" text="10" width="64px" runat="server" /></div>
		<div><asp:button id="btnGetSearchIndexInformation" text="Get" cssclass="btn_command" onclick="btnGetSearchIndexInformation_Click" runat="server" /></div>
		<asp:literal id="litGetSearchIndexInformationResponse" runat="server" />
		<asp:gridview id="gvGetSearchIndexInformation" runat="server" />
	</div>

	<h3>Rebuild Search Index By Name</h3>
	<div>
		<div><asp:label id="lblRebuildSearchIndex" associatedcontrolid="txtRebuildSearchIndexName">Search Index Name</asp:label></div>
		<div><asp:textbox id="txtRebuildSearchIndexName" width="512px" runat="server" /></div>
		<div><asp:button id="btnRebuildSearchIndex" text="Rebuild" cssclass="btn_command" onclick="btnRebuildSearchIndex_Click" runat="server" /></div>
		<asp:literal id="litRebuildSearchIndexResponse" runat="server" />
	</div>

	<h3>Rebuild Search Index By Sitecore Database</h3>
	<div>
		<div><asp:label id="lblRebuildSearchIndexSitecoreDatabase" associatedcontrolid="txtRebuildSearchIndexSitecoreDatabaseName">Sitecore Database Name</asp:label></div>
		<div><asp:textbox id="txtRebuildSearchIndexSitecoreDatabaseName" width="512px" runat="server" /></div>
		<div><asp:button id="btnRebuildSearchIndexSitecoreDatabase" text="Rebuild" cssclass="btn_command" onclick="btnRebuildSearchIndexSitecoreDatabase_Click" runat="server" /></div>
		<asp:literal id="litRebuildSearchIndexSitecoreDatabaseResponse" runat="server" />
	</div>
</div>
</form>
<!-- BEGIN: Scripts -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	//<![CDATA[
// Register ready event to be executed when the DOM document has finished loading.
jQuery(document).ready(function($) {
	// Do something.
});
	//]]>
	</script>
<!-- END: Scripts -->
</body>
</html>
