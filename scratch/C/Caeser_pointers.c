#include <stdio.h>
#include <string.h>

char input[20];
char output[20];
int shift;

char shift_char(char *in, char *out) {
     char *qaz = out;
	 while(*in != '\0') {
               *qaz++ = (*in++) + shift;
     }
	 *qaz = '\0';
	 return *qaz;
}

int main(void) {	
	printf("Enter plaintext\n");
	scanf("%20s", &input);
	printf("Enter Caeser Shift\n");
	scanf("%d", &shift);
	
	shift_char(input, output);
   	getchar();
	puts(output); 
    getchar();
	return 0;
}
