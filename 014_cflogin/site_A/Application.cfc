<cfcomponent>

<cfset This.name="site_a" />
<cfset This.loginStorage="Session" />
<cfset This.sessionTimeout="#CreateTimeSpan( 0, 0, 100, 0 )#" />
<cfset This.sessionManagement="yes" />

</cfcomponent>

