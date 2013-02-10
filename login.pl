if(!$force){
  print "\nMatrix has you...";
}else{

print "<div class='login'>";

  if($status){
		print "<div class='status-info $logout'>".$status."</div><div class='clear'></div>";
	}

print "<form class='login' method='post'><input type='hidden' name='request_login' value='1'>
         <table>
          <tr><td>Email: </td><td><input type='text' name='email'></td></tr>
          <tr><td>Hasło: </td><td><input type='password' name='pass'></td></tr>
          <tr><td colspan='2'><input type='submit' value=''></td></tr>
         </table>
</form></div>";
} 1;