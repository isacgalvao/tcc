package io.github.isacgalvao.sistema.professor;

public final class ProfessorConstraints {
    public final static class Nome {
        public static final int MAX_SIZE = 100;
    }

    public final static class Email {
        public static final int MAX_SIZE = 100;
        public static final String PATTERN = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        public static final String MESSAGE = "deve ser um email válido.";
    }

    public final static class Usuario {
        public static final int MAX_SIZE = 100;
        public static final int MIN_SIZE = 3;
        public static final String PATTERN = "^\\w{" + MIN_SIZE + ",}$";
        public static final String MESSAGE = "deve ter no minimo " + MIN_SIZE + " caracteres e conter apenas letras, números e _";
    }

    public final static class Password {
        public static final int MIN_SIZE = 8;
        public static final int MAX_SIZE = 100;
        public static final String PATTERN = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@!#$%^&+=])(?=\\S+$).{" + MIN_SIZE + "," + MAX_SIZE + "}$";
        public static final String MESSAGE = "deve conter pelo menos 8 caracteres, uma letra maiúscula, uma letra minúscula, um número e um caractere especial.";
    }
}
