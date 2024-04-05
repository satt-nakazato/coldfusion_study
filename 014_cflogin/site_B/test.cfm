<cfdump var="#session#">
<cfif NOT IsDefined("cflogin")>
    is logout<br>
</cfif>

<cflogin>
    <cfif NOT IsDefined("cflogin")> 
        <cfloginuser 
            name="user01" 
            password="abc" 
            roles="user"
        >
    </cfif>
</cflogin>

<cfdump var="#session#">
<cfdump var="#cookie#">
<cfdump var="#GetAuthUser()#">
<cfdump var="#IsUserInRole("admin")#">
