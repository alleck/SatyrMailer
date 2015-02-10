<!---
Creating Co. : Hostek.com
Programmed by: Kaleb L.
Creation Date: 11/15/2014
--->

<!---excerpt from login.cfm--->
<link href='http://fonts.googleapis.com/css?family=Lobster|Titillium+Web:400,300,600,700' rel='stylesheet' type='text/css'>

<!--- Ensure that the headers expire from logout --->
<cfheader name="expires" value="#getHttpTimeString(now())#"> 
<cfheader name="pragma" value="no-cache"> 
<cfheader name="cache-control" value="no-cache, no-store, must-revalidate"> 

<!--- Bootstrap CSS --->
<link rel="stylesheet" href="./css/bootstrap.min.css">

<style type="text/css">

	.logo {
		font-size: 40px;
		padding: 0px;
		margin: 0px 0px 10px 0px;
		font-style: oblique;
		color: #FF890A;
		text-shadow: 2px 2px #5c5c5c;
		font-family: 'Lobster', cursive;
	}
	body {
		font-family: 'Open Sans Condensed', sans-serif;
		font-weight: 700;
	}
	
	.loginFrame {
		margin: 30% auto auto auto;
		background-color: white;
		z-index: 1;
		width: 20%;
		min-width: 275px;
		padding: 10px;
		-webkit-border-radius: 5px;
		-moz-border-radius: 5px;
		border-radius: 5px;
		border: outset;
		box-shadow: 10px 10px 5px #555;
		box-sizing: initial;
	 }
	 
	 table {
	 	border-spacing: 5px;
		border-collapse: initial;
	 }
	 
	 
	 .center {
	 	text-align: center;
	 }

</style>


<div class="loginFrame">
	
	<form action="security.cfm" method="post">
	
		<table cellpadding="5px" style="
			margin: 0% auto;
			background-color: white;
			z-index: 1;">
		
		<thead><th colspan="2"><h1 class="logo center">SatyrMailer</h1></th></thead>
		<tbody>
		<tr><td><span class="glyphicon glyphicon-user"></span>&nbsp;</td><td><input class="form-control" type="text" name="uid"></td></tr>
		<tr><td><span class="glyphicon glyphicon-lock"></span></td><td><input class="form-control" type="password" name="pwd"></td></tr>
		<tr><td colspan="2" class="center"><input type="submit" value="Login" class="btn btn-warning" onkeypress="submitOnEnter(this, event);"></td></tr>
		</tbody>
		</table>
	</form>

</div>

<script type="text/javascript">
    function submitOnEnter(inputElement, event) {
        if (event.keyCode == 13) { // No need to do browser specific checks. It is always 13.
            inputElement.form.submit();
        }
    }
</script>