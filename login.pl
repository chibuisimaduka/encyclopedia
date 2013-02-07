print "<form class='login' method='post'>";

  if($status){
		print "<span class='login_er'>".$status."</span>";
	}

print "Email: <input type='text' name='email'><br />
  <input type='hidden' name='request_login' value='1'>
  Hasło: <input type='password' name='pass'><br />
  <input type='submit' value='Loguj!'>
</form>";