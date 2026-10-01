package vn.iotstar.util;

import java.util.Random;

public class OtpUtil_24110330 {
    public static String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
}
