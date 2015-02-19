<!---
Creating Co. : Hostek.com
Programmed by: Kaleb L.
Creation Date: 11/15/2014
--->

<!--- Timout setting for the contact importer --->
<cfsetting 
    requestTimeOut = "60000">


<!--- Included header --->
<cfinclude template="header.cfm">


<div id="dialog-confirm"></div>	

<cfoutput>
	<script type="text/javascript">
	function conf(){
		var r = confirm("Are you sure you wish to purge ALL contacts?");
		if (r == true) {
		    window.location.href = "manage.cfm?key=#Application.key#&section=subscribers&action=purge&transacted=#listlast(cgi.script_name,'/\')#";
		} else {
		    x = "You pressed Cancel!";
		}
	}
	</script>
</cfoutput>


<!--- Main content wrapper --->
<div class="wrapper">
	<div class="subscribers">
		
		<!--- Single address add form --->
		<form action="" method="post" class="form-inline">
			<strong>Add Email Address</strong><br />
			<input type="text" name="EmailAddress" size="35" class="form-control" />
			<input type="submit" name="Add" value="Add" class="btn btn-default" />
		</form>

<!--- Check to see if the a request to import contacts has been initiated --->
<cfif StructKeyExists(Form, "FileContents") >
	
	<!--- Ensure that the user has chosen a file to import --->
	<cfif len(Form.FileContents) >
		
		<!--- Create a temp name for the uploaded file --->
		<cfset tempname = "#DateFormat(Now())##Hour(Now())##Minute(Now())##Second(Now())#">
		
		<!--- Main function to import the CSV file --->
		<cffile 
		    action = "upload"
		    destination = "tmp\#tempname#.csv"
		    fileField="FileContents"
		    accept = "application/octet-stream"
		    mode = "644"
		    nameConflict = "MakeUnique">
			
	 
		<cffile action="read" file="tmp\#tempname#.csv" variable="csvfile">
	
	
	
		<!--- Initiate the counter for how many email addresses were added --->
		<cfset counter = 0 />
		<cfloop index="index" list="#csvfile#" delimiters="#chr(10)##chr(13)#"> 
		    
			<!--- Check each entry to make sure it is a valid email address --->
			<cfif #find("@", listgetAt('#index#',1, ','))# >
				
				<!--- Increase the counter for each entry that passes --->
				<cfset counter = counter + 1 />
				<cfquery datasource="#Application.DSN#" name="MailerSubscribers" timeout="60000">
					INSERT INTO `mailersubscribers`(`Email`) VALUES ('#REReplace(listgetAt(index,1, ','),"""","","ALL")#')
				</cfquery>
		    </cfif>
		
		</cfloop>
		
		<!--- Success Pop-up --->
		<cfoutput >
			<div class="alert alert-success" role="alert">#counter# records added to the contacts database!</div>
		</cfoutput>
		
		<!--- Task to clean up the file in the tmp direcory --->
		<cffile 
		    action = "delete"
		    file = "tmp\#tempname#.csv">
	
	<!--- If the form tries to submit an import without choosing a file. Display error --->
	<cfelse>
			
			<div class="alert alert-danger" role="alert">Please choose a file to import!</div>

	</cfif>		
	
	<!--- CSV import form --->
	<strong>Import/Export CSV Contact File</strong><br />
    <form id="importcsv" class="form-inline" method="post" action="<cfoutput>#cgi.script_name#</cfoutput>"
        name="uploadForm" enctype="multipart/form-data" style="display: inline-block;">
        <input name="FileContents" class="form-control btn btn-default" type="file" accept="text/csv">
        <input name="submit" type="submit" class="btn btn-success" data-toggle="modal" data-target="#myModal" value="Import Contacts"> 
    </form>
    
    <!--- Export contacts to CSV form --->
    <form id="exportcsv"class="form" method="post" action="<cfoutput>#cgi.script_name#</cfoutput>"
        name="exportForm" enctype="multipart/form-data" style="display: inline-block;">
        <input type="hidden" name="Export" value="Export" />
        <input name="submit" type="submit" class="btn btn-info" value="Export Contacts"> 
    </form>
	

	<!--- Processing window pop-up --->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-body">
	      	Please Wait...
	        <div class="progress">
			  <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
			  </div>
			</div>
	      </div>
	    </div>
	  </div>
	</div>
		    
<cfelse>
	
    <!--- If FALSE, just show the Form. --->
	<strong>Import/Export CSV Contact File</strong><br />
    <form id="importcsv" class="form-inline" method="post" action="<cfoutput>#cgi.script_name#</cfoutput>"
        name="uploadForm" enctype="multipart/form-data" style="display: inline-block;">
        <input name="FileContents" class="form-control btn btn-default" type="file" accept="text/csv">
        <input name="submit" type="submit" class="btn btn-success" data-toggle="modal" data-target="#myModal" value="Import Contacts"> 
    </form>
    
    <!--- Export contacts to CSV form --->
    <form id="exportcsv"class="form" method="post" action="<cfoutput>#cgi.script_name#</cfoutput>"
        name="exportForm" enctype="multipart/form-data" style="display: inline-block;">
        <input type="hidden" name="Export" value="Export" />
        <input name="submit" type="submit" class="btn btn-info" value="Export Contacts"> 
    </form>

	<!--- Processing window pop-up --->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-body">
	      	Please Wait...
	        <div class="progress">
			  <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
			  </div>
			</div>
	      </div>
	    </div>
	  </div>
	</div>




</cfif>		


		
		<!--- Single address add lisenter --->
		<cfif #StructKeyExists(form, "EmailAddress")#>
			<cfquery datasource="#Application.DSN#" name="MailerSubscribers" timeout="60000">
				INSERT INTO `mailersubscribers`(`Email`) VALUES ('#Form.EmailAddress#')
			</cfquery>
		</cfif>
		<cfif #StructKeyExists(url, "pg")#>
			<!--- Display all the contacts avalible in the database --->
			<cfoutput>
				<cfif #URL.pg# eq "all">
					<cfquery datasource="#Application.DSN#" name="MailerSubscribers" timeout="60000">
						SELECT * FROM mailersubscribers ORDER BY EMAIL
					</cfquery>
				<cfelseif #URL.pg# eq "0">
					<cfquery datasource="#Application.DSN#" name="MailerSubscribers" timeout="60000">
						SELECT * FROM mailersubscribers WHERE Email REGEXP "^[0-9]" ORDER BY EMAIL
					</cfquery>
				<cfelse>
					<cfquery datasource="#Application.DSN#" name="MailerSubscribers" timeout="60000">
						SELECT * FROM mailersubscribers WHERE Email LIKE "#URL.pg#%" ORDER BY EMAIL
					</cfquery>
				</cfif>
			</cfoutput>
		<cfelse>
			<!--- Display all the contacts avalible in the database --->
			<cfquery datasource="#Application.DSN#" name="MailerSubscribers" timeout="60000">
				SELECT * FROM mailersubscribers
			</cfquery>
		</cfif>
		<!--- Increase the count for each contact added --->
		<cfquery datasource="#Application.DSN#" name="MailerStats" timeout="60000">
			UPDATE `mailerstats` SET `ContactNumber`=#MailerSubscribers.RecordCount#
		</cfquery>
			    
			    
		<h2>Current Subscribers</h2>
		<cfset byName = "0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,all" />
		<cfloop list="#byName#" index="i">
		   <cfoutput>  <a href="#cgi.script_name#?pg=#i#" class="badge" >#i#</a></cfoutput>
		</cfloop>
		<table border="0" cellpadding="5px" class="table table-bordered table-striped">
			<thead>
			<tr>
			<th>Email Address</th>
			<th class="center">
				<cfoutput>
					<button type="button" id="btnOpenDialog" class="btn btn-danger btn-xs" title="Purge All Contacts" onclick="conf()">Purge</button>
				</cfoutput>
			</th>
			</tr>
			</thead>
			<cfoutput query="MailerSubscribers">
			<tr>
			<td>#Email#</td>
			<td class="center"><a href="manage.cfm?key=#Application.key#&section=subscribers&action=remove&ID=#ID#&transacted=#listlast(cgi.script_name,'/\')#"><span class="glyphicon glyphicon-trash" style="color: red; font-size: 20;" title="Delete"></span></a></td>
			</tr>
			</cfoutput>
		</table>
	</div>
</div>


<cfif isDefined("Form.Export") >

<cfquery name="ContactExport" datasource="#Application.DSN#">
     SELECT *
     FROM mailersubscribers
     ORDER BY Email
</cfquery>

<!--- Required for CSV export to function properly --->
<cfsetting enablecfoutputonly="yes">

<!--- Use a comma for a field delimitter, Excel will open CSV files --->
<cfset delim = 44> 

<cfcontent type="text/csv">
<cfheader name="Content-Disposition" value="attachment; filename=SatyrMail-Contacts-#DateFormat(Now())##Hour(Now())##Minute(Now())##Second(Now())#.csv">

<!--- Output Column Headers --->
<cfoutput>Email #chr(delim)#</cfoutput>
<cfoutput>#chr(13)#</cfoutput> <!--- line break after column header --->

<!--- Spill out data from a query --->
<cfloop query="ContactExport">
    <cfoutput>#ucase(email)# #chr(delim)#</cfoutput>
    <cfoutput>#chr(13)#</cfoutput>
</cfloop>

</cfif>
