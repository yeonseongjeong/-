<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Test</title></head>
<body>
    <p>Server Name: ${pageContext.request.serverName}</p>
    <p>Context Path: ${pageContext.request.contextPath}</p>
    <p>Request URI: ${pageContext.request.requestURI}</p>
    <p>Scheme: ${pageContext.request.scheme}</p>
</body>
</html>
