# Overall functions for Encyclopedia project

# Libs
use DBI;
use CGI;
use Switch;
use CGI::Session;
use CGI qw/:standard/;

# Global
%data = ();

# Class Definitions
$p = new CGI;

$data{"email"} = $p->param('email');
$data{"pass"} = $p->param('pass');

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

  $tmp = $db->prepare("SET NAMES 'utf8'");
  $tmp->execute();
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

#Manage includes (by $_GET from .htaccess)
sub includer{
  
  switch ($p->param('act')) {
    case "w"  {require "word.pl";}
    case "e"  {require "edit.pl";}
    case "d"  {require "delete.pl";}
    case "a"  {require "add.pl";}
    else     {require "main.pl";}
  }
  
}

#Start session after valid data
sub start_ses {
	$session = new CGI::Session(undef, undef, {Directory=>"/tmp"});
	$session->param("id", $_[0]);
	$session->param("user", $_[1]);

  my $cookie = cookie(
	-name=>'encyclopedia',
	value=>$session->id,
	-expires=>'+1h');
  print header(-cookie=>$cookie, -charset=>"utf-8");

	$logged = 1;
}

#Validating entered data
sub req_login {
		
		$q = $db->prepare("SELECT id, CONCAT(name,' ',surname) as user FROM users WHERE email='".$data{"email"}."' AND pass='".mhash($data{"pass"})."' ");
		$q->execute();
		my $r = $q->fetchrow_hashref();
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

#Searcher
sub req_search {
  $q = $db->prepare("SELECT * FROM words WHERE (word LIKE '%".$p->param('search')."%') OR (description LIKE '%".$p->param('search')."%') ");
  $q->execute();
  while (my $res = $q->fetchrow_hashref()){
    print "<li><div class='cont'><a href='/w/".$res->{'id'}."/".$res->{'slug'}."'><b>".$res->{'word'}."</b> - <i>".$res->{'description'}."</i></a></div><div class='func'><a href='/e/".$res->{'id'}."/".$res->{'slug'}."'>edytuj</a> | <a href='/d/".$res->{'id'}."'>usuń</a></div><div class='clear'></div></li>";
  }
}









1;