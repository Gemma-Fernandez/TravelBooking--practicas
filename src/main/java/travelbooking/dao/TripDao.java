package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import travelbooking.model.Trip;

import java.util.List;

@RegisterRowMapper(TripMapper.class)

public interface TripDao {

    @SqlQuery("SELECT * FROM trips")
    List<Trip> getAll();
}