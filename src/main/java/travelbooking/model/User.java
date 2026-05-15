package travelbooking.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class User {

    private int id;
    private String name;
    private String email;
    private String password;
    private String role;
    private boolean active;
    private LocalDate registerDate;
    private double balance;

}