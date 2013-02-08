# Main

print "<div class='search'>
<form method='post' action='/'>
  <input type='text' name='search'>
  <input type='submit' value='Szukaj'>
</form>
</div>";


print "<div class='search_result'><ul>";
if($p->param('search')) {&req_search;} else {print "Kliknij wyszukiwarkę aby zacząć!";} # check $posts for login
print "</ul></div>";

print "<div class='clear'></div><form method='post'><input type='hidden' name='request_logout' value='1'><input type='submit' value='Logout'></form> <a href='/a/new'>Dodaj słowo +</a>";