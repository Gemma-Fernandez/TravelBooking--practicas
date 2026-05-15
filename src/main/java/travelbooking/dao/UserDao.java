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

    @SqlQuery("""
    SELECT * FROM users
    WHERE id = :id
""")

    User getById(int id);

    @SqlUpdate("""
    UPDATE users
    SET
        name = :name,
        email = :email,
        password = :password,
        role = :role,
        active = :active,
        register_date = :registerDate,
        balance = :balance
    WHERE id = :id
""")

    void update(@BindBean User user);
}
