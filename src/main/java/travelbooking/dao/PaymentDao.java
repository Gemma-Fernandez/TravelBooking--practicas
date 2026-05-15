package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import travelbooking.model.Payment;

import java.util.List;

@RegisterRowMapper(travelbooking.dao.PaymentMapper.class)

public interface PaymentDao {

    @SqlQuery("SELECT * FROM payments")
    List<Payment> getAll();
}