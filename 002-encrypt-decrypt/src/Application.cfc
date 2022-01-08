<cfcomponent output="false">
	<cfset this.name = "002-encrypt-decrypt">
	<cfset this.restsettings.cfclocation = "./">
	<cfset this.restsettings.skipCFCWithError = true>



	<cffunction name="onApplicationStart" returnType="boolean">
		<cfset Application.AES_KEY = generateSecretKey("AES",128)>
		<cfreturn true>
	</cffunction>
	
	<cffunction name="onRequestStart" returnType="void" output="true">
		<cflog file="#this.name#_debug" text="onRequestStart1">
		<cfif isDefined("URL.reload") AND URL.reload EQ "r3l0ad">
			<cflock timeout="10" throwontimeout="No" type="Exclusive" scope="Application">
				<cflog file="#this.name#_debug" text="onRequestStart2">
				<cfset onApplicationStart()>
			</cflock>
			<cfsavecontent variable="cfhead_text">
				<script language="Javascript">alert("Application was refreshed.");</script>
			</cfsavecontent>
			<cfhtmlhead text="#cfhead_text#"/>
		</cfif>
	</cffunction>
</cfcomponent>
