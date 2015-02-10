<!---
Creating Co. : Hostek.com
Programmed by: Kaleb L.
Creation Date: 11/15/2014
--->

<cfif FileExists('./config.cfm')>

	<cfheader name="expires" value="#getHttpTimeString(now())#"> 
	<cfheader name="pragma" value="no-cache"> 
	<cfheader name="cache-control" value="no-cache, no-store, must-revalidate"> 
	
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	
	
	<!--- Latest compiled and minified CSS --->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	
	<!--- Optional theme --->
	<link rel="stylesheet" href="./css/bootstrap-theme.min.css">
	
	<!--- Latest compiled and minified JavaScript --->
	<script src="./js/bootstrap.min.js"></script>
	
	<!--- Google Fonts API include --->
	<link href='http://fonts.googleapis.com/css?family=Lobster|Titillium+Web:400,300,600,700' rel='stylesheet' type='text/css'>
	
	<!--- CSS includes --->
	<link href="./css/style.css" type="text/css" rel="stylesheet" />
	
	<!--- The index file holds the main header information --->
	<h1 class="logo">SatyrMailer</h1>
	
	<!--- Include for the global configuration file --->
	<cfinclude template="config.cfm" >
	<cfinclude template="./inc/inc_secure.cfm" >
	
	<!--- Main navagation bar --->
	<div class="nav">
	<a href="index.cfm">Home</a>
	<a href="main.cfm">Mailer</a>
	<a href="templates.cfm">Templates</a>
	<a href="subscribers.cfm">Subscribers</a>
	<a href="access.cfm?killSession">Log Out</a>
	</div>

<cfelse>

<cflocation url="install.cfm" >

</cfif>