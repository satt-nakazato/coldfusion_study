<cfdump var="#session#">
<cfif NOT IsDefined("cflogin")>
    is logout<br>
</cfif>

<cflogin>
    <cfif NOT IsDefined("cflogin")> 
        <cfloginuser 
            name="admin01" 
            password="abc" 
            roles="admin,user"
        >
    </cfif>
</cflogin>

<cfdump var="#session#">
<cfdump var="#cookie#">
<cfdump var="#GetAuthUser()#"><br>
<cfdump var="#IsUserInRole("admin")#"><br>
