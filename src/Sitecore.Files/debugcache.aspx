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
	protected void btnClearAllApplicationCache_Click(object sender, EventArgs e)
	{
		var appCache = HttpRuntime.Cache;
		var appCacheEnumerator = appCache.GetEnumerator();
		while(appCacheEnumerator.MoveNext()) {
			appCache.Remove(appCacheEnumerator.Key.ToString());
		}
	}
	protected void btnCreateTestDataForApplicationCache_Click(object sender, EventArgs e)
	{
		var appCache = HttpRuntime.Cache;
		appCache["debug_item001"] = "The date and time created is " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
		appCache["debug_item002"] = DateTime.Now.Ticks;
		appCache["debug_item003"] = new List<string> {"red", "green", "blue"};
		appCache["debug_item004"] = new Dictionary<string, string>() {
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
	<title>Debug Application Cache</title>
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

	<h1>Debug Application Cache</h1>
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
	var appCache = HttpRuntime.Cache;
	var appCacheEnumerator = appCache.GetEnumerator();
	%>
	<dl>
		<dt>Application Cache Type</dt>
		<dd><%= appCache.GetType() %></dd>
		<dt>Application Cache Count</dt>
		<dd><%= appCache.Count %></dd>
	</dl>
	<p><asp:button id="btnClearAllApplicationCache" text="Clear All Application Cache" cssclass="btn_command" onclick="btnClearAllApplicationCache_Click" runat="server" /></p>
	<p><asp:button id="btnCreateTestDataForApplicationCache" text="Create Test Data For Application Cache" cssclass="btn_command" onclick="btnCreateTestDataForApplicationCache_Click" runat="server" /></p>
	<%
	if(appCache.Count > 0) {
	%>
		<table>
		<thead>
			<tr>
				<th>Key</th>
				<th>Value</th>
				<th>Type</th>
				<th>IsICollection</th>
				<th>IsIEnumerable</th>
			</tr>
		</thead>
		<tbody>
		<%
		while(appCacheEnumerator.MoveNext()) {
		%>
			<%
			var itemKey = appCacheEnumerator.Key;
			var itemValue = appCacheEnumerator.Value;
			var isICollection = itemValue.GetType().GetInterfaces().Any(x => x.IsGenericType && x.GetGenericTypeDefinition() == typeof(ICollection<>));
			var isIEnumerable = itemValue.GetType().GetInterfaces().Any(x => x.IsGenericType && x.GetGenericTypeDefinition() == typeof(IEnumerable<>));
			%>
			<tr>
				<td><%= System.Web.HttpUtility.HtmlEncode(itemKey) %></td>
				<td><%= System.Web.HttpUtility.HtmlEncode(itemValue) %></td>
				<td><%= itemValue.GetType() %></td>
				<td><%= isICollection %></td>
				<td><%= isIEnumerable %></td>
			</tr>

			<%
			if(isIEnumerable == true && !(appCacheEnumerator.Value is String)) {
			%>
			<tr><td colspan="5">
				<table>
				<thead>
					<tr>
						<th>Properties</th>
						<th>ToString</th>
						<th>Type</th>
					</tr>
				</thead>
				<tbody>
				<%
				foreach(var subItem in (IEnumerable)appCacheEnumerator.Value) {
				%>
					<%
					var sb1 = new System.Text.StringBuilder();

					var subItemPropertyInfo1 = subItem.GetType().GetProperty("Key");
					var subItemPropertyInfo2 = subItem.GetType().GetProperty("Value");
					var subItemPropertyInfo3 = subItem.GetType().GetProperty("ID");
					var subItemPropertyInfo4 = subItem.GetType().GetProperty("Name");
					var subItemPropertyInfo5 = subItem.GetType().GetProperty("Paths");

					if(subItemPropertyInfo1 != null) {sb1.AppendFormat("Key : {0}\n", subItemPropertyInfo1.GetValue(subItem, null));}
					if(subItemPropertyInfo2 != null) {sb1.AppendFormat("Value : {0}\n", subItemPropertyInfo2.GetValue(subItem, null));}
					if(subItemPropertyInfo3 != null) {sb1.AppendFormat("ID : {0}\n", subItemPropertyInfo3.GetValue(subItem, null));}
					if(subItemPropertyInfo4 != null) {sb1.AppendFormat("Name : {0}\n", subItemPropertyInfo4.GetValue(subItem, null));}
					if(subItemPropertyInfo5 != null) {
						var subPropertyObject = subItemPropertyInfo5.GetValue(subItem, null);
						var subPropertyInfo = subPropertyObject.GetType().GetProperty("FullPath");
						sb1.AppendFormat("Paths.FullPath : {0}\n", subPropertyInfo.GetValue(subPropertyObject, null));
					}

					var subItemMisc = sb1.ToString();
					%>
					<tr>
						<td><pre><%= System.Web.HttpUtility.HtmlEncode(subItemMisc) %></pre></td>
						<td><%= System.Web.HttpUtility.HtmlEncode(subItem.ToString()) %></td>
						<td><%= subItem.GetType() %></td>
					</tr>
				<%
				}
				%>
				</tbody>
				</table>
			</td></tr>
			<%
			}
			%>
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
