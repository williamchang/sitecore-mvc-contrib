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
	protected void btnClearAllUserSession_Click(object sender, EventArgs e)
	{
		var usrSession = Session;
		usrSession.Clear();
	}
	protected void btnCreateTestDataForUserSession_Click(object sender, EventArgs e)
	{
		var usrSession = Session;
		usrSession["debug_item001"] = "The date and time created is " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
		usrSession["debug_item002"] = DateTime.Now.Ticks;
		usrSession["debug_item003"] = new List<string> {"red", "green", "blue"};
		usrSession["debug_item004"] = new Dictionary<string, string>() {
			{"cat", "meow"},
			{"dog", "bark"},
			{"pig", "oink"},
			{"cow", "moo"}
		};
	}
</script>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
<head> 
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<!--[if ie]><meta http-equiv="X-UA-Compatible" content="chrome=1"><![endif]-->
	<meta name="author" content="William Chang" />
	<title>Debug User Session</title>
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

	<h1>Debug User Session</h1>
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

	<%
	var usrSession = Session;
	var usrSessionEnumerator = usrSession.GetEnumerator();
	%>
	<dl>
		<dt>User Session Type</dt>
		<dd><%= usrSession.GetType() %></dd>
		<dt>User Session Count</dt>
		<dd><%= usrSession.Count %></dd>
	</dl>
	<p><asp:button id="btnClearAllUserSession" text="Clear All User Session" cssclass="btn_command" onclick="btnClearAllUserSession_Click" runat="server" /></p>
	<p><asp:button id="btnCreateTestDataForUserSession" text="Create Test Data For User Session" cssclass="btn_command" onclick="btnCreateTestDataForUserSession_Click" runat="server" /></p>
	<%
	if(usrSession.Count > 0) {
	%>
		<table>
		<thead>
			<tr>
				<th>Key</th>
				<th>Value</th>
				<th>Type</th>
			</tr>
		</thead>
		<tbody>
		<%
		while(usrSessionEnumerator.MoveNext()) {
		%>
			<tr>
				<td><%= System.Web.HttpUtility.HtmlEncode(usrSessionEnumerator.Current) %></td>
				<td><%= System.Web.HttpUtility.HtmlEncode(usrSession[usrSessionEnumerator.Current.ToString()]) %></td>
				<td><%= usrSession[usrSessionEnumerator.Current.ToString()].GetType() %></td>
			</tr>
		<%
		}
		%>
		</tbody>
		<table>
	<%
	}
	%>
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
