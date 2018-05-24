package com.tommy.fx01;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.File;
import java.net.URL;

public class Main extends Application {

	private static final String BASE_PATH = System.getProperty("user.dir");

	@Override public void start(Stage primaryStage) throws Exception {

		Parent rootElement = FXMLLoader.load(getClass().getResource("sample.fxml"));
		primaryStage.setTitle("Hello World");

		Scene scene = new Scene(rootElement, 800, 600);

		scene.getStylesheets().add(getClass().getResource("application.css").toExternalForm());

		primaryStage.setScene(scene);
		primaryStage.show();
	}

	public static void main(String[] args) {
		launch(args);
	}
}
