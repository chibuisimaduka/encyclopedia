#Deletion of word given by id from $_GET

  my $q1 = $db->prepare("DELETE FROM words WHERE id='".$p->param('wid')."' ");
  my $q2 = $db->prepare("UPDATE words SET relation = replace(relation, '".$p->param('wid').",', '') ");
  $q1->execute();
  $q2->execute();

  print "Pomyślnie usunięto wpis!";
  print "<br /><a href='/'>&laquo;Powrót do wyszukiwarki</a>";