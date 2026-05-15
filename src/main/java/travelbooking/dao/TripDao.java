package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import travelbooking.model.Trip;

import java.util.List;

@RegisterRowMapper(TripMapper.class)

public interface TripDao {

    @SqlQuery("SELECT * FROM trips")
    @RegisterBeanMapper(Trip.class) // Mapea las columnas de DB a atributos de Lombok
    List<Trip> getAll();

    @SqlQuery("SELECT * FROM trips WHERE id = :id")
    @RegisterBeanMapper(Trip.class)
    Trip getById(@Bind("id") int id);

    @SqlUpdate("""
        UPDATE trips 
        SET title = :title, description = :description, country = :country, 
            city = :city, price = :price, seats = :seats, 
            departure_date = :departureDate, active = :active, image = :image, destination_id = :destinationId
        WHERE id = :id
    """)
    void updateTrip(@BindBean Trip trip);

    @SqlUpdate("DELETE FROM trips WHERE id = :id")
    void deleteTrip(@Bind("id") int id);

    @SqlUpdate("""
        INSERT INTO trips (title, description, country, city, price, seats, departure_date, active, image, destination_id)
        VALUES (:title, :description, :country, :city, :price, :seats, :departureDate, :active, :image, :destinationId)
    """)
    void addTrip(@BindBean Trip trip);
}