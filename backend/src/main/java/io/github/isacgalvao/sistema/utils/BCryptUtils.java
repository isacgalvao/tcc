package io.github.isacgalvao.sistema.utils;

import at.favre.lib.crypto.bcrypt.BCrypt;

public class BCryptUtils {
    
    private static final BCryptUtils INSTANCE = new BCryptUtils();

    public static BCryptUtils getInstance() {
        return INSTANCE;
    }

    private BCryptUtils() {}

    private final BCrypt.Hasher hasher = BCrypt.withDefaults();
    private final BCrypt.Verifyer verifyer = BCrypt.verifyer();

    public String hash(String password) {
        return hasher.hashToString(12, password.toCharArray());
    }

    public boolean verify(String password, String hash) {
        BCrypt.Result result = verifyer.verify(password.toCharArray(), hash);
        return result.verified;
    }
}
