if(!$force){
  print "\nMatrix has you...";
}else{
  
  #Deletion of word given by id from $_GET
  my $q1 = $db->prepare("DELETE FROM words WHERE id='".$p->param('wid')."' ");
  #Delete relation from all word
  my $q2 = $db->prepare("UPDATE words SET relation = replace(relation, '".$p->param('wid').",', '') ");
  $q1->execute();
  $q2->execute();

  print "Pomyślnie usunięto wpis!";
  print "<br /><a href='/'>&laquo;Powrót do wyszukiwarki</a>";
} 1;