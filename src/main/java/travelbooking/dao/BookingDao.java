package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import travelbooking.model.Booking;

import java.util.List;

@RegisterRowMapper(travelbooking.dao.BookingMapper.class)

public interface BookingDao {

    @SqlQuery("SELECT * FROM bookings")
    List<Booking> getAll();
}