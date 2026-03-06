package com.gms.controller;

import com.gms.model.Participant;

import com.gms.repository.GymRepository;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/ParticipantController")
public class ParticipantController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("update".equals(action)) {
            // UPDATE
            int pid = Integer.parseInt(req.getParameter("pid"));
            String name = req.getParameter("name");
            String phone = req.getParameter("phone");
            String email = req.getParameter("email");
            int bid = Integer.parseInt(req.getParameter("bid"));
            Participant p = new Participant(pid, name, phone, email, bid);
            GymRepository.updateParticipant(p);
            resp.sendRedirect("jsp/listParticipants.jsp?msg=Participant+updated+successfully");
        } else {
            // ADD
            String name = req.getParameter("name");
            String phone = req.getParameter("phone");
            String email = req.getParameter("email");
            int bid = Integer.parseInt(req.getParameter("bid"));
            Participant p = new Participant(0, name, phone, email, bid);
            GymRepository.saveParticipant(p);
            resp.sendRedirect("jsp/listParticipants.jsp?msg=Participant+added+successfully");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            int pid = Integer.parseInt(req.getParameter("pid"));
            GymRepository.deleteParticipant(pid);
            resp.sendRedirect("jsp/listParticipants.jsp?msg=Participant+deleted+successfully");
        } else if ("edit".equals(action)) {
            int pid = Integer.parseInt(req.getParameter("pid"));
            Participant p = GymRepository.getParticipant(pid);
            req.setAttribute("participant", p);
            req.getRequestDispatcher("update-participant.html").forward(req, resp);
        } else {
            resp.sendRedirect("jsp/listParticipants.jsp");
        }
    }
}
