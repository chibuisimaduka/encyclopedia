if(!$force){
  print "\nMatrix has you...";
}else{

my $q = $db->prepare("SELECT * FROM words WHERE id='".$uris[2]."' ");
$q->execute();
$word = $q->fetchrow_hashref();

my $qp = $db->prepare("SELECT * FROM words WHERE id IN (".substr($word->{'relation'},0,-1).") ");
$qp->execute();
  
  
if($word->{"id"}){
  print "<div class='word'>";
  print "<a href='/a/new' class='add' title='Dodaj nowe słowo'></a><h1>".$word->{"word"}."</h1>";
  print "<a title='Edytuj' class='edit' href='/e/".$uris[2]."/".$uris[3]."'></a><a title='Usuń' class='del' href='/d/".$uris[2]."'></a><div class='clear'></div>";
  print "<h3>".$word->{"description"}."</h3>";
  print "Wyniki powiązane: ";
  
  while (my $res = $qp->fetchrow_hashref())
  {
    print "<a href='/w/".$res->{'id'}."/".$res->{'slug'}."'>".$res->{'word'}."</a> | ";
  }
  
} else {
  print "Brak słowa!";
}

print "</div>";

} 1;