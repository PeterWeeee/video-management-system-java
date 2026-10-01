package vn.iotstar.util;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil_24110330 {
    private static String fromEmail = System.getenv("MAIL_USERNAME");
    private static String appPassword = System.getenv("MAIL_PASSWORD");

    static {
        if (fromEmail == null || fromEmail.trim().isEmpty() || appPassword == null || appPassword.trim().isEmpty()) {
            try (java.io.InputStream is = EmailUtil_24110330.class.getClassLoader().getResourceAsStream("mail.properties")) {
                if (is != null) {
                    Properties fileProps = new Properties();
                    fileProps.load(is);
                    if (fromEmail == null || fromEmail.trim().isEmpty()) {
                        fromEmail = fileProps.getProperty("mail.username");
                    }
                    if (appPassword == null || appPassword.trim().isEmpty()) {
                        appPassword = fileProps.getProperty("mail.password");
                    }
                }
            } catch (Exception e) {
                System.err.println("Cannot load mail.properties: " + e.getMessage());
            }
        }
        if (fromEmail == null) {
            fromEmail = "your_email@gmail.com";
        }
        if (appPassword == null) {
            appPassword = "";
        }
    }

    public static boolean sendOtpEmail(String toEmail, String otp) {
        if (!isValidEmail(toEmail)) {
            return false;
        }
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.connectiontimeout", "25000");
        props.put("mail.smtp.timeout", "25000");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword.replace(" ", ""));
            }
        };

        try {
            Session session = Session.getInstance(props, auth);
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail, "Nguyen Tri Thai - Web De 04", "UTF-8"));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail.trim()));
            msg.setReplyTo(new InternetAddress[] { new InternetAddress(fromEmail) });
            msg.setSentDate(new java.util.Date());
            msg.setSubject("[Web De 04] Ma OTP kich hoat: " + otp, "UTF-8");

            String content = "<div style='font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 500px; margin: 0 auto; border: 1px solid #ddd; padding: 20px; border-radius: 8px;'>"
                    + "<h2 style='color: #0d6efd; margin-top: 0;'>Xac Thuc Tai Khoan</h2>"
                    + "<p>Xin chao,</p>"
                    + "<p>Ban vua thuc hien dang ky tai khoan tren he thong Web De 04. Ma OTP kich hoat cua ban la:</p>"
                    + "<div style='text-align: center; margin: 25px 0;'>"
                    + "  <span style='font-size: 32px; font-weight: bold; letter-spacing: 6px; color: #d9534f; background: #f8f9fa; padding: 10px 24px; border: 2px dashed #d9534f; border-radius: 6px; display: inline-block;'>" + otp + "</span>"
                    + "</div>"
                    + "<p>Vui long nhap ma nay vao trang xac thuc de hoan tat qua trinh kich hoat tai khoan.</p>"
                    + "<hr style='border: none; border-top: 1px solid #eee; margin: 20px 0;'/>"
                    + "<p style='font-size: 13px; color: #777; margin-bottom: 0;'>Thi sinh: <strong>Nguyen Tri Thai</strong> | MSSV: <strong>24110330</strong> | Ma de: <strong>04</strong></p>"
                    + "</div>";
            msg.setContent(content, "text/html; charset=UTF-8");

            Transport.send(msg);
            System.out.println(">>> DA GUI OTP THANH CONG TOI: " + toEmail + " | Ma OTP: " + otp);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        String regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        if (!email.trim().matches(regex)) {
            return false;
        }
        try {
            InternetAddress emailAddr = new InternetAddress(email.trim());
            emailAddr.validate();
            return true;
        } catch (Exception ex) {
            return false;
        }
    }
}
