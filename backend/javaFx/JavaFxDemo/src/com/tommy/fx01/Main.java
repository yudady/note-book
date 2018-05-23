package com.tommy.fx01;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.net.URL;

public class Main extends Application {

	@Override
	public void start(Stage primaryStage) throws Exception {

		URL fxmlResource = this.getClass().getResource("sample.fxml");
		Parent rootElement = FXMLLoader.load(fxmlResource);
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
