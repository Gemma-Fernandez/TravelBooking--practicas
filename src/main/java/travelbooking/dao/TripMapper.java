package travelbooking.dao;

import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import travelbooking.model.Trip;

import java.sql.ResultSet;
import java.sql.SQLException;

public class TripMapper implements RowMapper<Trip> {

    @Override
    public Trip map(ResultSet rs, StatementContext ctx) throws SQLException {

        return new Trip(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("description"),
                rs.getString("country"),
                rs.getString("city"),
                rs.getDouble("price"),
                rs.getInt("seats"),
                rs.getDate("departure_date").toLocalDate(),
                rs.getBoolean("active"),
                rs.getString("image"),
                rs.getInt("destination_id")
        );
    }
}