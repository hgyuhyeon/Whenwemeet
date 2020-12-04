package room;

public class Schedule {
	private String roomID; 
	private String year;
	private String month;
	private String day;
	private String startTime;
	private String endTime;
	public void setYear (String year) {
		this.year = year;
	}
	public void setMonth (String month) {
		this.month = month;
	}
	public void setDay (String day) {
		this.day = day;
	}
	public void setStartTime (String startTime) {
		this.startTime = startTime;
	}
	public void setEndTime (String endTime) {
		this.endTime = endTime;
	}
	public String getYear () {
		return year;
	}
	public String getMonth () {
		return month;
	}
	public String getDay () {
		return day;
	}
	public String getStartTime () {
		return startTime;
	}
	public String getEndTime () {
		return endTime;
	}
}

