package com.gms.controller;

import com.gms.model.Batch;

import com.gms.repository.GymRepository;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/BatchController")
public class BatchController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("update".equals(action)) {
            // UPDATE
            int bid = Integer.parseInt(req.getParameter("bid"));
            String name = req.getParameter("name");
            String slot = req.getParameter("slot");
            String time = req.getParameter("time");
            Batch batch = new Batch(bid, name, slot, time);
            GymRepository.updateBatch(batch);
            resp.sendRedirect("jsp/listBatches.jsp?msg=Batch+updated+successfully");
        } else {
            // ADD
            String name = req.getParameter("name");
            String slot = req.getParameter("slot");
            String time = req.getParameter("time");
            Batch batch = new Batch(0, name, slot, time);
            GymRepository.saveBatch(batch);
            resp.sendRedirect("jsp/listBatches.jsp?msg=Batch+added+successfully");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            int bid = Integer.parseInt(req.getParameter("bid"));
            GymRepository.deleteBatch(bid);
            resp.sendRedirect("jsp/listBatches.jsp?msg=Batch+deleted+successfully");
        } else if ("edit".equals(action)) {
            int bid = Integer.parseInt(req.getParameter("bid"));
            Batch batch = GymRepository.getBatch(bid);
            req.setAttribute("batch", batch);
            req.getRequestDispatcher("update-batch.html").forward(req, resp);
        } else {
            resp.sendRedirect("jsp/listBatches.jsp");
        }
    }
}
