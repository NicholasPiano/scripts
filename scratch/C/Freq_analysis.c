#include <stdio.h>
#include <math.h>
//Remember PC-console I/O

float mean (int size, float mean_array[size]) {
	float mean, sum;
	int k;
	sum = 0;
	for(k=0; k<size; k++) {
		sum += mean_array[k];
		//printf("sum = %f\n", sum);
    }
	mean = sum/size;
	//printf("sum = %f, mean = %f\n", sum, mean);
	return mean;
}

float std (int size, float input_array[size]) {
	float mean1, mean2, x, sqrt1; //mean of array, mean of x-mean, x-mean, final result
	int j;
	
	//1. take mean    
	mean1 = mean(size, input_array);
	//printf("mean %f\n", mean1);
	
    //2. (each value - mean) squared
	for(j=0; j<size; j++) {
		x = input_array[j] - mean1;
		//printf("x = %f\n", x);
		input_array[j] = x*x;
	}
	/*for(j=0; j<size; j++) {
		printf("lm = %f\n", input_array[j]);
	}*/
	
    //3. take mean again
	mean2 = mean(size, input_array);
	//printf("mean %f\n", mean2);
	
    //4. square root
	sqrt1 = sqrt(mean2);
	
    //print
    return(sqrt1);
}

int main () {
	float array[30], std_dev; //store input, ouput
	int i, size; //count input, size of input
	printf("enter the size of the array\n");
	scanf("%d", &size);
    //input
    for(i=0; i<size; i++) {
          scanf("%f", &array[i]);
    }
    /*for(i=0; i<size; i++) {
          printf("%f\n", array[i]);
    }*/
    //standard deviation
    std_dev = std(size, array);
    printf("%f", std_dev);
	getchar(); getchar();
	return 0;
}
