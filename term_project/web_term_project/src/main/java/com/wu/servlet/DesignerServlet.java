package com.wu.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DesignerServlet", urlPatterns = "/designer")
public class DesignerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String workId = req.getParameter("workId");
        req.setCharacterEncoding("UTF-8");

        if(workId != null) {
            req.getSession().setAttribute("workId", workId);
        }else {
            req.getSession().removeAttribute("workId");
        }

        req.getRequestDispatcher("/WEB-INF/pages/designer.jsp").forward(req, resp);
    }
}
