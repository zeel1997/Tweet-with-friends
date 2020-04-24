<%--this page displays tweets made by all friends--%>

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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
 <link rel="stylesheet" href="/css/tweet.css">
 <!--Code for client side google analytics tracking -->
 <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-153765665-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-153765665-1');
</script>
</head>
<body>
<div class="topnav">

  <a href="tweet.jsp">Tweet</a>
  <a href="friendsTweets.jsp">Friends</a>
  <a id=toptweet>Top Tweet</a>
  <div id="fb-root"></div>
  <div align="right">
  <div class="fb-login-button" data-max-rows="1" data-size="medium"
   data-button-type="login_with" data-show-faces="false" data-auto-logout-link="true"  data-use-continue-as="true" scope="public_profile,email" onlogin="checkLoginState();"></div>
  </div>
  </div>
<%
try{
	DatastoreService ds=DatastoreServiceFactory.getDatastoreService(); //Get the datastore services

Entity e=new Entity("tweet"); //create new entity tweet

//Key k=KeyFactory.createKey("tweet", request.getParameter("id"));
//Key k=KeyFactory.stringToKey(request.getParameter("id"));
//out.println(k);
//out.println(temp.getId());
//Filter filter = new FilterPredicate("ID/Name",FilterOperator.EQUAL,request.getParameter("id"));
//out.println(filter.toString());
Query q=new Query("tweet"); 
//out.println(q.toString());
PreparedQuery pq = ds.prepare(q); //PreparedQuery contains the methods for fetching query results from the datastore
long visited_count=0;
for (Entity result : pq.asIterable()) {
   	  String first_name = (String) result.getProperty("first_name"); //fetch user's friend's first name
	  String lastName = (String) result.getProperty("last_name"); //fetch user's friend's last name
	  String picture = (String) result.getProperty("profil_pic"); //fetch user's friend's profile picture
	  String status = (String) result.getProperty("status"); //fetch user's friend's status
	  Long id = (Long) result.getKey().getId(); //fetch user's friend's id
	  String time = (String) result.getProperty("timestamp"); //fetch user's friend's tweet's timestamp
	  visited_count = (Long)((result.getProperty("visited_count"))); //fetch visited count of user's friend's tweet
	  Key k= result.getKey();
	  if(id==Long.parseLong(request.getParameter("id"))){
	 // out.println(result.getKey().getId()+" "+first_name + " " + lastName + ", " + picture + " "+visited_count);
	  Entity s=ds.get(KeyFactory.createKey("tweet", id));
	  s.setProperty("visited_count", visited_count+1); // increment visited count by 1 and save it to instance s
	//  out.println("check"+s.getProperty("visited_count"));
	  ds.put(s); //save s in datastore
	  //print all the attributes of instance s
	  out.println("<h1>Status of "+ s.getProperty("first_name")+" "+s.getProperty("last_name")+"</h1>");
	  out.println("<table frame=box>");
	  out.println("<tr><td><div style="+"height: 50px; width:50px>"+picture+"</div><td>");
	  out.println("<td><div id=name>"+ first_name+" "+lastName +"</div></td>");
	  out.println("<tr><h3><div id=status> "+s.getProperty("first_name")+" said "+status +"</div></h3></tr>");
	  out.println("<tr><div id=postedate>Posted at:"+ time +"</div></tr>");
	  out.println("</table>");
	  }
	}
}catch(Exception e){
	out.println(e); //print error
}
%>
</body>
<script type="text/javascript">
console.log("validate");
</script>
</html>
