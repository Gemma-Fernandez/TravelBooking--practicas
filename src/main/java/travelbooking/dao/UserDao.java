package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import travelbooking.model.User;

import java.util.List;

@RegisterRowMapper(travelbooking.dao.UserMapper.class)

public interface UserDao {

    // GET ALL USERS
    @SqlQuery("SELECT * FROM users")
    List<User> getAll();

    // ADD USER
    @SqlUpdate("""
        INSERT INTO users
        (name, email, password, role, active, register_date, balance)
        VALUES
        (:name, :email, :password, :role, :active, :registerDate, :balance)
    """)

    void add(@BindBean User user);

    // GET USER BY ID
    @SqlQuery("""
        SELECT * FROM users
        WHERE id = :id
    """)

    User getById(@Bind("id") int id);

    // UPDATE USER
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

    // LOGIN
    @SqlQuery("""
        SELECT * FROM users
        WHERE email = :email
        AND password = :password
    """)

    User getByEmailAndPassword(
            @Bind("email") String email,
            @Bind("password") String password
    );

    // DELETE USER
    @SqlUpdate("""
    DELETE FROM users
    WHERE id = :id
""")

    void delete(@Bind("id") int id);
}