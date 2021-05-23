class NewsApiDateConverter{

  static String newsDateMonth(String string){
    int i = 0;
    String s = "";
    String monthNum = string.split('')[5] + string.split('')[6];
    String dayNum = string.split('')[8] + string.split('')[9];

    List <String> m = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    List <String> mN = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];

    for (i = 0; i < 12; ++i) {
      if (monthNum == mN[i]) {
        s = dayNum + ' ' + m[i] + ' ';
        break;
      }
    }

    for (i = 0; i < 4; ++i) {
      s += string.split('')[i];
    }

    return s;
  }

  static String newsDateOnly(String string) {
    String s = "";
    s = string.split("T")[0];
    return s;
  }

  static String newsDateSince(String string){
    String s = "";
    int apiDay = int.parse(string.split("")[8] + string.split("")[9]);
    int currentDay = DateTime.now().day;

    if(currentDay == apiDay) s = "Today";
    else if(currentDay == apiDay + 1) s = "Yesterday";
    else if(currentDay > apiDay + 1) s = "Since ${currentDay - apiDay} days";

    return s;
  }

}