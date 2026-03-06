# FunFit — Zumba Management System
### A-Z Backend & Database Development Phase-End Project

A full-stack Java web application to manage **Zumba participants and batches**.  
Built with: **Java Servlets · JSP · JDBC · MySQL · Maven · Apache Tomcat**

---

## 📁 Project Structure

```
FunFitProject/
├── pom.xml                          ← Maven build config + dependencies
├── database_setup.sql               ← MySQL schema + sample data
│
└── src/
    └── main/
        ├── java/
        │   └── com/gms/
        │       ├── model/
        │       │   ├── Batch.java           ← Batch POJO
        │       │   └── Participant.java      ← Participant POJO
        │       ├── dao/
        │       │   ├── DAO.java             ← Generic DAO interface
        │       │   ├── DBConnection.java    ← JDBC connection util
        │       │   ├── BatchDAO.java        ← Batch CRUD operations
        │       │   └── ParticipantDAO.java  ← Participant CRUD + getByBatch()
        │       ├── repository/
        │       │   └── GymRepository.java   ← Facade layer (used by Servlets/JSP)
        │       └── controller/
        │           ├── BatchController.java       ← Servlet for Batch
        │           └── ParticipantController.java  ← Servlet for Participant
        │
        └── webapp/
            ├── index.html                 ← Dashboard / Home
            ├── add-batch.html             ← Add batch form
            ├── add-participant.html       ← Enroll participant form
            ├── update-batch.html          ← Update batch form
            ├── update-participant.html    ← Update participant form
            ├── css/
            │   └── style.css              ← Global styles
            ├── jsp/
            │   ├── listBatches.jsp            ← View all batches + delete
            │   ├── listParticipants.jsp        ← View all participants + delete
            │   └── participantsByBatch.jsp     ← Query by batch ID
            └── WEB-INF/
                └── web.xml                ← Servlet config
```

---

## ⚙️ Prerequisites

| Tool | Version |
|------|---------|
| Java (JDK) | 11+ |
| Eclipse IDE | 2022+ (with WTP) |
| Apache Tomcat | 10.x |
| MySQL Server | 8.0+ |
| Maven | 3.8+ |

---

## 🚀 Setup Instructions

### Step 1: Database Setup

1. Open MySQL Workbench or terminal
2. Run the setup script:
   ```sql
   source /path/to/FunFitProject/database_setup.sql
   ```
   This creates the `funfit_db` database, the `batch` and `participant` tables, and inserts sample data.

3. **Update DB credentials** in `DBConnection.java` if needed:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/funfit_db?...";
   private static final String USER = "root";       // ← your MySQL username
   private static final String PASSWORD = "root";   // ← your MySQL password
   ```

### Step 2: Import into Eclipse

1. **File → Import → Existing Maven Projects**
2. Browse to the `FunFitProject` folder → Finish
3. Right-click project → **Configure → Convert to Dynamic Web Project** *(if needed)*

### Step 3: Configure Apache Tomcat

1. In Eclipse: **Window → Preferences → Server → Runtime Environments**
2. Add Apache Tomcat 10.x, pointing to your Tomcat installation directory
3. Right-click project → **Properties → Targeted Runtimes** → check Apache Tomcat

### Step 4: Build the Project

```bash
# Via Maven command line:
mvn clean package

# Or in Eclipse: Right-click → Run As → Maven Build → Goals: clean package
```

### Step 5: Run on Tomcat

1. Right-click project → **Run As → Run on Server**
2. Choose your Tomcat server → Finish
3. Open browser: `http://localhost:8080/FunFitProject/`

---

## 🖥️ Application Pages

| Page | URL | Description |
|------|-----|-------------|
| Home Dashboard | `/index.html` | Overview with navigation cards |
| List Batches | `/jsp/listBatches.jsp` | View, delete all batches |
| List Participants | `/jsp/listParticipants.jsp` | View, delete all participants |
| Add Batch | `/add-batch.html` | Form to create a new batch |
| Add Participant | `/add-participant.html` | Form to enroll a participant |
| Update Batch | `/update-batch.html` | Form to update batch details |
| Update Participant | `/update-participant.html` | Form to update participant |
| Search by Batch | `/jsp/participantsByBatch.jsp` | Query participants by batch ID |

---

## 🗄️ Database Schema

```sql
CREATE TABLE batch (
    bid   INT PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(256),
    slot  VARCHAR(256),   -- 'Morning' or 'Evening'
    time  VARCHAR(256)    -- e.g. '07:00 AM - 08:00 AM'
);

CREATE TABLE participant (
    pid   INT PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(256),
    phone VARCHAR(256),
    email VARCHAR(256),
    bid   INT,
    CONSTRAINT FK_ParticipantBatch FOREIGN KEY (bid) REFERENCES batch(bid)
);
```

---

## 🔄 CRUD Operations Summary

| Entity | Create | Read | Update | Delete |
|--------|--------|------|--------|--------|
| Batch | `add-batch.html` → POST `/BatchController` | `listBatches.jsp` | `update-batch.html` → POST | GET `/BatchController?action=delete&bid=X` |
| Participant | `add-participant.html` → POST `/ParticipantController` | `listParticipants.jsp` | `update-participant.html` → POST | GET `/ParticipantController?action=delete&pid=X` |

---

## 📦 Packaging

```bash
# Package as WAR file:
mvn clean package

# Output: target/FunFitProject.war
# Deploy by copying .war to Tomcat's webapps/ directory
```

---

## 🏗️ Architecture

```
Browser (HTML/JSP)
      ↕ HTTP
Servlet Controller (BatchController / ParticipantController)
      ↕ Java calls
GymRepository (Facade)
      ↕
DAO Layer (BatchDAO / ParticipantDAO)
      ↕ JDBC
MySQL Database (funfit_db)
```

---

## 📸 Submission Checklist

- [x] Source code in zip
- [x] `database_setup.sql` script
- [ ] Screenshots of outputs (take after running)

---

*© 2024 FunFit — Built as part of the A-Z Backend & Database Development course*
