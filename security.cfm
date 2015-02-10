<!---
Creating Co. : Hostek.com
Programmed by: Kaleb L.
Creation Date: 11/15/2014
--->

<cftry>

<cfif IsDefined("form.uid") AND IsDefined("form.pwd")>

  <cfif Trim(Len(form.uid)) EQ 0 OR Trim(Len(form.pwd)) EQ 0>

    <cfthrow message="User name, password or datasource blank.">

   <cfelse>
    <!--- check if the user has basic select privileges --->

     <cfquery datasource="#Application.DSN#" name="check_authorization">

      select
        *
       from
        mailerusers
	
    </cfquery>
    <cfset passhash = #Hash(form.pwd , "SHA-512")#>
	<cfif Hash(Trim(passhash)) EQ Hash(Trim(check_authorization.pass)) AND Hash(Trim(form.uid)) EQ Hash(Trim(check_authorization.user)) >

		<cflock timeout="15">
		
			<cfset Session.uid = Trim(form.uid)>
			<cfset Session.pwd = Trim(passhash)>
		
		</cflock>
		<cflocation url="index.cfm" >
		
	<cfelse>
		Login not defined
	</cfif>

   </cfif>

<cfelseif (NOT IsDefined("Session.uid"))>

  <cfthrow message="User not logged in, or session timed out.">

</cfif>

<!--- Your code goes here --->

<cfcatch>

   An authorization error has occurred<br />
<br />
  Message: <cfoutput>#cfcatch.message#</cfoutput><br />
<br />
  Please click on the button to login.<br />
<br />
  <input type="button" value="Login" onclick="location.replace('access.cfm')">

</cfcatch>
</cftry>