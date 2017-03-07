README

Sandbox Sitecore MVC
Created by William Chang

Created: 2016-02-23
Modified: 2016-12-13

================================================================================

Links

http://localhost:50216/SandboxSites/Site0001/Home
http://localhost:50216/SandboxSites/Site0001/Home/Echo

--------------------------------------------------------------------------------

Dependencies

Sitecore Application
Sitecore 8.2 rev. 161115.zip
    Sitecore Experience Platform 8.2 rev. 161115 (8.2 Update-1)

Sitecore Package
SandboxSites_Bak_201612130000.zip
    SandboxSites_Bak_201612130000.xml Sitecore Package Designer File

================================================================================

SandboxSites.Web.csproj

<Project>
  <PropertyGroup>
    <ProjectTypeGuids>{349c5851-65df-11da-9384-00065b846f21};{fae04ec0-301f-11d3-bf4b-00c04f79efbc}</ProjectTypeGuids>
  </PropertyGroup>
</Project>

<Project>
  <PropertyGroup>
    <PreBuildEvent>call xcopy "$(SolutionDir)Sitecore.Libraries\*.*" "$(TargetDir)" /S /Y</PreBuildEvent>
  </PropertyGroup>
</Project>

--------------------------------------------------------------------------------

SandboxSites.Web.csproj - Solution Explorer

App_Config
    ConnectionStrings.config
    ConnectionStringsMsSql_FileSystem.config
    Sitecore.config
Areas
    Shared
        Controllers
            BaseController.cs
            GeneralController.cs
        Models
        Views
            Design
            General
            Shared
            web.config
    Site1
        Controllers
            BaseController.cs
            GeneralController.cs
        Models
        Views
            General
            Widgets
            web.config
Web.config

================================================================================

Edit Configuration Files

Web.config
01.00 Find "<connectionStrings configSource="App_Config\ConnectionStrings.config" />"
01.01 Replace with "<connectionStrings configSource="App_Config\ConnectionStringsMsSql_FileSystem.config" />" 
02.00 Find "<compilation defaultLanguage="c#" debug="false" targetFramework="4.5">"
02.01 Replace with "<compilation defaultLanguage="c#" debug="true" targetFramework="4.5">"
03.00 Find "<site name="website" enableTracking="true" virtualFolder="/" physicalFolder="/" rootPath="/sitecore/content" startItem="/home" database="web" domain="extranet" allowDebug="true" cacheHtml="true" htmlCacheSize="50MB" registryCacheSize="0" viewStateCacheSize="0" xslCacheSize="25MB" filteredItemsCacheSize="10MB" enablePreview="true" enableWebEdit="true" enableDebugger="true" disableClientData="false" cacheRenderingParameters="true" renderingParametersCacheSize="10MB" />"
03.01 Replace with "<site name="website" enableTracking="true" virtualFolder="/" physicalFolder="/" rootPath="/sitecore/content" startItem="/home" database="master" domain="extranet" allowDebug="true" cacheHtml="true" htmlCacheSize="50MB" registryCacheSize="0" viewStateCacheSize="0" xslCacheSize="25MB" filteredItemsCacheSize="10MB" enablePreview="true" enableWebEdit="true" enableDebugger="true" disableClientData="false" cacheRenderingParameters="true" renderingParametersCacheSize="10MB" />"

App_Config\Sitecore.config
01.00 Find "<sc.variable name="dataFolder" value="C:\Sites\sandbox3.sitecore.net.data" />"
01.01 Replace with "<sc.variable name="dataFolder" value="/data" />"

App_Config\Include\Sitecore.Xdb.config
01.00 Find "<setting name="Xdb.Enabled" value="true" />"
01.01 Replace with "<setting name="Xdb.Enabled" value="false" />"

================================================================================

File System Structure

SandboxSitecoreMvc
    SandboxSites.Web
        SandboxSites.Web.csproj
    Sitecore.Files
        Build.msbuildproj
    Sitecore.Libraries
README.txt
SandboxSitecoreMvc.sln

================================================================================
