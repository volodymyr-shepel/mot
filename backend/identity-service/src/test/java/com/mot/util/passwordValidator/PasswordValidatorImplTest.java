package com.mot.util.passwordValidator;

import com.mot.exception.PasswordValidationException;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class PasswordValidatorImplTest {

    private final PasswordValidatorImpl passwordValidator = new PasswordValidatorImpl();

    @Test
    public void givenValidPassword_whenValidatingPassword_thenNoExceptionThrown() {
        // Given
        String validPassword = "StrongPassword123!@#";

        // When, Then
        // No exception should be thrown
        passwordValidator.validatePassword(validPassword);
    }

    @Test
    public void givenShortPassword_whenValidatingPassword_thenExceptionThrownWithSpecificMessage() {
        // Given
        String shortPassword = "ShortPwd";

        // When, Then
        // Exception should be thrown with a specific message
        assertThrows(
                PasswordValidationException.class,
                () -> passwordValidator.validatePassword(shortPassword),
                "Password must be at least 12 characters long."
        );
    }

    @Test
    public void givenPasswordWithoutUppercase_whenValidatingPassword_thenExceptionThrownWithSpecificMessage() {
        // Given
        String noUppercasePassword = "weakpassword123!@#";

        // When, Then
        // Exception should be thrown with a specific message
        assertThrows(
                PasswordValidationException.class,
                () -> passwordValidator.validatePassword(noUppercasePassword),
                "Password must include uppercase and lowercase letters, a special character, and be at least 12 characters long."
        );
    }

    @Test
    public void givenPasswordWithoutLowercase_whenValidatingPassword_thenExceptionThrownWithSpecificMessage() {
        // Given
        String noLowercasePassword = "WEAKPASSWORD123!@#";

        // When, Then
        // Exception should be thrown with a specific message
        assertThrows(
                PasswordValidationException.class,
                () -> passwordValidator.validatePassword(noLowercasePassword),
                "Password must include uppercase and lowercase letters, a special character, and be at least 12 characters long."
        );
    }

    @Test
    public void givenPasswordWithoutSpecialCharacter_whenValidatingPassword_thenExceptionThrownWithSpecificMessage() {
        // Given
        String noSpecialCharPassword = "WeakPassword123";

        // When, Then
        // Exception should be thrown with a specific message
        assertThrows(
                PasswordValidationException.class,
                () -> passwordValidator.validatePassword(noSpecialCharPassword),
                "Password must include uppercase and lowercase letters, a special character, and be at least 12 characters long."
        );
    }

    @Test
    public void givenPasswordWithInvalidCharacters_whenValidatingPassword_thenExceptionThrownWithSpecificMessage() {
        // Given
        String invalidCharPassword = "InvalidPassword123";

        // When, Then
        // Exception should be thrown with a specific message
        assertThrows(
                PasswordValidationException.class,
                () -> passwordValidator.validatePassword(invalidCharPassword),
                "Password must include uppercase and lowercase letters, a special character, and be at least 12 characters long."
        );
    }
    @Test
    public void givenEmptyPassword_whenValidatingPassword_thenExceptionThrownWithSpecificMessage() {
        // Given
        String emptyPassword = "";

        // When, Then
        // Exception should be thrown with a specific message
        assertThrows(
                PasswordValidationException.class,
                () -> passwordValidator.validatePassword(emptyPassword),
                "Password must be at least 12 characters long."
        );
    }
}