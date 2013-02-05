print "\n";

#Start includes
require "func.pl";

#Test auth
$logged = undef;

#Start initializations
&connect; #connect to database
&checklogin;

print "<!DOCTYPE html>
<html lang='pl'>

<head>
	<meta charset='utf-8' />
	<meta name='author' content='' />
	<meta name='description' content='' />
	<meta name='keywords' content='' />

	<!-- CSS -->
	<link rel='stylesheet' href='style.css' type='text/css' />
	<!--. CSS -->

	<title>Encyclopedia project</title>

</head>";

print "<body>";

# Warunek zalogowania, if NOT - display form
if($logged) {require "main.pl";}
else {require "login.pl";}

print "</div></body></html>";