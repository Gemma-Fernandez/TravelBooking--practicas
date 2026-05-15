package travelbooking.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Trip {

    private int id;
    private String title;
    private String description;
    private String country;
    private String city;
    private double price;
    private int seats;
    private LocalDate departureDate;
    private boolean active;
    private String image;
    private int destinationId;

}