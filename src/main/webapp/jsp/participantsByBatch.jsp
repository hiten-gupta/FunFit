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
    <title>Participants by Batch - FunFit</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<header>
    <div class="nav-container">
        <a href="../index.html" class="logo">Fun<span>Fit</span></a>
        <nav>
            <a href="../index.html">🏠 Home</a>
            <a href="listBatches.jsp">📋 Batches</a>
            <a href="listParticipants.jsp">👥 Participants</a>
            <a href="../add-batch.html">➕ Add Batch</a>
            <a href="../add-participant.html">➕ Add Participant</a>
        </nav>
    </div>
</header>

<main>
    <div style="max-width:1100px; margin:40px auto; padding:0 20px;">

        <div class="breadcrumb">
            <a href="../index.html">Home</a> &rsaquo; <a href="listBatches.jsp">Batches</a> &rsaquo; Participants by Batch
        </div>

        <h1 class="page-title">🔍 Search Participants by Batch</h1>

        <!-- Search form -->
        <div class="form-card" style="margin-bottom:30px;">
            <form action="participantsByBatch.jsp" method="get">
                <div style="display:flex; gap:15px; align-items:flex-end;">
                    <div class="form-group" style="flex:1; margin-bottom:0;">
                        <label for="bid">Enter Batch ID</label>
                        <input type="number" id="bid" name="bid" min="1"
                               placeholder="e.g. 1"
                               value="<%= request.getParameter("bid") != null ? request.getParameter("bid") : "" %>">
                    </div>
                    <button type="submit" class="btn btn-primary" style="padding:12px 25px;">🔍 Search</button>
                    <a href="listBatches.jsp" class="btn btn-secondary">📋 All Batches</a>
                </div>
            </form>
        </div>

        <%
            String bidParam = request.getParameter("bid");
            if (bidParam != null && !bidParam.isEmpty()) {
                int bid = 0;
                try {
                    bid = Integer.parseInt(bidParam);
                } catch (NumberFormatException e) { }

                if (bid > 0) {
                    Batch batch = GymRepository.getBatch(bid);
                    List<Participant> participants = GymRepository.getParticipantsByBatch(bid);

                    if (batch == null) {
        %>
        <div class="alert alert-error">❌ No batch found with ID: <%= bid %></div>
        <%
                    } else {
                        String slotBadgeClass = "Morning".equalsIgnoreCase(batch.getSlot()) ? "badge-morning" : "badge-evening";
        %>

        <!-- Batch Info Card -->
        <div style="background:rgba(233,69,96,0.1); border:1px solid rgba(233,69,96,0.3); border-radius:12px; padding:25px; margin-bottom:25px;">
            <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:10px;">
                <div>
                    <h2 style="color:#fff; font-size:22px;">📋 <%= batch.getName() %></h2>
                    <p style="color:#aaa; font-size:14px; margin-top:5px;">Batch ID: #<%= batch.getBid() %></p>
                </div>
                <div style="text-align:right;">
                    <span class="badge <%= slotBadgeClass %>" style="font-size:14px; padding:8px 18px;">
                        <%= batch.getSlot() %>
                    </span>
                    <p style="color:#aaa; font-size:14px; margin-top:8px;">🕐 <%= batch.getTime() %></p>
                </div>
            </div>
        </div>

        <div class="table-card">
            <div class="table-header">
                <h2>👥 Enrolled Participants (<%= participants.size() %>)</h2>
                <a href="../add-participant.html" class="btn btn-primary">➕ Add Participant</a>
            </div>

            <%
                if (participants.isEmpty()) {
            %>
            <div class="empty-state">
                <div class="empty-icon">👤</div>
                <h3>No participants in this batch</h3>
                <p style="margin-bottom:20px;">Enroll the first participant into batch "<%= batch.getName() %>".</p>
                <a href="../add-participant.html" class="btn btn-primary">➕ Enroll Participant</a>
            </div>
            <%
                } else {
            %>
            <table>
                <thead>
                <tr>
                    <th>#</th>
                    <th>Participant ID</th>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    int sno = 1;
                    for (Participant p : participants) {
                %>
                <tr>
                    <td><%= sno++ %></td>
                    <td><strong>#<%= p.getPid() %></strong></td>
                    <td>
                        <div style="display:flex; align-items:center; gap:10px;">
                            <div style="width:34px; height:34px; border-radius:50%; background:#e94560; display:flex; align-items:center; justify-content:center; font-weight:700;">
                                <%= p.getName().charAt(0) %>
                            </div>
                            <%= p.getName() %>
                        </div>
                    </td>
                    <td>📞 <%= p.getPhone() %></td>
                    <td>✉️ <%= p.getEmail() %></td>
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

        <%
                    }
                }
            }
        %>

    </div>
</main>

<footer>
    <p>© 2024 FunFit — Zumba Management System</p>
</footer>

</body>
</html>
