<!---
Creating Co. : Hostek.com
Programmed by: Kaleb L.
Creation Date: 11/15/2014
--->

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

<style type="text/css">
	
	.form-control {
		width: auto;
		display: inline-block;
		}
	
	<cfinclude template="./inc/inc_sub_css.cfm" >
	
</style>

<cfoutput>
	
		<!--- Single address add form --->
		<form action="" method="post" class="form-inline">
			<strong class="headerMessage">Sign Up Here</strong><br />
			<input type="text" name="EmailAddress" size="35" class="form-control" />
			<input type="submit" name="Add" value="subscribe" class="btn btn-default" />
		</form>
		
		<cfif isDefined("Form.EmailAddress") >
			<cfhttp method="post" URL="http://#CGI.HTTP_HOST##REReplace(CGI.SCRIPT_NAME,'\\|\/[^\\|\/]*$','/','ALL')#manage.cfm?key=#Application.key#&section=subscribers&action=add&transacted=#listlast(cgi.script_name,'/\')#&email=#Form.EmailAddress#">
		</cfif>
</cfoutput>