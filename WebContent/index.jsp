<%@ page import="com.google.appengine.api.datastore.*" %>
<%@ page import="java.util.stream.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>

<body>
    <%
Cookie[] cookies = request.getCookies();

String uid = null;
if (cookies != null) {
	uid = Arrays.stream(cookies)
	    .filter(cookie -> cookie.getName().equals("uid"))
	    .map(cookie -> cookie.getValue())
	    .collect(Collectors.reducing((a, b) -> null))
	    .orElse("");
}

if (uid == null || "".equals(uid)) {
    %>
    <div id="status"></div>
    <input id="login" type="submit" value="Login"></input>
    <hr />
    <%
} else {
    %>
    Your ID: <%= uid %>
    <input id="logout" type="submit" value="Logout"></input>
    <hr />

    <%
}
    %>

    <input id="message" type="text" value="Testing Facebook JS SDK"></input>
    <input id="post" type="submit" value="Post"></input>
    <input id="share" type="submit" value="share"></input>

    <h1>Hello JSP and Servlet!</h1>
    <form action="indexServlet" method="post">
        Enter your name: <input type="text" name="yourName" size="20">
        <input type="submit" value="Call Servlet" />
    </form>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
    <script>
        function set_cookie(name, value) {
            document.cookie = name + '=' + value + '; Path=/;';
        }

        function delete_cookie(name) {
            document.cookie = name + '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
        }

        function send_welcome() {
            FB.api('/me', function (response) {
                $('#status').text('Good to see you, ' + response.name + '.');

                set_cookie('uid', response.id);
                location.reload();
            });
        }

        $('#login').click(function () {
            FB.login(function (response) {
                if (response.authResponse) {
                    send_welcome();
                } else {
                    $('#status').text('User cancelled login or did not fully authorize.');
                }
            });
        });

        $('#logout').click(function () {
            delete_cookie('uid');
            location.reload();
        });

        function checkLoginStatus() {
            FB.getLoginStatus(function (response) {
                if (response.status === 'connected') {
                    // The user is logged in and has authenticated your
                    // app, and response.authResponse supplies
                    // the user's ID, a valid access token, a signed
                    // request, and the time the access token 
                    // and signed request each expire.
                    var uid = response.authResponse.userID;
                    var accessToken = response.authResponse.accessToken;

                    $('#status').text('connected');
                    send_welcome();
                } else if (response.status === 'not_authorized') {
                    // The user hasn't authorized your application.  They
                    // must click the Login button, or you must call FB.login
                    // in response to a user gesture, to launch a login dialog.
                    $('#status').text('not authorized');
                } else {
                    // The user isn't logged in to Facebook. You can launch a
                    // login dialog with a user gesture, but the user may have
                    // to log in to Facebook before authorizing your application.
                    $('#status').text('need login');
                }
            });
        }

        $(document).ready(function () {
            $.ajaxSetup({
                cache: true
            });
            $.getScript('https://connect.facebook.net/en_US/sdk.js', function () {
                FB.init({
                    appId: '260407591800240',
                    version: 'v2.7', // or v2.1, v2.2, v2.3, ...
                    cookie: true,
                });

                checkLoginStatus();
            });
        });
    </script>
    <script>
    </script>
</body>

</html>