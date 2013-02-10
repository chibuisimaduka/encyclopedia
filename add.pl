if(!$force){
  print "\nMatrix has you...";
}else{

if($p->param('adding')){
	
	
	#Preparing Relations array
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
  }
  
  
  #Start checking -> Validating exist of title and description
  if(($p->param('word')) && ($p->param('description'))) {
		
		
		#checking exsist word in database
		$q = $db->prepare("SELECT * FROM words WHERE (word LIKE '".$p->param('word')."') ");
		$q->execute();
		my $res = $q->fetchrow_hashref();
		
		
		if($res->{"id"}) {
			print "<div class='status-info'>UWAGA: znalazłem już podobne słowo! &raquo; <a href='/w/".$res->{"id"}."/".$res->{"slug"}."'>".$res->{"word"}."</a></div><div class='clear'></div>";;
		} else {
		
			#Service of relation words
			if($p->param('r_search')){
				#searching words to relation
				$q = $db->prepare("SELECT * FROM words WHERE word LIKE '".$p->param('r_word')."' ");
				$q->execute();
				$res2 = $q->fetchrow_hashref();
				#if found - putting to the array of relation
				if($res2->{"id"} != ""){
					push(@relations, $res2->{"id"});
				}
				
			} else {
				#Relation prepared, data valid, insertion ready
        $q = $db->prepare("INSERT INTO words (word,description,slug,relation) VALUES ('".$p->param('word')."','".$p->param('description')."','".mslug($p->param('word'))."','".join(',', @relations).",') ");
				$q->execute();
				#Correction data by mysql - deleting unwanted 0's
				$q = $db->prepare("UPDATE words SET relation = REPLACE('".join(',', @relations).",', '0,', '') WHERE id=LAST_INSERT_ID() ");
				$q->execute();
				#Getting new word to display in success alert.
				$q = $db->prepare("SELECT * FROM words WHERE id=LAST_INSERT_ID() ");
				$q->execute();
				$res = $q->fetchrow_hashref();
				print "<div class='status-info success'><b>Słowo zostało dodane!</b> Zobaczysz je tutaj: <a href='/w/".$res->{"id"}."/".$res->{"slug"}."'>".$res->{"word"}."</a></div>";
				#END insertion
			}
		}
	} else {
    #Display if word or description is empty
		print "<div class='status-info'>UWAGA: Jedno z pól nie zostało wypełnione!</div>";
	}
}


##########################################################################
### Presentation layer
##########################################################################

print "<h1>Dodaj nowe słowo</h1>";
print "<form method='post' class='wadd'>";
print "<input type='hidden' name='adding' value='1'>";
print "<input type='hidden' name='relation' value='".join(',', @relations)."'>";
print "Słowo:<br /><input type='text' name='word' value='".$p->param('word')."'><br />";
print "Deskrypcja: <br /><textarea name='description' cols='60' rows='5'>".$p->param('description')."</textarea><br />";
print "Wybrane relacje: ";


#Display selected relations
if(@relations){
  $q = $db->prepare("SELECT * FROM words WHERE id IN (".join(',', @relations).") ");
  $q->execute();
  while (my $res = $q->fetchrow_hashref()){
    print "<input type='checkbox' name='dr' value='".$res->{'id'}."'> <a href='/w/".$res->{'id'}."/".$res->{'slug'}."'>".$res->{'word'}."</a> | ";
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
    <input type='submit' name='wadd' value=' '>
    <div class='clear'></div>
  </div>
  
</form>";


} 1;