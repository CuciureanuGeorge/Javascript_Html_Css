package appLayer;

import dbLayer.MyConnectionProvider;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class User {

    static Connection con;
    static PreparedStatement ps;

    private String username;
    private String password;

    public void registerUser(String sUsername, String sUserPassword)
    {
        try
        {
            con = MyConnectionProvider.getCon();
            ps = con.prepareStatement("insert into user value(?,?)");
            ps.setString(1, sUsername);
            ps.setString(2,sUserPassword);
            ps.execute();
            this.username = sUsername;
            this.password = sUserPassword;
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
    }

    public boolean isUser(String username)
    {
        try {
            con = MyConnectionProvider.getCon();
            ps = con.prepareStatement("select * from user where username=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while(rs.next())
            {
                if(rs.getString(1).equals(username))
                {
                    return true;
                }
            }
            return false;

        }
        catch (Exception e)
        {
            System.out.println(e);
        }
        return false;
    }

    public boolean isValidCredentials(String sUserName, String sUserPassword)
    {
        try
        {
            con = MyConnectionProvider.getCon();
            ps = con.prepareStatement("select * from user where username=?");
            ps.setString(1,sUserName);
            ResultSet rs = ps.executeQuery();

            while(rs.next())
            {
                this.username = rs.getString(1);
                this.password = rs.getString(2);
            }
        }
        catch (Exception e)
        {
            System.out.println(e);
        }

        if(sUserPassword.equals(this.password))
            return true;
        return false;
    }

    public String getUsername()
    {
        return this.username;
    }

    public String getPass()
    {
        return this.password;
    }

    public void setUsername(String un)
    {
        username = un;
    }

    public void setPass(String pass)
    {
        password = pass;
    }

}
