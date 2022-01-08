<cfcomponent>
	
	<cffunction name="Encrypt" access="remote" returntype="array"
	  hint="暗号化文字列とiVを返す">
	<cfargument name="_str" type="string" required="yes">
	<cfargument name="_key" type="string" required="yes">

		<cfset returnEncryptedArray = ArrayNew(1)>
		<cfset returnEncryptedArray[1] = "not Encrypt">
		<cfset iv = createIVSalt()>
		
		<cfscript>
			str_Encrypted = Encrypt(string = arguments._str
									,key = arguments._key
									,algorithm = "AES"
									,encoding = "Base64"
									,IV_Salt = iv
							);
		</cfscript>

		<cfset returnEncryptedArray[1] = str_Encrypted />
		<cfset returnEncryptedArray[2] = BinaryEncode( iv, "Base64" ) />
	<cfreturn returnEncryptedArray >
	</cffunction>
	
	<cffunction name="Decrypt" access="remote" returntype="string"
	 hint="AESで復号">
	<cfargument name="_str" type="string" required="yes">
	<cfargument name="_key" type="string" required="yes">
	<cfargument name="_iv" type="string" required="yes">
		<cfscript>
			str_Decrypted = Decrypt(string = arguments._str
									,key = arguments._key
									,algorithm = "AES"
									,encoding = "Base64"
									,IV_Salt = arguments._iv);
		</cfscript>
	<cfreturn str_Decrypted >
	</cffunction>
	
	<cffunction name="createIVSalt" access="private">
		<cfscript>
			randomIntegers = [];
			// generate the SALT value
			for ( i = 1 ; i <= 12 ; i++ ) {
				arrayAppend( randomIntegers, randRange( -128, 127, "SHA1PRNG" ) );
			}
			initializationVector = javaCast( "byte[]", randomIntegers );
		</cfscript>
	<cfreturn initializationVector >
	</cffunction>

</cfcomponent>