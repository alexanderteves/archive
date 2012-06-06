import java.util.*;

class BinaryClock
{
    public String getHours()
    {
        int[]               hourarray   = {32, 16, 8, 4, 2, 1};
        GregorianCalendar   cal         = new GregorianCalendar();
        int                 hours       = cal.get(Calendar.HOUR_OF_DAY);
        
        for(int n = 0; n < 6; n++)
        {
            if(hours - hourarray[n] >= 0)
            {
                hours = hours - hourarray[n];
                hourarray[n] = 1;
            }
            else if(hours - hourarray[n] < 0)
            {
                hourarray[n] = 0;
            }
        }
        
        String binaryvalue = "";
        
        for(int x = 0; x < 6; x++)
        {
            binaryvalue = binaryvalue + hourarray[x];
        }
        
        return binaryvalue;
    }
    
    public String getMinutes()
    {
        int[]               minutearray = {32, 16, 8, 4, 2, 1};
        GregorianCalendar   cal         = new GregorianCalendar();
        int                 minutes     = cal.get(Calendar.MINUTE);
        
        for(int n = 0; n < 6; n++)
        {
            if(minutes - minutearray[n] >= 0)
            {
                minutes = minutes - minutearray[n];
                minutearray[n] = 1;
            }
            else if(minutes - minutearray[n] < 0)
            {
                minutearray[n] = 0;
            }
        }
        
        String binaryvalue = "";
        
        for(int x = 0; x < 6; x++)
        {
            binaryvalue = binaryvalue + minutearray[x];
        }
        
        return binaryvalue;
    }
    
    public String getSeconds()
    {
        int[]               secondarray = {32, 16, 8, 4, 2, 1};
        GregorianCalendar   cal         = new GregorianCalendar();
        int                 seconds     = cal.get(Calendar.SECOND);
        
        for(int n = 0; n < 6; n++)
        {
            if(seconds - secondarray[n] >= 0)
            {
                seconds = seconds - secondarray[n];
                secondarray[n] = 1;
            }
            else if(seconds - secondarray[n] < 0)
            {
                secondarray[n] = 0;
            }
        }
        
        String binaryvalue = "";
        
        for(int x = 0; x < 6; x++)
        {
            binaryvalue = binaryvalue + secondarray[x];
        }
        
        return binaryvalue;
    }
    
    public String author()
    {
    	return "Coded 2005 by Alexander Teves";	
   	}
}