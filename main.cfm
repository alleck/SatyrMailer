<!---
Creating Co. : Hostek.com
Programmed by: Kaleb L.
Creation Date: 11/15/2014
--->

<!--- Include nav header --->
<cfinclude template="header.cfm" >


<div class="wrapper">
	<style type="text/css">
		td { 
		    padding: 10px;
		}
	</style>
	<!--- Check to see if the form struct exists --->
	<cfif #StructKeyExists(form, "FromEmail")# >
		<cfif Len(Form.EmailHost)>
			<cfif Len(Form.SmtpPort)>
				<cfif Len(Form.FromEmail)>
					<cfif Len(Form.EmailPassword)>
						<cfif Len(Form.MessageUsed)>
							<cfquery datasource="#Application.DSN#" name="MailerSettings">
								UPDATE mailersettings SET SMTPHost='#Form.EmailHost#', SMTPPort=#Form.SmtpPort#, SMTPAddress='#Form.FromEmail#', SMTPPassword='#Form.EmailPassword#'
							</cfquery>
							
							<!--- Call all the subscribers from the database --->
							<cfquery datasource="#Application.DSN#" name="subscribers" timeout="6000000">
								SELECT Email FROM mailersubscribers
							</cfquery>
							
							<!--- Reset SentMessages to 0 for stats on the new job --->
							<cfquery datasource="#Application.DSN#" name="MailerStats" timeout="6000000">
								UPDATE `mailerstats` SET `SentMessages`= 0
							</cfquery>
							
							<!--- Call the template into query struct --->
							<cfquery datasource="#Application.DSN#" name="MailerTemplate" timeout="6000000">
								SELECT * FROM mailertemplates Where ID=<cfqueryPARAM value = "#MessageUsed#"
						    CFSQLType = 'CF_SQL_INTEGER'>
							</cfquery>
							
							<!--- Save the needed variables from the query struct --->
							<cfoutput query="MailerTemplate">
								<cfset Body = #Body# />
								<cfset Subject = #Subject# />
							</cfoutput>
							
							<!--- Loop through all the subscribers called from the database --->
							<cfloop query="subscribers">
								<cfoutput>
									<cfmail
										from="#Form.FromEmail#" 
										subject="#Subject#" 
										to="#Email#"
										server="#Form.EmailHost#"
								  		port="#Form.SmtpPort#"
								  		useSSL="#Form.UseSSL#"
								  		username="#Form.FromEmail#"
								  		password="#Form.EmailPassword#"
								  		type="#Form.MessageType#"
								  		timeout="6000000" >#Body#</cfmail>
								</cfoutput>
								
								<!--- Add +1 to SentMessages for each email that is sent to a subscriber --->
								<cfquery datasource="#Application.DSN#" name="MailerStats" timeout="6000000">
									UPDATE `mailerstats` SET `SentMessages`=`SentMessages` + 1
								</cfquery>
							</cfloop>
							<cfoutput>
								<br /><div class="alert alert-success" style="text-align: center;" role="alert">Email sent to <strong>#subscribers.RecordCount#</strong> contacts!</div><br />
							</cfoutput>
						<cfelse>
							<div class="alert alert-danger center" role="alert">A Template could not be found. Please ensure that you have created one.</div>
						</cfif>
					<cfelse>
						<div class="alert alert-danger center" role="alert">The SMTP Password has not been defined. Please do so.</div>
					</cfif>
				<cfelse>
					<div class="alert alert-danger center" role="alert">The SMTP User has not been defined. Please do so.</div>
				</cfif>
			<cfelse>
				<div class="alert alert-danger center" role="alert">The SMTP Port has not been defined. Please do so.</div>
			</cfif>
		<cfelse>
			<div class="alert alert-danger center" role="alert">The SMTP Host has not been defined. Please do so.</div>
		</cfif>
	</cfif>
	
	
	
	<!--- Initial queries to the database --->
	<cfquery datasource="#Application.DSN#" name="MailerSettings">
		SELECT * FROM mailersettings
	</cfquery>
	
	<cfquery datasource="#Application.DSN#" name="MailerTemplates">
		SELECT * FROM mailertemplates
	</cfquery>
	
	<!--- Main form for sending to the email list --->
	<form action="" method="post" role="form">
		
		<!--- SMTP settings for the mailer to use --->
		<cfoutput>
		<table style="width: 800px;">
			<tr>
				<td>
					<strong>SMTP Host</strong><br />
					<input type="text" name="EmailHost" class="form-control" value="#MailerSettings.SMTPHost#" />
				</td>
				<td>
					<strong>SMTP Port</strong><br />
					<input type="text" name="SmtpPort" class="form-control" value="#MailerSettings.SMTPPort#" />
				</td>
			</tr>
			<tr>
				<td>
					<strong>SMTP User (Email Address)</strong><br />
					<input type="text" name="FromEmail" class="form-control" value="#MailerSettings.SMTPAddress#" />
				</td>
				<td>
					<strong>SMTP Password</strong><br />
					<input type="password" name="EmailPassword" class="form-control" value="#MailerSettings.SMTPPassword#" />
				</td>
			</tr>
			<tr>
				<td>
					<strong>Use SSL</strong><br />
					<select class="form-control" name="UseSSL">
						<option value="false">False</option>
						<option value="true">True</option>
					</select>
				</td>
				<td>
					<strong>Message Type</strong><br />
					<select class="form-control" name="MessageType">
						<option value="html">HTML</option>
						<option value="text">Plain Text</option>
					</select>
				</td>
			</tr>
			<tr>
				<td><br />
				</td>
			</tr>
			<!--- Message fields to form the message that will be sent --->
			<tr>
				<td>
					<cfif #MailerTemplates.RecordCount# GT 0>
						<strong>Select Template to Send</strong><br />
						<select class="form-control" name="MessageUsed">
							<cfoutput query="MailerTemplates">
								<option value="#ID#">#Subject#</option>
							</cfoutput>
						</select>
					<cfelse>
						<div class="alert alert-danger center" role="alert">No Templates Avalible</div>
						<input type="hidden" name="MessageUsed" value="" />
					</cfif>
				</td>
			</tr>
			<tr>
				<td>
					<!--- Button to send the mail --->
					<input class="btn btn-success" type="submit" value="Send" name="Send" style="width: 100%;">
				</td>
			</tr>
		</table>
		</cfoutput>
	</form>

</div>