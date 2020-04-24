<%@page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@page import="com.google.appengine.api.datastore.Query"%>
<%@page import="com.google.appengine.api.datastore.Entity"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<html>
<head>
<link rel="stylesheet" href="/css/tweet.css">
<script type="text/javascript" src="/js/tweet.js"></script>
<script> callme();</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-164498568-2"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-164498568-2');
</script>
</head>
<body>
<form id="storegae" action="GaeStore" method="get" name="storegae"  >
<div class="topnav">
		<a href="tweet.jsp">TWEET</a> 
		<a href="friendsTweets.jsp">FRIENDS</a> 
		<a id=toptweet href="toptweet.jsp">TOP-TWEET</a>
		<div id="fb-root"></div>
		<div align="right">
			<div class="fb-login-button" data-max-rows="1" data-size="medium"
				data-button-type="login_with" data-show-faces="false"
				data-auto-logout-link="true" data-use-continue-as="true"
				scope="public_profile,email" onlogin="checkLoginState();"></div>
		</div>
	</div>
<td><center><textarea id="text_content" name="text_content" class="textarea"
							placeholder="Enter your tweet!!" ></textarea></center></td>
<input type=hidden id=user_id name= user_id />
<input type=hidden id=first_name name=first_name  />
<input type=hidden id=last_name name=last_name  />
<input type=hidden id=picture name=picture  />
<td><center><input type="submit" id=submit name=save class="button"/></center></td>
</form>

<form action="getmytweet.jsp" method="GET">
<center>
<input type=hidden id=user_ids name=user_ids  />
<br><input type="submit"  class="button" value="Click here for the tweets!! " name="view_tweet" />
</center></form>

</body>
</html>

