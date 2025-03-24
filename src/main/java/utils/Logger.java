package utils;

public class Logger {
    public void log(String level, String message) {
        System.out.println("[" + level + "] " + message);
    }
}