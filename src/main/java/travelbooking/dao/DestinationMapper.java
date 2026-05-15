package travelbooking.dao;

import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import travelbooking.model.Destination;

import java.sql.ResultSet;
import java.sql.SQLException;

public class DestinationMapper implements RowMapper<Destination> {

    @Override
    public Destination map(ResultSet rs, StatementContext ctx) throws SQLException {

        return new Destination(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("country"),
                rs.getString("description"),
                rs.getBoolean("popular"),
                rs.getBoolean("active"),
                rs.getString("image"),
                rs.getDate("created_at").toLocalDate()
        );
    }
}