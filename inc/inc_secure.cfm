<!--- Check to see if session.uid exists. If not, send user to the login --->
<cfif NOT IsDefined("session.uid")>
	
	
<cflocation url="./access.cfm" >

  <cfabort>

</cfif>
