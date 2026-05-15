package travelbooking.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Payment {

    private int id;
    private int bookingId;
    private double amount;
    private String paymentMethod;
    private LocalDate paymentDate;
    private boolean completed;

}