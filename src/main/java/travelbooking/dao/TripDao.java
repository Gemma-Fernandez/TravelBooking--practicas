package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import travelbooking.model.Trip;

import java.util.List;

@RegisterRowMapper(travelbooking.dao.TripMapper.class)

public interface TripDao {

    // GET ALL
    @SqlQuery("SELECT * FROM trips")

    @RegisterBeanMapper(Trip.class)

    List<Trip> getAll();

    // GET BY ID
    @SqlQuery("""
        SELECT * FROM trips
        WHERE id = :id
    """)

    @RegisterBeanMapper(Trip.class)

    Trip getById(@Bind("id") int id);

    // AVAILABLE TRIPS
    @SqlQuery("""
        SELECT * FROM trips
        WHERE active = true
        AND seats > 0
    """)

    @RegisterBeanMapper(Trip.class)

    List<Trip> getAvailableTrips();

    // SEARCH TRIPS
    @SqlQuery("""
        SELECT * FROM trips
        WHERE active = true
        AND (
            LOWER(title) LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(country) LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(city) LIKE LOWER(CONCAT('%', :search, '%'))
        )
    """)

    @RegisterBeanMapper(Trip.class)

    List<Trip> searchTrips(@Bind("search") String search);

    // ADD TRIP
    @SqlUpdate("""
        INSERT INTO trips
        (title, description, country, city, price, seats,
         departure_date, active, image, destination_id)

        VALUES
        (:title, :description, :country, :city, :price, :seats,
         :departureDate, :active, :image, :destinationId)
    """)

    void addTrip(@BindBean Trip trip);

    // UPDATE TRIP
    @SqlUpdate("""
        UPDATE trips
        SET
            title = :title,
            description = :description,
            country = :country,
            city = :city,
            price = :price,
            seats = :seats,
            departure_date = :departureDate,
            active = :active,
            image = :image,
            destination_id = :destinationId

        WHERE id = :id
    """)

    void updateTrip(@BindBean Trip trip);

    // UPDATE SEATS
    @SqlUpdate("""
        UPDATE trips
        SET
            seats = :seats,
            active = :active
        WHERE id = :id
    """)

    void updateSeatsAndActive(@Bind("id") int id,
                              @Bind("seats") int seats,
                              @Bind("active") boolean active);

    // DELETE
    @SqlUpdate("""
        DELETE FROM trips
        WHERE id = :id
    """)

    void deleteTrip(@Bind("id") int id);
}