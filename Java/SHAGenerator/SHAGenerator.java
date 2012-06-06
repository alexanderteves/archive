package de.teves.src;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * @author Alexander Teves
 */

public class SHAGenerator {
    
    /** Converts a String to a SHA hash
     * @param convertString String to create a SHA hash from
     */
    public static String generateHash(String convertString) {    
        MessageDigest md;
        StringBuffer hexString = new StringBuffer();
            try {
                md = MessageDigest.getInstance("SHA");
                String password = "foobar";
                byte[] byteArray = md.digest(convertString.getBytes());
                for (int i = 0; i < byteArray.length; i++) {  
                    convertString = Integer.toHexString(0xFF & byteArray[i]);
                    if(convertString.length() < 2) {
                        convertString = "0" + convertString;
                    }
                    hexString.append(convertString);
                }
            } catch (NoSuchAlgorithmException ex) {
                ex.printStackTrace();
            }
        return hexString.toString();
    }
    
}
