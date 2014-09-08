package com.topspot;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	
	public static String formatDate(String buidlingTransDate){
		String[] strdate=buidlingTransDate.split("/");
		String formattedDate = strdate[2]+"-"+strdate[0]+"-"+strdate[1];
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-dd-mm");
		try {
	 		Date dateFrom = formatter.parse(formattedDate);
	 		String newDateString = formatter.format(dateFrom);
	 		return newDateString;
		} catch (Exception e) {
			System.out.println("exception req_datepicker --->"+e);
			//e.printStackTrace();
			return null;
		}
		
	}

}
