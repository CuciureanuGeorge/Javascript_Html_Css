package webapp;

import appLayer.SomeFiveSecondelyJob;
import appLayer.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.util.Date;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@WebServlet(name = "login")
public class login extends HttpServlet {

    //static ScheduledExecutorService scheduler;
    static Date date1 = new Date();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User userObject = new User();

        if(userObject.isValidCredentials(request.getParameter("loginname"), request.getParameter("password")))
        {
            request.setAttribute("username", userObject.getUsername());
            request.setAttribute("password", userObject.getPass());

            request.setAttribute("counter", 0);
            request.setAttribute("date1", date1);

            HttpSession ses = request.getSession(true);
            ses.setAttribute("isLogin",true);

            request.getRequestDispatcher("/welcome.jsp").forward(request, response);

        }
        else
        {
            request.setAttribute("errorMessage", "Invalid login and password. Try again");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/welcome.jsp").forward(request,response);

    }
}
