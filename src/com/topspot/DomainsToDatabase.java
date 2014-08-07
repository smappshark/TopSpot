package com.topspot;

import java.io.IOException;

import org.apache.http.client.ClientProtocolException;

public class DomainsToDatabase {
	public static void main(String[] args) throws ClientProtocolException, IOException {
		UtilityClass.dbConnection();
		//UtilityClass.SubToMainTables();
		new ParseBayutLink();
		 System.out.println("Completed ParseBayutLink  --- >");
		new ParsePropertyFinderLink();
		System.out.println("Completed ParsePropertyFinderLink  --- >");
		new ParseJustPropertyLink();
		System.out.println("Completed ParseJustPropertyLink  --- >");
		new ParseJustRentalsLink();
		System.out.println("Completed ParseJustRentalsLink  --- >");
		UtilityClass.SubToMainTables();
		System.out.println("Completed SubToMainTables  --- >");
	}
}
