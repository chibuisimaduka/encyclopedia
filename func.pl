# Overall functions for Encyclopedia project

# Libs
use DBI;
use CGI;
use CGI::Session;
use CGI qw/:standard/;

# Global
%data = ();

# Class Definitions
$p = new CGI;

$data{"email"} = $p->param('email');
$data{"pass"} = $p->param('pass');

#print $data{"email"};

#############################################################################

# Connect to database
sub connect {
  $user ="iversopro9";
  $password ="encyclopedia789";
  $database ="iversopro9";
  $hostname ="localhost";
  $driver = "mysql";
  $port ="3306";
  $conf = "DBI:$driver:database=$database;host=$hostname;port=$port";
  
  $db = DBI->connect($conf, $user, $password);
}

#Make hash
sub mhash {
	use Digest::SHA qw(sha1_hex);
	return sha1_hex("sol".$_[0]."los");
}

# Check is logged
sub checklogged {
	my $rc = cookie('encyclopedia');
	$session = new CGI::Session(undef, $rc, {Directory=>"/tmp"});
	if($session->param("id")){
		$logged = 1;
	} else {
		$logged = 0;
		$session->delete();
	}
}

#Start session after valid data
sub start_ses {
	$session = new CGI::Session(undef, undef, {Directory=>"/tmp"});
	$session->param("id", $_[0]);
	$session->param("user", $_[1]);
	$session->flush();
	
	my $cookie = cookie(
	-name=>'encyclopedia',
	value=>$session->id,
	-expires=>'+1h');
print header(-cookie=>$cookie);
	
	$logged = 1;
}

#Validating entered data
sub req_login {
		
		$q = $db->prepare("SELECT id, CONCAT(name,' ',surname) as user FROM users WHERE email='".$data{"email"}."' AND pass='".mhash($data{"pass"})."' ");
		$q->execute();
		$r = $q->fetchrow_hashref();
		if($r->{"id"}){
			start_ses($r->{"id"},$r->{"user"});
		} else {
			$status = "Zły login / hasło!";
		}
		$q->finish();
		
}

#Logoff
sub req_logout {
	$session->delete();
	$status = "Wylogowano";
	$logged = 0;
}

1;