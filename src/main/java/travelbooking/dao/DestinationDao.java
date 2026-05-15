package travelbooking.dao;

import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import travelbooking.model.Destination;

import java.util.List;

@RegisterRowMapper(travelbooking.dao.DestinationMapper.class)

public interface DestinationDao {

    @SqlQuery("SELECT * FROM destinations")
    List<Destination> getAll();
}