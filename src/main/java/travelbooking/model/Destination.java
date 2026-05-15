package travelbooking.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Destination {

    private int id;
    private String name;
    private String country;
    private String description;
    private boolean popular;
    private boolean active;
    private String image;
    private LocalDate createdAt;

}