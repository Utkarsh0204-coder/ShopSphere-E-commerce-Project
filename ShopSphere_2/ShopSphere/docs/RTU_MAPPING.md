# RTU Mapping
Swing → swing-admin
JDBC/MySQL → web DAO layer
java.net Socket/ServerSocket → network
Client/Server → Inventory client/server
Serialization → Product implements Serializable in network
RMI → rmi/InventoryService
RMI Registry → Naming.rebind / Naming.lookup
J2EE/N-tier → JSP → Servlet → Service → DAO → JDBC → MySQL
HTTP/Web container → Tomcat 11
Servlets → controller package
Sessions → HttpSession
Filters → AuthenticationFilter/AdminFilter
Listener → AppListener
JSP/EL/JSTL → JSP pages and c:forEach
JSP fragments → fragments/header/navbar/footer.jsp
Tag file → WEB-INF/tags/productCard.tag
Internationalization/JNDI/URLConnection → keep as syllabus demonstration modules when extending the core project.
