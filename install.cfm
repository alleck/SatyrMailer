<!---
Creating Co. : Hostek.com
Programmed by: Kaleb L.
Creation Date: 11/15/2014
--->

<link href='http://fonts.googleapis.com/css?family=Lobster|Titillium+Web:400,300,600,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="./css/bootstrap.min.css">

<style type="text/css">
	.logo {
		font-size: 60px;
		padding: 0px;
		margin: 0px 0px 10px 0px;
		font-style: oblique;
		color: #FF890A;
		text-shadow: 2px 2px #5c5c5c;
		font-family: 'Lobster', cursive;
	}
	.installFrame {
		margin: 5% auto auto auto;
		z-index: 1;
		width: 70%;
		min-width: 275px;
		padding: 10px;
		-webkit-border-radius: 5px;
		-moz-border-radius: 5px;
		border-radius: 5px;
		border: outset;
		box-shadow: 10px 10px 5px #555;
		box-sizing: initial;
		font-family: Titillium Web;
		font-weight: 700;
	 }
	 
	 .data {
	 	
	 	width: 40%;
	 	font-family: Titillium Web;
	 }
	 
	 td { 
	    padding: 10px;
	 }
	 
	 .center {
	 	text-align: center;
	 }
</style>
	
<div class="well well-sm installFrame">
	<h1 class="logo center">SatyrMailer</h1>
	<form action="" method="post" >
		<table>
			<tr>
				<td class="data" rowspan="2">
					This will be the unique username used to login to the mailer control panel. <em><strong>*NOTE: I would suggest using something BESIDES <code>admin</code></strong></em>.
				</td>
				<td>
					<h3>Username</h3>
				</td>
			</tr>
				<td>
					<input type="text" name="FirstUser" class="form-control" />
				</td>
			<tr>
			</tr>
			<tr>
				<td class="data" rowspan="2">
					Please use a secure password. Strong passwords consist of <em><strong>a lowercase letter</strong></em>, <em><strong>an uppercase character</strong></em>, <em><strong>a number</strong></em>, and <strong><em>a special character</strong></em>.
				</td>
				<td>
					<h3>Password<h3>
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="FirstPass" class="form-control" />
				</td>
			</tr>
			<tr>
				<td class="data" rowspan="2">
					Please re-type your password to ensure that there are no misspellings or missing characters.
				</td>
				<td>
					<h3>Re-type Password<h3>
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="FirstPassCheck" class="form-control" />
				</td>
			</tr>
			<tr>
				<td class="data" rowspan="2">
					Add your the DNS for the database you wish for SatyrMail to use. <em><strong>*Note: This could erase any data that is currently in that database</strong></em>.
				</td>
				<td>
					<h3>DSN<h3>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="FirstDSN" class="form-control" />
				</td>
			</tr>
			<tr>
				<td colspan="2" class="center">
					<input type="submit" name="install" value="Install" class="btn btn-primary">
				</td>
			</tr>
		</table>
	</form>
	<p class="center">
		<cfif StructKeyExists(Form, "FirstUser")>
			<cfif len(Form.FirstUser)>
				<cfif len(Form.FirstPass)>
					<cfif trim(Form.FirstPass) EQ trim(Form.FirstPassCheck)>
						<cfif len(Form.FirstDSN)>
							
							<cfset rnd="">
						    <cfset i=0>
														
							 <!--- Create string --->
							<cfloop index="i" from="1" to="25">
							    <!--- Random character in range A-Z --->
							    <cfset rnd=rnd&Chr(RandRange(65, 90))>
							</cfloop>

<!--- Data for the config.cfm file --->						
<cfsavecontent variable="configCode">					
<%!---
Creating Co. : SatyrCast Softwares
Programmed by: Kaleb L.
Creation Date: 11/15/2014
---%>


<%!--- Set the DSN of the mailer ---%>
<%cfset Application.DSN = "<cfoutput>#Form.FirstDSN#</cfoutput>"%>

<%!--- Security key of all requests ---%>
<%cfset SecurityKey = "<cfoutput>#rnd#</cfoutput>"%>
<%cfset Application.key = #Hash(SecurityKey , "SHA-512")#%>
</cfsavecontent>

							<cfset configCode = reReplace(configCode, "<%", "<", "all" ) >
							<cfset configCode = reReplace(configCode, "%>", ">", "all" ) >
							
							<cffile action="write" file="./config.cfm" output="#configCode#" >
							
							<cfquery datasource="#Form.FirstDSN#">
								CREATE TABLE IF NOT EXISTS `mailersettings` (
								  `SMTPHost` varchar(125) NOT NULL,
								  `SMTPPort` int(10) NOT NULL,
								  `SMTPAddress` varchar(125) NOT NULL,
								  `SMTPPassword` varchar(125) NOT NULL
								)
							</cfquery>
							<cfquery datasource="#Form.FirstDSN#">
								INSERT INTO `mailersettings` (`SMTPHost`, `SMTPPort`, `SMTPAddress`, `SMTPPassword`) VALUES (' ', 25, ' ', ' ');
							</cfquery>
							<cfquery datasource="#Form.FirstDSN#">
								CREATE TABLE IF NOT EXISTS `mailerstats` (
								  `SentMessages` int(11) NOT NULL,
								  `TemplateNumber` int(11) NOT NULL,
								  `ContactNumber` int(11) NOT NULL
								)
							</cfquery>
							<cfquery datasource="#Form.FirstDSN#">
								INSERT INTO `mailerstats` (`SentMessages`, `TemplateNumber`, `ContactNumber`) VALUES (0, 0, 0)
							</cfquery>
							<cfquery datasource="#Form.FirstDSN#">
								CREATE TABLE IF NOT EXISTS `mailersubscribers` (
								  `ID` int(11) NOT NULL,
								  `Email` varchar(125) NOT NULL
								) AUTO_INCREMENT=4
							</cfquery>
							<cfquery datasource="#Form.FirstDSN#">
								ALTER TABLE `mailersubscribers`
								ADD PRIMARY KEY (`ID`)
							</cfquery>	
							<cfquery datasource="#Form.FirstDSN#">
								ALTER TABLE `mailersubscribers`
 								MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4
 							</cfquery>	
 							<cfquery datasource="#Form.FirstDSN#">	
 								CREATE TABLE IF NOT EXISTS `mailertemplates` (
								  `ID` int(11) NOT NULL,
								  `Subject` varchar(250) NOT NULL,
								  `Body` mediumtext NOT NULL,
								  `Created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
								) AUTO_INCREMENT=8
							</cfquery>	
							<cfquery datasource="#Form.FirstDSN#">
								ALTER TABLE `mailertemplates`
								ADD PRIMARY KEY (`ID`)
							</cfquery>	
							<cfquery datasource="#Form.FirstDSN#">
								ALTER TABLE `mailertemplates`
								MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8
							</cfquery>	
							<cfquery datasource="#Form.FirstDSN#">
								CREATE TABLE IF NOT EXISTS `mailerusers` (
								  `user` varchar(100) NOT NULL,
								  `pass` varchar(200) NOT NULL,
								  `perms` int(11) NOT NULL
								)
							</cfquery>
							<cfquery datasource="#Form.FirstDSN#">
								INSERT INTO `mailerusers` (`user`, `pass`, `perms`) VALUES ('<cfoutput>#Form.FirstUser#</cfoutput>', '<cfoutput >#Hash(Form.FirstPass, "SHA-512" )#</cfoutput>', 1);
							</cfquery>
							<cfoutput>
								<cfset SecurityKey = "#rnd#">
								<cfset Application.key = #Hash(SecurityKey , "SHA-512")#>
								<cfset Application.DSN = "#Form.FirstDSN#">
							</cfoutput>
							<cffile action="delete" file="./install.cfm" >
							<cflocation url="./access.cfm" >
						<cfelse>
							<div class="alert alert-danger center" role="alert">You have not defined a <em>DSN</em>. Please do so.</div>
						</cfif>					
					<cfelse>
						<div class="alert alert-danger center" role="alert">The re-typed password did not match the first password.</div>
					</cfif>
				<cfelse>
					<div class="alert alert-danger center" role="alert">You have not defined a <em>Password</em>. Please do so.</div>
				</cfif>
			<cfelse>
				<div class="alert alert-danger center" role="alert">You have not defined a <em>Username</em>. Please do so.</div>
			</cfif>
		</cfif>
	</p>
</div>