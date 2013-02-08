my $q = $db->prepare("SELECT * FROM words WHERE id='".$p->param('wid')."' ");
$q->execute();
$word = $q->fetchrow_hashref();

my $qp = $db->prepare("SELECT * FROM words WHERE id IN (".substr($word->{'relation'},0,-1).") ");
$qp->execute();
  
  
if($word->{"id"}){
  print "<h1>".$word->{"word"}."</h1>";
  print "<h3>".$word->{"description"}."</h3>";
  print "Wyniki powiązane: ";
  
  while (my $res = $qp->fetchrow_hashref())
  {
    print "<a href='/w/".$res->{'id'}."/".$res->{'slug'}."'>".$res->{'word'}."</a> | ";
  }
  
} else {
  print "Brak słowa!";
}


print "<br />";
print "=" x 130;
print "<br /><a href='/'>&laquo;Powrót do wyszukiwarki</a>";