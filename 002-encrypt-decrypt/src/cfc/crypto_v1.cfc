<!---
	利用不推奨
	ColdfusionのDecrypt、Decrypt関数を使わないで暗号化、複合を行うコンポーネント
--->
<cfcomponent>
	<cffunction name="Encrypt" access="remote" returntype="array"
	  hint="javaのASE暗号化関数、暗号化文字列とiVを返す">
		<cfargument name="_str" type="string" required="yes">
		<cfargument name="_key" type="string" required="yes">
		
		<cfset returnEncryptedArray = ArrayNew(1)>
		<cfset returnEncryptedArray[1] = "not Encrypt">
		
		<!---  秘密鍵の生成 --->
		<!--- javax.crypto.spec.SecretKeySpec ...> https://docs.oracle.com/javase/jp/8/docs/api/javax/crypto/spec/package-summary.html --->
		<cfset SecretKeySpec = createObject( "java", "javax.crypto.spec.SecretKeySpec" ) />
		<!--- 文字列をバイナリ表現に変換 --->
		<cfset crypt_param_bytes = CharsetDecode( arguments._key, "utf-8" ) />
		<cfset keySpec = SecretKeySpec.init( crypt_param_bytes, "AES" ) />
		
		<!--- get a cipher instance for encrypting --->
		<!--- 暗号化のための暗号インスタンスを取得 --->
		<cfset ivParameterSpec = createObject( "java", "javax.crypto.spec.IvParameterSpec" ) />
		<cfset Cipher = createObject( "java", "javax.crypto.Cipher" ) />
		<cfset encryptor = Cipher.getInstance( "AES/CBC/PKCS5Padding" ) />
		<cfset encryptor.init( Cipher.ENCRYPT_MODE, keySpec ) />
		
		<!--- do the encryption --->
		<!--- 暗号化を行う --->
		<cfset myTextBytes = CharsetDecode( arguments._str, "utf-8" ) />
		<cfset javaEncrypted = encryptor.doFinal( myTextBytes ) />
		<!--- ivを生成（初期化ベクトル用文字列） --->
		<cfset javaIv = encryptor.getIV() />
		
		<cfset returnEncryptedArray[1] = BinaryEncode( javaEncrypted, "Base64" ) />
		<cfset returnEncryptedArray[2] = BinaryEncode( javaIv, "Base64" ) />
		
		<cfreturn returnEncryptedArray >
	</cffunction>

	<cffunction name="Decrypt" access="remote" returntype="string" hint="javaのASE復号化関数">
		<cfargument name="_str" type="string" required="yes">
		<cfargument name="_key" type="string" required="yes">
		<cfargument name="_iv" type="string" required="yes">
		
		<cfset returnDecryptedString = "not Decrypt">
		
		<!--- 秘密鍵の生成 --->
		<cfset SecretKeySpec02 = createObject( "java", "javax.crypto.spec.SecretKeySpec" ) />
		<cfset crypt_param_bytes02 = CharsetDecode( _key, "utf-8" ) />
		<cfset keySpec02 = SecretKeySpec02.init( crypt_param_bytes02, "AES" ) />
		
		<!--- get a cipher instance for encrypting --->
		<!--- 復号化のための暗号インスタンスを取得 --->
		<cfset ivParameterSpec02 = createObject( "java", "javax.crypto.spec.IvParameterSpec" ) />
		<cfset Cipher02 = createObject( "java", "javax.crypto.Cipher" ) />
		<cfset decryptor02 = Cipher02.getInstance( "AES/CBC/PKCS5Padding" ) />
		<cfset decryptor02.init( Cipher02.DECRYPT_MODE, keySpec02, ivParameterSpec02.init( ToBinary(_iv) ) ) />
		
		<!--- do the encryption --->
		<!--- 復号化を行う --->
		<cfset returnDecryptedString = ToString( decryptor02.doFinal( ToBinary(_str) ) ) />
		
		<cfreturn returnDecryptedString >
	</cffunction>
</cfcomponent>