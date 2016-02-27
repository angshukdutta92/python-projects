import webbrowser
import time

#opening the web browser
i=0
print "this program started at "+time.ctime()
while(i<3):    
    time.sleep(2*60*60);
    webbrowser.open("https://www.youtube.com/watch?v=xlUFkMKSB3Y&index=1&list=PL0862D1A947252D20");
    i+=1;
