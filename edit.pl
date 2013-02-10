if(!$force){
  print "\nMatrix has you...";
}else{


#Get original data (to compare with existing word and display in h1)
$q = $db->prepare("SELECT * FROM words WHERE id='".@uris[2]."' ");
$q->execute();
$org = $q->fetchrow_hashref();
@relations = split(',',$org->{"relation"});


if($p->param('edit')){
  
  
  #Preparing variables from post  
  $edi->{"word"} = $p->param('word');
  $edi->{"description"} = $p->param('description');
	
	
	#Preparing Relations array (removing duplicates, becouse hash is always unique)
	@relations = split(',',$p->param('relation'));	
	my %hash   = map { $_ => 1 } @relations;
	@relations = keys %hash;
	
	
  #Delete each checked Relations
  if($p->param('dr')){
    foreach ($p->param('dr')) {
      my $i = $_;
      for (0..$#relations) {
        my $j = $relations[$_];
        if($j == $i) {$relations[$_] = 0;}
      }
    }
    $edi->{"relation"} = join(',', @relations);
  }
  
  
  #Start checking -> Validating exist of title and description
  if(($p->param('word')) && ($p->param('description'))) {
  
  
    #checking exsist word if diffrent from editing
		$q = $db->prepare("SELECT * FROM words WHERE (word LIKE '".$p->param('word')."') AND (id != '".$org->{"id"}."') ");
		$q->execute();
		my $res = $q->fetchrow_hashref();
		
		#Looking for the exists word -> protect for replace
		if($res->{"id"}) {
			print "<div class='status-info'>UWAGA: znalazłem już podobne słowo! &raquo; <a href='/w/".$res->{"id"}."/".$res->{"slug"}."'>".$res->{"word"}."</a></div><div class='clear'></div>";
		} else {

		
			#Service of relation words
			if($p->param('r_search')){
				#searching words to relation
				$q = $db->prepare("SELECT * FROM words WHERE word LIKE '".$p->param('r_word')."' AND id !='".@uris[2]."' ");
				$q->execute();
				$res2 = $q->fetchrow_hashref();
				#if found - putting to the array of relation
				if($res2->{"id"} != ""){
					push(@relations, $res2->{"id"});
				}
				$edi->{"relation"} = join(',', @relations);
				
			} else {
        
				#Updating data
				$q = $db->prepare("UPDATE words SET word='".$edi->{"word"}."', relation = REPLACE('".join(',', @relations).",', '0,', ''), description='".$edi->{"description"}."', slug='".mslug($edi->{"word"})."' WHERE id='".@uris[2]."' ");
				$q->execute();
				
				#Getting updated word to display in success alert.
				$q = $db->prepare("SELECT * FROM words WHERE id='".@uris[2]."' ");
				$q->execute();
				$res = $q->fetchrow_hashref();
				print "<div class='status-info success'><b>Aktualizacja powiodła się!</b> Przejdź na stronę słowa: <a href='/w/".$res->{"id"}."/".$res->{"slug"}."'>".$res->{"word"}."</a></div>";
				$edi->{"relation"} = join(',', @relations);
				#END updating
			}
			
		}
	}  else {
    #Display if word or description is empty
		print "<div class='status-info'>UWAGA: Jedno z pól nie zostało wypełnione!</div>";
	} 
} else {

#Getting current data of word if not sending changes (on start)
$q = $db->prepare("SELECT * FROM words WHERE id='".@uris[2]."' ");
$q->execute();
$edi = $q->fetchrow_hashref();
@relations = split(',',$edi->{"relation"});
}



##########################################################################
### Presentation layer
##########################################################################

print "<h1>Aktualizacja słowa: ".$org->{"word"}."</h1>";
print "<form method='post' class='wedit'>";
print "<input type='hidden' name='edit' value='1'>";
print "<input type='hidden' name='relation' value='".$edi->{"relation"}."'>";
print "Słowo:<br /><input type='text' style='font-weight: bold;' name='word' value='".$edi->{"word"}."'><br />";
print "Deskrypcja: <br /><textarea name='description' cols='60' rows='5'>".$edi->{"description"}."</textarea><br />";
print "Wybrane relacje: ";


#Display selected relations
if(@relations){
  $q = $db->prepare("SELECT * FROM words WHERE id IN (".join(',', @relations).") ");
  $q->execute();
  while (my $res = $q->fetchrow_hashref()){
    print "<input type='checkbox' name='dr' value='".$res->{'id'}."'> <a href='/w/".$res->{'id'}."/".$res->{'slug'}."'>".$res->{'word'}."</a> ";
  }
}

#Searcher of relations
print "
  <div class='clear'></div>
  
  <br />
  Wyszukaj słowo do powiązania:<br />
  <input type='text' name='r_word'><input type='submit' name='r_search' value=' '>
  <div class='clear'></div>
  
  <div class='relation-info'>INFO: Zaznaczając dane słowo powiązane, po kliknięciu \"Wprowadź zmiany \" lub \"Szukaj\" Zostanie on usunięty!</div>
  <div class='clear'></div>
  
  <div class='action_but'>
    <input type='submit' name='wedit' value=' '>
    <div class='clear'></div>
  </div>
  
</form>";


} 1;