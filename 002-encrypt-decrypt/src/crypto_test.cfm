
<cfobject name="mycrypto" component="cfc.crypto">
<cfobject name="mycrypto_v1" component="cfc.crypto_v1">

<form method="POST">
</form>
<cflock timeout="10" throwontimeout="No" type="Readonly" scope="Application">
	<cfset key = Application.AES_KEY>
</cflock>


<cfset a["key"] = key>

<cfset a["data"] = "">

<cfset data["id"] = 1>
<cfset data["login"] = "user001">
<cfset data["name"] = "中里">

<cfset a["data"] = SerializeJSON(data)>

<cfset a["data_encryptV1"] = mycrypto_v1.Encrypt(a["data"],key)>
<cfset a["data_encryptV2"] = mycrypto.Encrypt(a["data"],key)>

<cfdump var="#a#">

<cfset a["data_decryptV1"] = mycrypto_v1.Decrypt(a["data_encryptV1"][1],key,a["data_encryptV1"][2])>
<cfset a["data_decryptV2"] = mycrypto.Decrypt(a["data_encryptV2"][1],key,a["data_encryptV2"][2])>
<cfset a["data_decryptV1_json"] = DeserializeJSON(a["data_decryptV1"])>
<cfset a["data_decryptV2_json"] = DeserializeJSON(a["data_decryptV2"])>

<cfdump var="#a#">
<cfoutput>
#SerializeJSON(a)#
</cfoutput>
