<%--
This page display top tweets from friends based on count it has been visited
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>
<%@ page import="com.google.appengine.api.datastore.Query.SortDirection" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="/css/tweet.css">
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
 <script type="text/javascript" src="/js/tweet.js"></script>
 <script> callme();</script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
<div class="topnav">
  <a href="tweet.jsp">TWEET</a>
  <a href="friendsTweets.jsp">FRIENDS</a>
  <a  id=toptweet href="toptweet.jsp">TOP-TWEET</a>
  <a href="#about"></a>
  <div id="fb-root"></div>
  <div align="right">
  <div class="fb-login-button" data-max-rows="1" data-size="medium"
   data-button-type="login_with" data-show-faces="false" data-auto-logout-link="true"  data-use-continue-as="true" scope="public_profile,email" onlogin="checkLoginState();"></div>
  </div>
</div>
<center><h1 style="color:MediumSeaGreen">Here are the top 10 tweets!!</h1></center>
</body>
</html>


<% 
//display top 10 tweets from datastore
	DatastoreService ds=DatastoreServiceFactory.getDatastoreService(); //Create instance of DataStore (ds)
	Entity e=new Entity("tweet");  //creates new entity called tweet 
	Query q=new Query("tweet").addSort("visited_count", SortDirection.DESCENDING); //Create query string for tweet based on descending order of tweets visited count
	PreparedQuery pq = ds.prepare(q); //send this query to datastore ds
	int count=0;
	//loop to display tweets till count value reaches from 0 to 9 (top 10)
	for (Entity result : pq.asIterable()) {
		if(count<10){
			  //out.println(result.getProperty("first_name")+" "+request.getParameter("name"));
			  String first_name = (String) result.getProperty("first_name"); //fetch first_name of user who posted tweet
			  String lastName = (String) result.getProperty("last_name"); //fetch last_name of user who posted tweet
			
			  String status = (String) result.getProperty("status"); //fetch status of user who posted tweet
			  Long id = (Long) result.getKey().getId(); //fetch id of user who posted tweet
			  String time = (String) result.getProperty("timestamp"); //fetch timestamp of the tweet
			  Long visited_count = (Long)((result.getProperty("visited_count"))); //fetch how many times the tweet was visited
%>
			  
			 <center><table>
			  <td><strong>User:</strong> <%= first_name+" "+lastName %> </td></tr> 
			  <tr><td><strong>Status:</strong> <%= status %></td></tr> 
			  <tr><td><strong>Posted at:</strong> <%=time %></td></tr> 
			  <tr><td><strong>#Visited:</strong> <%= visited_count %></td></tr> 
			  </table></center> 
			  
			  <br><hr>	<br>
			<%  Entity s=ds.get(KeyFactory.createKey("tweet", id)); 
			  s.setProperty("visited_count", visited_count+1); 
			  ds.put(s); //increment visited count and store it in the data store
			  count++; //increment count by 1
		}
	}
%>
