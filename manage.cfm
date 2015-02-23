<!---
Creating Co. : Hostek.com
Programmed by: Kaleb L.
Creation Date: 11/15/2014
--->


<cfif #StructKeyExists(Application, "key")# AND #StructKeyExists(URL, "key")# >

	<cfif #URL.key# eq #Application.key# >
		<!--- The subscribers management section --->
		<cfif URL.section eq "subscribers">
			<!--- Remove and entry by ID --->
			<cfif #URL.action# eq "remove">
				<cfquery datasource="#Application.DSN#" name="MailerSubscribers">
					DELETE FROM `mailersubscribers` WHERE `ID`=#URL.ID#
				</cfquery>
			<!--- Add a new entry --->
			<cfelseif #URL.action# eq "add">
				<cfif #StructKeyExists(URL, "email")#>
					<cfquery datasource="#Application.DSN#" name="MailerSubscribers" timeout="60000">
						INSERT INTO `mailersubscribers`(`Email`) VALUES ('#URL.email#')
					</cfquery>
				</cfif>
			<!--- Purge the table --->
			<cfelseif #URL.action# eq "purge">
				<cfquery datasource="#Application.DSN#" name="MailerSubscribers" timeout="60000">
					TRUNCATE `mailersubscribers`
				</cfquery>
			<cfelse>
				Nope...
			</cfif>
		<!--- The Templates management section --->
		<cfelseif URL.section eq "templates" >
			<!--- Remove and entry by ID --->
			<cfif #URL.action# eq "remove">
				<cfquery datasource="#Application.DSN#" name="MailerSubscribers">
					DELETE FROM `mailertemplates` WHERE `ID`=#URL.ID#
				</cfquery>
			<!--- Purge the table --->
			<cfelseif #URL.action# eq "Purge">
				<cfquery datasource="#Application.DSN#" name="MailerSubscribers">
					TRUNCATE `mailertemplates`
				</cfquery>
			<cfelse>
			Nope...
			</cfif>
			
		<cfelseif URL.section eq "inc_css" >
			<!--- Update the CSS used for the "Subscribe"" toolbox --->
			<cfif #URL.action# eq "update">
				<cffile 
				    action = "write" 
				    file = "./inc/inc_sub_css.cfm"
				    output = "#Form.inc_css#">
			<cfelse>
			Nope...
			</cfif>
		<cfelse>
			Not quite...
		</cfif>
		<cflocation url="#URL.transacted#" >
	<cfelse>
		No... Nice try.
	</cfif>
	
<cfelse>	
The call to this function was not sent correctly.

</cfif>
