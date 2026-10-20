# ShopSphere — RTU Advanced Java Lab Project

ShopSphere is a Maven multi-module Java project with a JSP/Servlet e-commerce web application, MySQL/JDBC DAO layer, a TCP socket demo, an RMI demo, and a Swing admin demo.

## Requirements
- JDK 17 or later (JDK 17 is a safe baseline)
- Apache Maven 3.9+
- MySQL 8.x running locally
- Apache Tomcat **10.1.x** for this version (Servlet 6.0 / JSP 3.1)

## 1. Configure MySQL
1. Open MySQL Workbench and connect to your local MySQL server.
2. Open and execute `database/shopsphere.sql`. It creates the `shopsphere` schema and demo records. It does not drop existing tables; duplicate seeded users, categories, and products are ignored on fresh schemas with the included unique keys.
3. Set your MySQL credentials in the same Windows account that launches Tomcat. In PowerShell, for the current terminal session:

```powershell
$env:SHOPSPHERE_DB_USER = "root"
$env:SHOPSPHERE_DB_PASSWORD = "YOUR_MYSQL_PASSWORD"
```

Optionally set `SHOPSPHERE_DB_URL` if your database is not at `localhost:3306/shopsphere`. Do not commit real passwords to source control. If Tomcat is installed as a Windows service, configure these environment variables for that service/account and restart it.

## 2. Build the project
From the folder containing the top-level `pom.xml`:

```powershell
mvn install
```

The web archive is created at `web/target/shopsphere.war`.

## 3. Deploy to Tomcat 10.1
1. Stop Tomcat.
2. Back up and remove the old `webapps/shopsphere` folder and old `webapps/shopsphere.war`.
3. Copy `web/target/shopsphere.war` into Tomcat's `webapps` folder.
4. Start Tomcat and wait for deployment to finish.
5. Open `http://localhost:8080/shopsphere/`.
6. If styles still look stale, press `Ctrl+F5`; this version uses a cache-busted stylesheet URL.

Use the same Tomcat installation whose `bin` and `webapps` folders you are managing. Do not mix Tomcat 10.1 and Tomcat 11 deployments.

## Demo accounts
The SQL seed creates `admin@shopsphere.com` / `admin123` and `user@shopsphere.com` / `user123`. These are for a local classroom demo only; change them before any public deployment.

## Included web flows
- Home page and product catalogue
- Search, category filtering and client-side sorting
- Product detail page
- Registration and login
- Session cart with quantity updates and item removal
- Demo checkout using Cash on Delivery (no real payment provider)
- Order history
- Admin dashboard view

## Troubleshooting
- **CSS is plain/missing:** open `http://localhost:8080/shopsphere/css/style.css?v=20261003-fixed`. If it returns 404, redeploy the new WAR. If it shows CSS text, the file is being served; refresh with Ctrl+F5.
- **Database access denied:** set `SHOPSPHERE_DB_USER` and `SHOPSPHERE_DB_PASSWORD` correctly before launching Tomcat.
- **No products:** verify the SQL script ran in the `shopsphere` schema and check `SELECT COUNT(*) FROM products;`.
- **HTTP 500:** inspect Tomcat's `logs` folder for the first `Caused by` line.

## Project modules
- `web/` — Servlet/JSP/JSTL + JDBC web application
- `network/` — TCP socket inventory demo
- `rmi/` — Java RMI demo
- `swing-admin/` — Swing admin client demo
- `database/` — SQL schema and seed data


## Product detail expansion (updated)
The product detail page now displays product-specific highlights and a specification table for each catalogue item. The details are derived from the product name/category, so the existing database schema and product records do not need to be migrated. The page also explains where delivery estimates and return terms are confirmed. Exact dimensions, materials, warranties and ratings are not invented when the database does not store them.

### Apply the updated source
From this project root, run `mvn install` to rebuild all modules. Deploy the newly generated `web/target/shopsphere.war` to your Tomcat `webapps` folder and restart/reload the application. If your MySQL database already exists, you do not need to re-import `database/shopsphere.sql` just for these product-detail changes.
