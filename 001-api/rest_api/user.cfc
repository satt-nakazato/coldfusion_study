<cfcomponent rest="true" restpath="user">

	<cfobject name="objUser" component="cfc.user">
  
	<!--- Function to validate token--->
	<cffunction name="authenticate" returntype="any">
		<cfset var response = {}>
		<cfset requestData = GetHttpRequestData()>
		<cfif StructKeyExists( requestData.Headers, "authorization" )>
			<cfset token = GetHttpRequestData().Headers.authorization>
			<cftry>
				<cfset jwt = new cfc.jwt(Application.jwtkey)>
				<cfset result = jwt.decode(token)>
				<cfset response["success"] = true>
				<cfcatch type="Any">
				<cfset response["success"] = false>
				<cfset response["message"] = cfcatch.message>
				<cfreturn response>
				</cfcatch>
			</cftry>
		<cfelse>
			<cfset response["success"] = false>
			<cfset response["message"] = "Authorization token invalid or not present.">
		</cfif>
	<cfreturn response>
	</cffunction>
  
	<!--- User Login--->
	<cffunction name="login" restpath="login" access="remote" returntype="struct" httpmethod="POST" produces="application/json">
	<cfargument name="structform" type="any" required="yes">

		<cfset var response = {}>
		<cfset response = objUser.loginUser(structform)>
		
	<cfreturn response>
	</cffunction>
	 
	<!--- User specific functions --->
	<cffunction name="getuser" restpath="user/{id}" access="remote" returntype="struct" httpmethod="GET" produces="application/json">
	<cfargument name="id" type="any" required="yes" restargsource="path"/>
		<cfset var response = {}>

		<cfset verify = authenticate()>
		<cfif not verify.success>
			<cfset response["success"] = false>
			<cfset response["message"] = verify.message>
			<cfset response["errcode"] = 'no-token'>
		<cfelse>
			<cfset response = objUser.userDetails(arguments.id)>
		</cfif>

	<cfreturn response>
	</cffunction>

</cfcomponent>