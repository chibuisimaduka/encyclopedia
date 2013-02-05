# Overall functions for Encyclopedia project

# Libs
use DBI;
use CGI;
use CGI::Session;

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

sub checklogin {
  if($data{"email"}) {
    # 1:Validating access
    # 2:Initiate sesion or return fault
    $status = "trying to connect";
  }
}

1;