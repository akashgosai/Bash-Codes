#include <stdio.h>
#include <string.h>
#include "add.h"
#include "sub.h"
#include "mpy.h"
#include "div.h"



int main(int argc, char *argv[]){
	FILE *f = fopen(argv[1], "r");	
	char op;
	double a,b;
	if(f==NULL){
		return 1;	
	}
	while(fscanf(f,"%lf %c %lf",&a,&op,&b)!=EOF){
		double c;
		switch(op){

		case '+' : c=add(a,b);
			   printf("Addition is %lf\n",c);
			   break;
		case '-' : c=sub(a,b);
			   printf("Subtraction is %lf\n",c);
			   break;
		case '*' : c=mpy(a,b);
			   printf("Multiplication is %lf\n",c);
			   break;
		case '/' : c=div(a,b);
			   printf("Division is %lf\n",c);
			   break;
		default : printf("Not a valid operator.");
		}	
	}
	fclose(f);
	return 0;
}
