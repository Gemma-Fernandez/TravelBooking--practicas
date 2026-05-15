package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import travelbooking.model.Trip;

import java.util.List;

@RegisterRowMapper(travelbooking.dao.TripMapper.class)

public interface TripDao {

    @SqlQuery("SELECT * FROM trips")
    List<Trip> getAll();

    @SqlQuery("""
        SELECT * FROM trips
        WHERE id = :id
    """)
    Trip getById(@Bind("id") int id);

}