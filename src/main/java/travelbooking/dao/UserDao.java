package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import travelbooking.model.User;

import java.util.List;

@RegisterRowMapper(travelbooking.dao.UserMapper.class)

public interface UserDao {

    @SqlQuery("SELECT * FROM users")
    List<User> getAll();
}