package travelbooking.dao;

import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import travelbooking.model.Payment;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PaymentMapper implements RowMapper<Payment> {

    @Override
    public Payment map(ResultSet rs, StatementContext ctx) throws SQLException {

        return new Payment(
                rs.getInt("id"),
                rs.getInt("booking_id"),
                rs.getDouble("amount"),
                rs.getString("payment_method"),
                rs.getDate("payment_date").toLocalDate(),
                rs.getBoolean("completed")
        );
    }
}