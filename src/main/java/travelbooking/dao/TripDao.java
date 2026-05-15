package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
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
}