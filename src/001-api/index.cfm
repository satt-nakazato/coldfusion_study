<cftry>
<cfoutput>
	<b>REST API</b> is running at <i>http://{your server}/rest/controller/APIroutes/</i><br>
	<b>Application root:</b> #getPageContext().getRequest().getRequestURI()#
	#getDirectoryFromPath(getCurrentTemplatePath())#
	#Application.jwtkey#
</cfoutput>
<cfcatch type="any">
	<cfdump var="#cfcatch#">
</cfcatch>
</cftry>

