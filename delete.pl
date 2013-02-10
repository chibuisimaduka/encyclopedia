if(!$force){
  print "\nMatrix has you...";
}else{
  
  if($uris[2] == "yes"){
  
    #  Deletion of word given by id from $_GET
    my $q1 = $db->prepare("DELETE FROM words WHERE id='".$uris[3]."' ");
    #  Delete relation from all word
    my $q2 = $db->prepare("UPDATE words SET relation = replace(relation, '".$uris[3].",', '') ");
    $q1->execute();
    $q2->execute();
    print "
    <div class='deletion'>
      <div class='status-info success'>Pomyślnie usunięto słowo!</div>
      <div class='yesno'>
        <a class='ok' href='/'></a>
        <div class='clear'></div>
      </div>
      <div class='clear'></div>
    </div>";
  } else {
  
    #Before delete - question
    print "
    <div class='deletion'>
      <div class='status-info'>Czy na pewno chcesz usunąć słowo: <b>dsdas</b>?</div>
      <div class='yesno'>
        <a class='no' href='/'></a>
        <a class='yes' href='/d/yes/".$uris[2]."'></a>
        <div class='clear'></div>
      </div>
      <div class='clear'></div>
    </div>";
  }
} 1;