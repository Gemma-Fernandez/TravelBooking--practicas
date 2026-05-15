package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import travelbooking.model.User;

import java.util.List;

@RegisterRowMapper(travelbooking.dao.UserMapper.class)

public interface UserDao {

    @SqlQuery("SELECT * FROM users")
    List<User> getAll();

    @SqlUpdate("""
        INSERT INTO users
        (name, email, password, role, active, register_date, balance)
        VALUES
        (:name, :email, :password, :role, :active, :registerDate, :balance)
    """)

    void add(@BindBean User user);
}
