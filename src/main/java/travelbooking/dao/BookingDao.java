package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import travelbooking.model.Booking;

import java.util.List;

@RegisterRowMapper(BookingMapper.class)
public interface BookingDao {

    // GET ALL BOOKINGS
    @SqlQuery("SELECT * FROM bookings")
    List<Booking> getAll();

    // GET BOOKING BY ID
    @SqlQuery("""
        SELECT * FROM bookings
        WHERE id = :id
    """)
    Booking getById(@Bind("id") int id);

    // ADD BOOKING
    @SqlUpdate("""
        INSERT INTO bookings
        (user_id, trip_id, people, total_price, booking_date, confirmed)
        VALUES
        (:userId, :tripId, :people, :totalPrice, :bookingDate, :confirmed)
    """)
    void add(@BindBean Booking booking);

    // UPDATE BOOKING
    @SqlUpdate("""
        UPDATE bookings
        SET
            user_id = :userId,
            trip_id = :tripId,
            people = :people,
            total_price = :totalPrice,
            booking_date = :bookingDate,
            confirmed = :confirmed
        WHERE id = :id
    """)
    void update(@BindBean Booking booking);


    @SqlQuery("""
        SELECT b.* FROM bookings b
        JOIN users u ON b.user_id = u.id
        JOIN trips t ON b.trip_id = t.id
        WHERE u.name LIKE CONCAT('%', :search, '%')
           OR t.title LIKE CONCAT('%', :search, '%')
    """)
    List<Booking> searchBookings(@Bind("search") String search);

    // DELETE BOOKING
    @SqlUpdate("""
        DELETE FROM bookings
        WHERE id = :id
    """)
    void delete(@Bind("id") int id);

    // GET BOOKINGS FOR A SPECIFIC USER
    @SqlQuery("SELECT * FROM bookings WHERE user_id = :userId")
    List<Booking> getByUserId(@Bind("userId") int userId);
}