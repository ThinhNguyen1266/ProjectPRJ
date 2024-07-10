/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author DucNHCE180015
 */
public class mailutil {
    public static void sendVerificationEmail(String email,String otp) {
        // SMTP server configuration
        String host = "smtp.gmail.com";
        final String user = "dantdm1243@gmail.com"; // SMTP server username (change accordingly)
        final String password = "neps svbx aqix nqdq"; // SMTP server password (change accordingly)

        // Recipient's email address
        String to = email;

        // Set up properties for the mail session
        Properties props = new Properties();
        props.put("mail.smtp.host", host); // SMTP server hostname
        props.put("mail.smtp.auth", "true"); // Enable authentication
        props.put("mail.smtp.starttls.enable", "true"); // Enable TLS
        props.put("mail.smtp.port", "587"); // TLS 587, SSL 465

        // Create a session with the specified properties and authentication
        Session session = Session.getDefaultInstance(props, new jakarta.mail.Authenticator() {
            // Define the method to get the password authentication
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password); // Return the username and password
            }
        });

        try {
            // Create a new email message
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user)); // Set the sender's email address
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to)); // Add the recipient's email address
            message.setSubject("Please verify your email address"); // Set the email subject
            String emailContent = "Click the link and enter OTP to verify your account: http://localhost:8080/CreateAccountController/Verity?email=" + email 
                + "\nHere is your OTP: " + otp;
            message.setText(emailContent);

            // Send the email
            Transport.send(message);

            // Print success message to console
            System.out.println("Message sent successfully");
        } catch (Exception e) {
        }
    }
}
