#include <stdio.h>
#include <math.h>
#include "system.h"
#include "altera_avalon_pio_regs.h"

#include <unistd.h>
//#include <signal.h>

//volatile int duty = 0;

//void alarm_handler(int signum) {
//    if (duty <= 200) {
//        duty++;
//    }
//    else {
//        duty = 0;
//    }
//}





int main()
{
	int duty=0;
	int adc_column =400;
	int adc_row = 400;
    int adc_sensor= 100;

	double angle =0;
	double sin_angle_radar;
	double cos_angle_radar;

	int x_distance;
	int y_distance;



	  while(1){

	      if (duty >= 200) {
	    	  duty = 0;
	       } else {
	          duty++;
	       }
	       usleep(10000);
	       	   //printf("Ingrese el pwm:\n");
		  	  //scanf("%d",&duty);
		  	  printf("el duty es %d\n",duty);
			  // Calculate sin(angle)
			  angle = M_PI*duty/255;
			  sin_angle_radar = sin(angle);
			  cos_angle_radar = cos (angle);
			  //Calculate distance
			  adc_sensor = IORD_ALTERA_AVALON_PIO_DATA(PIO_3_BASE);
			  x_distance = (int) (adc_sensor*cos_angle_radar);
			  y_distance = (int) (adc_sensor*sin_angle_radar);
			  adc_column = 320 - x_distance;
			  adc_row = 480 - y_distance;
			  printf("el adc_column es %d\n",adc_sensor);
		      printf("el adc_column es %d\n",adc_column);
		      printf("el adc_row es %d\n",adc_row);

		  	  IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, duty);
		  	  IOWR_ALTERA_AVALON_PIO_DATA(PIO_1_BASE, adc_column);
	  		  IOWR_ALTERA_AVALON_PIO_DATA(PIO_2_BASE, adc_row);
	  }





  return 0;
}
