<cfcomponent rest="true" restpath="user_controll">

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
	<cffunction httpmethod="POST" restpath="login"  name="login"access="remote" returntype="struct" produces="application/json">
	<cfargument name="structform" type="any" required="yes">

		<cfset var response = {}>
		<cfset response = objUser.loginUser(structform)>
		
	<cfreturn response>
	</cffunction>
	 
	<!--- User specific functions --->
	<cffunction httpmethod="GET" restpath="user/{id}" name="getuser" access="remote" returntype="struct" produces="application/json">
	<cfargument name="id" type="any" required="yes" restargsource="path"/>
		<cfset var response = {}>

		<!--- 認証チェック --->
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