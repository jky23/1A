#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void fonc(int sign) 
{
	printf("numero de signal %d\n", sign);
	signal(sign,fonc);
}

int main () {
	for (int i=1; i<64; i++)
	{
		signal(i,fonc);
	}
	
	sleep(5);
	
	printf("Je suis toujours actif\n");
	
	sleep(60);
	
	
	
}
