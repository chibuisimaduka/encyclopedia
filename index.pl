#Start includes
require "func.pl";

#Start initializations
&connect; #connect to database
&checklogged; #checking sess login;

if($p->param('request_logout')) {&req_logout}; # check $posts for logout
if($p->param('request_login')) {&req_login}; # check $posts for login

print "\n";
print "<!DOCTYPE html>
<html lang='pl'>

<head>
	<meta charset='utf-8' />
	<meta name='author' content='' />
	<meta name='description' content='' />
	<meta name='keywords' content='' />

	<!-- CSS -->
	<link rel='stylesheet' href='/style.css' type='text/css' />
	<!--. CSS -->

	<title>Encyclopedia project</title>

</head>";

print "<body>";

print "<div class='wrapper'>";

#Condition to showing main or login form
if($logged) {&includer;}
else {require "login.pl";}

print "</div></body></html>";

$db->disconnect();