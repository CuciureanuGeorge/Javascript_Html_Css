package appLayer;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

//@WebListener
/*public class BackgroundJobManager implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent event)
    {

        ServletContext servletContext = event.getServletContext();

        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(new SomeFiveSecondelyJob(),0,1, TimeUnit.SECONDS);

        System.out.println("\n###############################################################\n");

        System.out.println("contextInitialized method has been called in "+this.getClass().getName());

        System.out.println(servletContext + " is initialized or created");

        System.out.println("\n###############################################################\n");

    }

    @Override
    public void contextDestroyed(ServletContextEvent event)
    {
        scheduler.shutdownNow();

        System.out.println("\n######################################################################\n");

        System.out.println("contextDestroyed method has been called in "+this.getClass().getName());

        ServletContext servletContext = event.getServletContext();

        System.out.println(servletContext+" is destroyed");

        System.out.println(event.getServletContext().getInitParameter("counter"));

        System.out.println("\n####################################################################\n");

    }
}*/