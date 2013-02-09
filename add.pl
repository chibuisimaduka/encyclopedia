if($p->param('adding')){
	
	#Preparing Relations array
	$tmp_relation = $p->param('relation');
	@relations = split(',',$tmp_relation);	
	my %hash   = map { $_ => 1 } @relations;
	@relations = keys %hash;
	
  #Delete each checked Relations
  if($p->param('dr')){
    my @deletions = $p->param('dr');
    foreach (@deletions) {
      my $i = $_;
      for (0..$#relations) {
        my $j = $relations[$_];
        if($j == $i) {$relations[$_] = 0;}
      }
    }
  }
  
  if(($p->param('word')) && ($p->param('description'))) {
		
		$q = $db->prepare("SELECT * FROM words WHERE (word LIKE '".$p->param('word')."') ");
		$q->execute();
		my $res = $q->fetchrow_hashref();
		
		if($res->{"id"}) {
			print "Warning: znalazłem już podobne słowo! -> <a href='/w/".$res->{"id"}."/".$res->{"slug"}."'>".$res->{"word"}."</a>";
		} else {
			if($p->param('r_search')){
				#searching words to relation
				$q = $db->prepare("SELECT * FROM words WHERE word LIKE '".$p->param('r_word')."' ");
				$q->execute();
				$res2 = $q->fetchrow_hashref();
				if($res2->{"id"} != ""){
					push(@relations, $res2->{"id"});
				}
				
			} else {
				#Relation prepared, insertion ready
				$tmp = $db->prepare("SET NAMES 'utf8'");
        $tmp->execute();
				$q = $db->prepare("INSERT INTO words (word,description,slug,relation) VALUES ('".$p->param('word')."','".$p->param('description')."','".mslug($p->param('word'))."','".join(',', @relations).",') ");
				print "INSERT INTO words (word,description,slug,relation) VALUES ('".$p->param('word')."','".$p->param('description')."','".mslug($p->param('word'))."','".join(',', @relations).",') ";
				$q->execute();
				$q = $db->prepare("UPDATE words SET relation = REPLACE('".join(',', @relations).",', '0,', '') WHERE id=LAST_INSERT_ID() ");
				$q->execute();
				$q = $db->prepare("SELECT * FROM words WHERE (word LIKE '".$p->param('word')."') ");
				$q->execute();
				$res1 = $q->fetchrow_hashref();
				print "<b>Słowo zostało dodane!</b> Zobaczysz je tutaj: <a href='/w/".$res1->{"id"}."/".$res1->{"slug"}."'>".$res1->{"word"}."</a>";
			}
		}
	} else {
		print "Warning: Wybacz, jedno z pól nie zostało wypełnione";
	}
}


#@relations = split(',',$tmp_relation);	
#my %hash   = map { $_ => 1 } @relations;
#@relations = keys %hash;

print "<h1>Dodaj nowe słowo</h1>";

print "<form method='post'>";
print "<input type='hidden' name='adding' value='1'>";
print "<input type='hidden' name='relation' value='".join(',', @relations)."'>";
print "<input type='text' name='word' value='".$p->param('word')."'><br />";
print "<textarea name='description' cols='60' rows='5'>".$p->param('description')."</textarea><br />";
print "Wybrane relacje: ";


my $qr = $db->prepare("SELECT * FROM words WHERE id IN (".join(',', @relations).") ");
$qr->execute();
while (my $res = $qr->fetchrow_hashref()){
	print "<input type='checkbox' name='dr' value='".$res->{'id'}."'> <a href='/w/".$res->{'id'}."/".$res->{'slug'}."'>".$res->{'word'}."</a> | ";
}

print "<br /><input type='text' name='r_word'><input type='submit' name='r_search' value='Szukaj Relacji'>";

print "<input type='submit' value='Dodaj pozycję'>";
print "</form><br><br>";

print "<div><a href='/'>&laquo;Powróć do wyszukiwarki</a></div>";