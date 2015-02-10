component {
	this.Name = "SatyrMailer";
	this.sessionManagement = "True";
	this.sessionTimeout = "#createtimespan(0,0,15,0)#";
	
	
	if (structKeyExists( url, "killSession" )) {
		sessionInvalidate();	
	}
	
}
