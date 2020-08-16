package com.karankumar.bookproject.ui.registration;

import com.karankumar.bookproject.backend.entity.account.User;
import com.karankumar.bookproject.backend.service.UserService;
import com.karankumar.bookproject.ui.login.LoginView;
import com.karankumar.bookproject.ui.shelf.BooksInShelfView;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.formlayout.FormLayout;
import com.vaadin.flow.component.html.H2;
import com.vaadin.flow.component.html.Paragraph;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.textfield.EmailField;
import com.vaadin.flow.component.textfield.PasswordField;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.data.binder.Binder;
import com.vaadin.flow.data.binder.ValidationResult;
import com.vaadin.flow.data.binder.ValueContext;
import com.vaadin.flow.data.validator.EmailValidator;
import lombok.extern.java.Log;
import org.apache.commons.lang3.StringUtils;

@Log
public class RegistrationForm extends FormLayout {
    private final UserService userService;
    private final Binder<User> binder = new BeanValidationBinder<>(User.class);

    private final TextField usernameField = new TextField("Username");
    private final EmailField emailField = new EmailField("Email Address");
    private final PasswordField passwordField = new PasswordField("Password");
    private final PasswordField passwordConfirmationField = new PasswordField("Confirm Password");
    private final Paragraph passwordHint = new Paragraph(
            "The password must be at least 8 characters long and consist of at least one lowercase letter, one uppercase letter, one digit, and one special character from @#$%^&+=");
    private final Span errorMessage = new Span();

    private final Button registerButton = new Button("Register");

    // Flag for disabling first run for password validation
    private boolean enablePasswordValidation = false;

    public RegistrationForm(UserService userService) {
        this.userService = userService;

        usernameField.setRequired(true);
        emailField.setRequiredIndicatorVisible(true);
        passwordField.setRequired(true);
        passwordConfirmationField.setRequired(true);

        registerButton.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
        registerButton.addClickListener(buttonClickEvent -> {
            User user = User.builder().build();

            if (binder.writeBeanIfValid(user)) {
                try {
                    this.userService.register(user);
                    getUI().ifPresent(ui -> ui.navigate(BooksInShelfView.class));
                } catch (Exception e) {
                    LOGGER.severe("Could not register the user " + user);
                    e.printStackTrace();

                    errorMessage.setText("A server error occurred when registering. Please try again later.");
                }
            }
        });

        binder.forField(usernameField)
              .withValidator(userService::usernameIsNotInUse,
                      "A user with this username does already exist")
              .bind("username");
        binder.forField(emailField)
              .withValidator(new EmailValidator("Please enter a correct email address"))
              .withValidator(userService::emailIsNotInUse,
                      "A user with this email address already exists")
              .bind("email");

        binder.forField(passwordField)
              .withValidator(this::passwordValidator)
              .bind("password");
        passwordConfirmationField.addValueChangeListener(e -> {
            // The user has modified the second field, now we can validate and show errors.
            enablePasswordValidation = true;
            binder.validate();
        });

        passwordHint.getStyle().set("font-size", "var(--lumo-font-size-s)");
        passwordHint.getStyle().set("color", "var(--lumo-secondary-text-color)");

        binder.setStatusLabel(errorMessage);
        errorMessage.getStyle().set("color", "var(--lumo-error-text-color)");

        this.setMaxWidth("360px");
        this.getStyle().set("margin", "0 auto");
        this.setResponsiveSteps(
                new FormLayout.ResponsiveStep("0", 1, FormLayout.ResponsiveStep.LabelsPosition.TOP)
        );

        add(
                new H2("Register"),
                usernameField,
                emailField,
                passwordField,
                passwordConfirmationField,
                passwordHint,
                errorMessage,
                registerButton,
                new Button("Go back to Login", e -> getUI().ifPresent(ui -> ui.navigate(LoginView.class)))
        );
    }

    private ValidationResult passwordValidator(String password, ValueContext ctx) {
        if (!enablePasswordValidation) {
            // user hasn't visited the field yet, so don't validate just yet
            return ValidationResult.ok();
        }

        String passwordConfirmation = passwordConfirmationField.getValue();

        if (StringUtils.equals(password, passwordConfirmation)) {
            return ValidationResult.ok();
        }

        return ValidationResult.error("Passwords do not match");
    }
}