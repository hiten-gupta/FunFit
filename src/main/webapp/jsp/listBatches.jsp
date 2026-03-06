<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gms.repository.GymRepository" %>
<%@ page import="com.gms.model.Batch" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Batches - FunFit</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<header>
    <div class="nav-container">
        <a href="../index.html" class="logo">Fun<span>Fit</span></a>
        <nav>
            <a href="../index.html">🏠 Home</a>
            <a href="listBatches.jsp" class="active">📋 Batches</a>
            <a href="listParticipants.jsp">👥 Participants</a>
            <a href="../add-batch.html">➕ Add Batch</a>
            <a href="../add-participant.html">➕ Add Participant</a>
        </nav>
    </div>
</header>

<main>
    <div style="max-width:1100px; margin:40px auto; padding:0 20px;">

        <div class="breadcrumb">
            <a href="../index.html">Home</a> &rsaquo; All Batches
        </div>

        <%
            String msg = request.getParameter("msg");
            if (msg != null && !msg.isEmpty()) {
        %>
        <div class="alert alert-success">✅ <%= msg %></div>
        <% } %>

        <div class="table-card">
            <div class="table-header">
                <h2>📋 All Zumba Batches</h2>
                <a href="../add-batch.html" class="btn btn-primary">➕ Add New Batch</a>
            </div>

            <%
                List<Batch> batches = GymRepository.getAllBatches();
                if (batches == null || batches.isEmpty()) {
            %>
            <div class="empty-state">
                <div class="empty-icon">📭</div>
                <h3>No batches found</h3>
                <p style="margin-bottom:20px;">Start by adding your first Zumba batch.</p>
                <a href="../add-batch.html" class="btn btn-primary">➕ Add First Batch</a>
            </div>
            <%
                } else {
            %>
            <table>
                <thead>
                <tr>
                    <th>Batch ID</th>
                    <th>Batch Name</th>
                    <th>Slot</th>
                    <th>Class Time</th>
                    <th>Participants</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Batch b : batches) {
                        int count = GymRepository.getParticipantsByBatch(b.getBid()).size();
                        String slotBadge = "Morning".equalsIgnoreCase(b.getSlot()) ? "badge-morning" : "badge-evening";
                %>
                <tr>
                    <td><strong>#<%= b.getBid() %></strong></td>
                    <td><%= b.getName() %></td>
                    <td><span class="badge <%= slotBadge %>"><%= b.getSlot() %></span></td>
                    <td>🕐 <%= b.getTime() %></td>
                    <td>
                        <a href="participantsByBatch.jsp?bid=<%= b.getBid() %>" style="color:#e94560; text-decoration:none;">
                            👥 <%= count %> enrolled
                        </a>
                    </td>
                    <td>
                        <a href="../update-batch.html" class="btn btn-edit">✏️ Edit</a>
                        &nbsp;
                        <a href="../BatchController?action=delete&bid=<%= b.getBid() %>"
                           class="btn btn-danger"
                           onclick="return confirm('Delete batch <%= b.getName() %>? This will fail if participants are enrolled.')">
                            🗑 Delete
                        </a>
                    </td>
                </tr>
                <%  } %>
                </tbody>
            </table>
            <% } %>
        </div>

        <p style="color:#666; font-size:13px; margin-top:15px;">
            Total: <strong style="color:#e94560;"><%= batches != null ? batches.size() : 0 %></strong> batch(es) registered
        </p>
    </div>
</main>

<footer>
    <p>© 2024 FunFit — Zumba Management System</p>
</footer>

</body>
</html>
