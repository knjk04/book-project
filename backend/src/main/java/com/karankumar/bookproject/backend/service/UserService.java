/*
    The book project lets a user keep track of different books they would like to read, are currently
    reading, have read or did not finish.
    Copyright (C) 2021  Karan Kumar

    This program is free software: you can redistribute it and/or modify it under the terms of the
    GNU General Public License as published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
    PURPOSE.  See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along with this program.
    If not, see <https://www.gnu.org/licenses/>.
 */

package com.karankumar.bookproject.backend.service;

import com.karankumar.bookproject.backend.model.Book;
import com.karankumar.bookproject.backend.model.PredefinedShelf;
import com.karankumar.bookproject.backend.model.account.UserRole;
import com.karankumar.bookproject.backend.model.account.Role;
import com.karankumar.bookproject.backend.model.account.User;
import com.karankumar.bookproject.backend.repository.RoleRepository;
import com.karankumar.bookproject.backend.repository.UserRepository;
import com.karankumar.bookproject.backend.repository.BookRepository;
import com.nulabinc.zxcvbn.Strength;
import com.nulabinc.zxcvbn.Zxcvbn;
import lombok.NonNull;

import org.springframework.context.annotation.Lazy;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.Validation;
import javax.validation.Validator;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;


@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final BookRepository bookRepository;
    private final PredefinedShelfService predefinedShelfService;

    public static final String USER_NOT_FOUND_ERROR_MESSAGE = "Could not find the user with ID %d";
    public static final Zxcvbn zxcvbn = new Zxcvbn();

    public UserService(UserRepository userRepository,
                       RoleRepository roleRepository,
                       PasswordEncoder passwordEncoder,
                       AuthenticationManager authenticationManager,
                       @Lazy PredefinedShelfService predefinedShelfService,
                       BookRepository bookRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
        this.predefinedShelfService = predefinedShelfService;
        this.bookRepository = bookRepository;
    }

    public User register(@NonNull User user) throws UserAlreadyRegisteredException {
        Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
        Set<ConstraintViolation<User>> constraintViolations = validator.validate(user);

        if (!constraintViolations.isEmpty()) {
            throw new ConstraintViolationException(constraintViolations);
        }
        
        if (user.getEmail() != null && isEmailInUse(user.getEmail())) {
            throw new UserAlreadyRegisteredException(
                    "A user with the email address " + user.getEmail() + " already exists");
        }

        Role userRole = roleRepository.findByRole(UserRole.USER.toString())
                                      .orElseThrow(() -> new AuthenticationServiceException(
                                              "The default user role could not be found"));

        Strength passwordStrength = zxcvbn.measure(user.getPassword());
        if (passwordStrength.getScore() <= 2){
            throw new ConstraintViolationException("weak password!!", constraintViolations);
        }


        User userToRegister = User.builder()
                                  .email(user.getEmail())
                                  .password(passwordEncoder.encode(user.getPassword()))
                                  .active(true)
                                  .roles(Set.of(userRole))
                                  .build();

        userRepository.save(userToRegister);

        authenticateUser(userToRegister);
        return userToRegister;
    }

    public User getCurrentUser() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        // TODO: throw custom exception
        return userRepository.findByEmail(email).orElseThrow();
    }

    // TODO: this can be removed once we are no longer populating test data
    public List<User> findAll() {
        return userRepository.findAll();
    }

    public Optional<User> findUserById(@NonNull Long id) {
        return userRepository.findById(id);
    }

    private void authenticateUser(User user) {
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
                new UsernamePasswordAuthenticationToken(user.getEmail(), user.getPassword());
        Authentication authResult =
                authenticationManager.authenticate(usernamePasswordAuthenticationToken);

        if (authResult.isAuthenticated()) {
            SecurityContextHolder.getContext().setAuthentication(authResult);
        }
    }

    public boolean isEmailInUse(@NonNull String email) {
        return userRepository.findByEmail(email).isPresent();
    }

    public boolean emailIsNotInUse(String email) {
        return !isEmailInUse(email);
    }

    public void changeUserPassword(@NonNull User user, @NonNull String password) {
        Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
        Set<ConstraintViolation<String>> constraintViolations = validator.validate(password);

        Strength passwordStrength = zxcvbn.measure(password);
        if (passwordStrength.getScore() <= 2){
            throw new ConstraintViolationException("weak password!!", constraintViolations);
        }

        String encodedPassword = passwordEncoder.encode(password);
        user.setPassword(encodedPassword);
        userRepository.save(user);
    }

    public void deleteUserById(@NonNull Long id) {
        Optional<User> user = userRepository.findById(id);
        if (user.isPresent()) {
            // TODO: make the temporal coupling explicit -- this needs to be called before bookRepository.deleteAll()
            removePredefinedShelfFromUserBooks();

            bookRepository.deleteAll();
            userRepository.deleteById(id);
        } else {
            // TODO: throw custom exception.
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND, 
                    String.format(USER_NOT_FOUND_ERROR_MESSAGE, id)
            );
        }
    }

    private void removePredefinedShelfFromUserBooks() {
        List<PredefinedShelf> predefinedShelves = predefinedShelfService.findAllForLoggedInUser();

        // Add all of the books in each predefined shelf to this set outside of the loop to
        // avoid a concurrent modification exception
        Set<Book> outerBooks = new HashSet<>();
        for (PredefinedShelf p : predefinedShelves) {
            p.removeUser();
            outerBooks.addAll(p.getBooks());
        }

        outerBooks.forEach(Book::removePredefinedShelf);
    }
}
