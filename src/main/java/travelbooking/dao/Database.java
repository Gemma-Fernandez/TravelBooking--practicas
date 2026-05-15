package travelbooking.dao;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

public class Database {

    public static Jdbi jdbi;

    public static void connect() throws ClassNotFoundException {

        Class.forName("org.mariadb.jdbc.Driver");

        String url = "jdbc:mariadb://localhost:3306/travelbooking";
        String user = "root";
        String password = "1234";

        jdbi = Jdbi.create(url, user, password);
        jdbi.installPlugin(new SqlObjectPlugin());
    }
}