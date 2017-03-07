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
</script>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
<head> 
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<!--[if ie]><meta http-equiv="X-UA-Compatible" content="chrome=1"><![endif]-->
	<meta name="author" content="William Chang" />
	<title>Debug Index</title>
	<!-- BEGIN: Styles -->
	<style type="text/css" media="all">
		dl {}
		dl dt {font-weight:bold;}
		dl dd {}
		table {border-collapse:collapse;}
		table table {margin:0 0 20px 20px;}
		th, td {padding:4px;border:solid 1px #000;text-align:left;}
	</style>
	<!-- END: Styles -->
</head>
<body>
<form id="form1" runat="server">
<div id="frame">

	<h1>Debug Index</h1>
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

	<h3>Menu</h3>
	<dl>
		<dt><a href="debugserver.aspx">Debug Server</a></dt>
		<dd></dd>
		<dt><a href="debugcache.aspx">Debug Cache</a></dt>
		<dd></dd>
		<dt><a href="debugsession.aspx">Debug Session</a></dt>
		<dd></dd>
		<dt><a href="debugbrowserdefinition.aspx">Debug Browser Definition</a></dt>
		<dd></dd>
		<dt><a href="debugsitecoresearch.aspx">Debug Sitecore Search</a></dt>
		<dd></dd>
	</dl>
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
