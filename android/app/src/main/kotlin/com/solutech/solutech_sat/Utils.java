package com.solutech.solutech_sat;

import com.datecs.fiscalprinter.FiscalResponse;
import com.datecs.fiscalprinter.ken.FMP10KEN;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Utils {
     static void generateZReport(FMP10KEN fmp10KEN){
            FiscalResponse response = null;
            try {
                response = fmp10KEN.command120Variant1Version0();
            } catch (IOException e) {
                //PrintActivity.this.runOnUiThread(() -> showStatus(e.getMessage()));
            }
            StringBuffer buffer = new StringBuffer();

            if (response.get("errorCode").equals("P")) {
                do {
                    buffer.append(response.get("journalLineText") + "\r\n");
                    try {
                        response = fmp10KEN.command120Variant1Version1();
                    } catch (IOException e) {
                        //PrintActivity.this.runOnUiThread(() -> showStatus(e.getMessage()));
                    }
                } while (response.get("errorCode").equals("P"));
                MessageDigest md = null;
                try {
                    md = MessageDigest.getInstance("SHA-1");
                } catch (NoSuchAlgorithmException e) {
                    e.printStackTrace();
                }
                byte[] hash = new byte[0];
                try {
                    hash = md.digest(buffer.toString().getBytes("Cp1252"));
                } catch (UnsupportedEncodingException e) {
                    //PrintActivity.this.runOnUiThread(() -> showStatus(e.getMessage()));
                }
                String sha1 = byteArrayToHexString(hash, 0, hash.length);
                try {
                    fmp10KEN.command120Variant2Version0(sha1);
                } catch (IOException e) {
                    //PrintActivity.this.runOnUiThread(() -> showStatus(e.getMessage()));
                }
                try {
                    fmp10KEN.command69Variant0Version0("0");
                } catch (IOException e) {
                    //PrintActivity.this.runOnUiThread(() -> showStatus(e.getMessage()));
                }
            }
    }

    private static String byteArrayToHexString(byte[] data, int offset, int length) {
        final char[] hex = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
        char[] buf = new char[length * 2];
        int offs = 0;
        for (int i = 0; i < length; i++) {
            buf[offs++] = hex[(data[offset + i] >> 4) & 0xf];
            buf[offs++] = hex[(data[offset + i]) & 0xf];
        }
        return new String(buf, 0, offs);
    }
}
