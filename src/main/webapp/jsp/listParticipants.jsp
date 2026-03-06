<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gms.repository.GymRepository" %>
<%@ page import="com.gms.model.Participant" %>
<%@ page import="com.gms.model.Batch" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Participants - FunFit</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<header>
    <div class="nav-container">
        <a href="../index.html" class="logo">Fun<span>Fit</span></a>
        <nav>
            <a href="../index.html">🏠 Home</a>
            <a href="listBatches.jsp">📋 Batches</a>
            <a href="listParticipants.jsp" class="active">👥 Participants</a>
            <a href="../add-batch.html">➕ Add Batch</a>
            <a href="../add-participant.html">➕ Add Participant</a>
        </nav>
    </div>
</header>

<main>
    <div style="max-width:1200px; margin:40px auto; padding:0 20px;">

        <div class="breadcrumb">
            <a href="../index.html">Home</a> &rsaquo; All Participants
        </div>

        <%
            String msg = request.getParameter("msg");
            if (msg != null && !msg.isEmpty()) {
        %>
        <div class="alert alert-success">✅ <%= msg %></div>
        <% } %>

        <div class="table-card">
            <div class="table-header">
                <h2>👥 All Participants</h2>
                <a href="../add-participant.html" class="btn btn-primary">➕ Enroll Participant</a>
            </div>

            <%
                List<Participant> participants = GymRepository.getAllParticipants();
                if (participants == null || participants.isEmpty()) {
            %>
            <div class="empty-state">
                <div class="empty-icon">👤</div>
                <h3>No participants enrolled yet</h3>
                <p style="margin-bottom:20px;">Start by enrolling your first Zumba participant.</p>
                <a href="../add-participant.html" class="btn btn-primary">➕ Enroll First Participant</a>
            </div>
            <%
                } else {
            %>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Batch</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Participant p : participants) {
                        Batch b = GymRepository.getBatch(p.getBid());
                        String batchInfo = (b != null) ? "#" + b.getBid() + " - " + b.getName() : "Batch #" + p.getBid();
                        String slotBadge = (b != null && "Morning".equalsIgnoreCase(b.getSlot())) ? "badge-morning" : "badge-evening";
                        String slotLabel = (b != null) ? b.getSlot() : "";
                %>
                <tr>
                    <td><strong>#<%= p.getPid() %></strong></td>
                    <td>
                        <div style="display:flex; align-items:center; gap:10px;">
                            <div style="width:36px; height:36px; border-radius:50%; background:#e94560; display:flex; align-items:center; justify-content:center; font-size:14px; font-weight:700;">
                                <%= p.getName().charAt(0) %>
                            </div>
                            <%= p.getName() %>
                        </div>
                    </td>
                    <td>📞 <%= p.getPhone() %></td>
                    <td>✉️ <%= p.getEmail() %></td>
                    <td>
                        <%= batchInfo %>
                        <% if (!slotLabel.isEmpty()) { %>
                        <br><span class="badge <%= slotBadge %>" style="margin-top:4px;"><%= slotLabel %></span>
                        <% } %>
                    </td>
                    <td>
                        <a href="../update-participant.html" class="btn btn-edit">✏️ Edit</a>
                        &nbsp;
                        <a href="../ParticipantController?action=delete&pid=<%= p.getPid() %>"
                           class="btn btn-danger"
                           onclick="return confirm('Delete participant <%= p.getName() %>?')">
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
            Total: <strong style="color:#e94560;"><%= participants != null ? participants.size() : 0 %></strong> participant(s) enrolled
        </p>
    </div>
</main>

<footer>
    <p>© 2024 FunFit — Zumba Management System</p>
</footer>

</body>
</html>
