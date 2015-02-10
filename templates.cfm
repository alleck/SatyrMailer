<!---
Creating Co. : Hostek.com
Programmed by: Kaleb L.
Creation Date: 11/15/2014
--->

<cfinclude template="header.cfm" >

<cfoutput>
	<script type="text/javascript">
	function conf(){
	var r = confirm("Are you sure you wish to purge ALL templates?");
	if (r == true) {
	    window.location.href = "manage.cfm?key=#Application.key#&section=templates&action=purge&transacted=#listlast(cgi.script_name,'/\')#";
	} else {
	    x = "You pressed Cancel!";
	}
	}
	</script>
</cfoutput>

<div class="wrapper">
	<form action="" method="post">
		<strong>Message Subject</strong><br />
		<input type="text" name="MessageSubject" class="form-control" size="35" /><br /><br />
		<strong>Message Body</strong><br />
		<textarea rows="10" name="MessageBody" class="form-control"></textarea><br />
		<div class="right"><input type="submit" name="Save" class="btn btn-default" value="Save Template" /></div>
	</form>
	
	
	<cfif #StructKeyExists(form, "MessageSubject")#>
		
		<cfif len(Form.MessageSubject) >
			<cfif len(Form.MessageBody) >
				<cfquery datasource="#Application.DSN#" name="MailerTemplates">
					INSERT INTO `mailertemplates`(`Subject`, `Body`) VALUES ('#Form.MessageSubject#','#Form.MessageBody#')
				</cfquery>
				<div class="alert alert-success" role="alert">Successfully Added Template <strong><cfoutput>#Form.MessageSubject#</cfoutput></strong>.</div>
			<cfelse>
				<div class="alert alert-danger" role="alert">There are not characters present in the body of the message. Please add your message content.</div>
			</cfif>
		<cfelse>
			<div class="alert alert-danger" role="alert">There does not seem to be a subject for the message. Please add one.</div>
		</cfif>
		
	</cfif>
	
	<cfquery datasource="#Application.DSN#" name="MailerTemplates">
		SELECT * FROM mailertemplates
	</cfquery>
	
	<cfquery datasource="#Application.DSN#" name="MailerStats">
		UPDATE `mailerstats` SET `TemplateNumber`=#MailerTemplates.RecordCount#
	</cfquery>
	
	<h2>Avalible Templates</h2>
	<table border="0" cellpadding="5px" class="table table-bordered table-striped">
		<thead>
		<tr>
		<th>Subject</th>
		<th>Body</th>
		<th class="center">
			<cfoutput>
				<button type="button" id="btnOpenDialog" class="btn btn-danger btn-xs" title="Purge All Contacts" onclick="conf()">Purge</button>
			</cfoutput>
		</th>
		</tr>
		</thead>
		<cfoutput query="MailerTemplates">
		<tr>
		<td>#Subject#</td>
		<td>#Body#</td>
		<td class="center"><a href="manage.cfm?key=#Application.key#&section=templates&action=remove&ID=#ID#&transacted=#listlast(cgi.script_name,'/\')#"><span class="glyphicon glyphicon-trash" style="color: red; font-size: 20;" title="Delete"></span></a></td>
		</tr>
		</cfoutput>
	</table>
</div>
