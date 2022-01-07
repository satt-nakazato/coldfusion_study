<cfcomponent output="false">
	<cfset this.name = "cfrestdemo">
	<cfset this.restsettings.cfclocation = "./">
	<cfset this.restsettings.skipCFCWithError = true>

	<cfset This.ApplicationTimeOut="#CreateTimeSpan( 0, 0, 0, 0 )#" />


	<cffunction name="onApplicationStart" returnType="boolean">
		<cfset Application.jwtkey = "My$ecretKey">
		<cfset RestInitApplication(getDirectoryFromPath(getCurrentTemplatePath()) & 'rest_api', '#this.name#_api') >
		<cflog file="#this.name#_debug" text="onApplicationStart">
		<cfreturn true>
	</cffunction>
	
	<cffunction name="onRequestStart" returnType="void" output="true">
		<cflog file="#this.name#_debug" text="onRequestStart1">
		<cfif isDefined("URL.reload") AND URL.reload EQ "r3l0ad">
			<cflock timeout="10" throwontimeout="No" type="Exclusive" scope="Application">
				<cflog file="#this.name#_debug" text="onRequestStart2">
				<cfset OnApplicationStart()>
			</cflock>
			<cfsavecontent variable="cfhead_text">
				<script language="Javascript">alert("Application was refreshed.");</script>
			</cfsavecontent>
			<cfhtmlhead text="#cfhead_text#"/>
		</cfif>
	</cffunction>
</cfcomponent>
