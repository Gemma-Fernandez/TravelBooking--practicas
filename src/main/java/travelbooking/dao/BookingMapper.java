package travelbooking.dao;

import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import travelbooking.model.Booking;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BookingMapper implements RowMapper<Booking> {

    @Override
    public Booking map(ResultSet rs, StatementContext ctx) throws SQLException {

        return new Booking(
                rs.getInt("id"),
                rs.getInt("user_id"),
                rs.getInt("trip_id"),
                rs.getInt("people"),
                rs.getDouble("total_price"),
                rs.getDate("booking_date").toLocalDate(),
                rs.getBoolean("confirmed")
        );
    }
}