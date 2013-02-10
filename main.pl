if(!$force){
  print "\nMatrix has you...";
}else{

# Main

print "<div class='search'>
<form method='post' action='/'>
  <input type='text' name='search' value='".$p->param("search")."'>
  <div class='but_wrapper'>
    <input type='submit' value=''>
    <a href='/a/new'></a>
    <div class='clear'></div>
  </div>
</form>
</div>";


&req_search; # check $posts for login


print "<div class='clear'></div>";

} 1;