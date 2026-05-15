package travelbooking.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Booking {

    private int id;
    private int userId;
    private int tripId;
    private int people;
    private double totalPrice;
    private LocalDate bookingDate;
    private boolean confirmed;

}