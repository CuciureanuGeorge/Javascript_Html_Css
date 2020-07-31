package appLayer;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SomeFiveSecondelyJob implements Runnable {

    private int counter;
    private HttpSession ses;

    public SomeFiveSecondelyJob(HttpSession ses)
    {
        this.ses = ses;
    }

    @Override
    public void run()
    {
        //String param = ev.getServletContext().getInitParameter("counter");
        counter++;
        //param = String.valueOf(counter);
        //ev.getServletContext().setInitParameter("counter", String.valueOf(counter));

        //System.out.println(counter);
        //System.out.println(ev.getServletContext().getInitParameter("counter"));

        ses.setAttribute("counter", counter);
        System.out.println(ses.getAttribute("counter"));

    }

}
