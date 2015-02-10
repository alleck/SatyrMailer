<!---
Creating Co. : Hostek.com
Programmed by: Kaleb L.
Creation Date: 11/15/2014
--->

<cfif FileExists('./config.cfm')>

	<cfinclude template="header.cfm" >
	
		<cfquery datasource="#Application.DSN#" name="MailerStats">
			SELECT * FROM mailerstats
		</cfquery>
	
	<div class="wrapper">
		
		<!--- The output of statistics from the mailer database --->
		<cfoutput query="MailerStats">
			<div class="TemplatePanel">Templates Avalible<hr /><div class="statstext">#TemplateNumber#</div></div>
			<div class="SubscribedPanel">Subscribed Contacts<hr /><div class="statstext">
				<cfif #ContactNumber# gt 9999 AND #ContactNumber#lt 1000000>
					<cfset TrueContactsTotal = #ContactNumber# / 1000>
					#Left(TrueContactsTotal, 3)#K
				<cfelseif #ContactNumber# gt 999999 AND #ContactNumber# lt 1000000000>
					<cfset TrueContactsTotal = #ContactNumber# / 1000000>
					#Left(TrueContactsTotal, 3)#M			
				<cfelseif #ContactNumber# gt 999999999>
					1B+
				<cfelse>
					#ContactNumber#
				</cfif></div></div>
			<div class="MessagesPanel">Messages Sent<hr /><div class="statstext">
				<cfif #SentMessages# gt 9999 AND #SentMessages# lt 1000000>
					<cfset TrueMessageTotal = #SentMessages# / 1000>
					#Left(TrueMessagetotal, 3)#K
				<cfelseif #SentMessages# gt 999999 AND #SentMessages# lt 1000000000>
					<cfset TrueMessageTotal = #SentMessages# / 1000000>
					#Left(TrueMessagetotal, 3)#M			
				<cfelseif #SentMessages# gt 999999999>
					1B+
				<cfelse>
					#SentMessages#
				</cfif></div></div>
		</cfoutput>
	</div>
	
	<div>
		<cfoutput>
			
			<!--- Read the ./inc/inc_sub_css.cfm file for the CSS rules for the "Subscribe" tool --->
			<cffile action="Read"  
		            file="./inc/inc_sub_css.cfm"  
		            variable="readText">
		        
		        <!--- Set #scriptname# to the location of the scripts + 'subscribe.cfm' --->
		        <cfset scriptname = #REReplace(CGI.SCRIPT_NAME, 'index.cfm', 'subscribe.cfm')# />
	            
	            <table class="table" style="width: 800px; margin: 25px auto;">
		            <tr>
		            	<th colspan="2">
		            		<h3>CSS for Subscribe Menu</h3>
			            	<form action="manage.cfm?key=#Application.key#&section=inc_css&action=update&transacted=#listlast(cgi.script_name,'/\')#" method="post">
				            	<textarea name="inc_css" class="form-control" style="height: 200px;"><cfoutput>#readText#</cfoutput></textarea>
				            	<p class="center">
				            		<br />
				            		<input type="submit" class="btn btn-primary" name="save" value="Save" />
				            	</p>
			            	</form>
		            	</th>
	            	</tr>
		            
		            
		            <tr>
		            	<th>
		            	<h3>Preview</h3>
		            	<iframe src="subscribe.cfm" style="width: 400px; border: 0px; border-radius: 5px;"></iframe>
		            	</th>
		            	<th>
		            		<h3>HTML Code</h3>
<!--- Pre tags need to be left at this position, or else the HTML code will be askew --->
<pre>#HTMLEditFormat('<iframe
src="http://#CGI.SERVER_NAME#:#CGI.SERVER_PORT##scriptname#"
style="width: 400px;
	border: 0px;
	border-radius: 5px;">
</iframe>')#	
</pre>
			            </th>
		            </tr>
		            
		            </table>
	            
	     </cfoutput>
	     
	     
	</div>

<cfelse>

<cflocation url="install.cfm" >

</cfif>
