#include <stdio.h>
#include <sys/select.h>
#include <unistd.h>
#include <string.h>
#include <stdint.h>


#define TIMEOUT 2//in seconds

void decode(void);

int main()
{	
	uint8_t buf[100];
	uint32_t ret;
	fd_set rfds;
	struct timeval timeout;
	timeout.tv_sec = TIMEOUT;
	timeout.tv_usec = 0;
	
	FD_ZERO(&rfds);
	FD_SET(0, &rfds);

	#ifdef DEBUG
		decode();
	#endif

	printf("Second verse, same as the first, password please: \n");
	ret = select(1, &rfds, NULL, NULL, &timeout);

	if(ret == 0)
	{
		printf("\n\"You're too slow!\" -- Sonic The Hedgehog, in some year, probably.\n");
	}else
	{
		//read the buffer, and check for password
		fgets(buf, 100, stdin);
		if(0 == strncmp(buf, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",69))
		{
		//decode if match
			printf("Ok, here's the flag: ");
			decode();

		}else
		{
		//taunt and restart if wrong.
			printf("That's not the magic word!, Nedry would be disappointed.\n");
		}	
	}
	
	

}

void decode()
{
	uint8_t key = 0x69;

	uint8_t flag[] = {0x2f,0x3b,0x2c,0x2a,0x22,0x25,0x2c,0x3a,0x2a,0x26,0x27,0x5b,0x5b,0x12,0x2f,0x1b,0x0c,0x0a,0x02,0x05,0x0c,0x1a,0x20,0x1a,0x27,0x06,0x1d,0x28,0x2e,0x06,0x06,0x0d,0x2b,0x06,0x10,0x56,0x2b,0x05,0x08,0x1a,0x19,0x01,0x0c,0x04,0x10,0x14,0x00};//some xor string.
	//xor a string to get the flag.
	uint32_t flaglen = strlen(flag);
	#ifdef DEBUG
		printf("Flaglen: %d\n", flaglen);
	#endif

	for(int k = 0; k < flaglen; k++)
	{
		flag[k] = flag[k] ^ key;
	}
	printf("Flag: %s\n", flag);

}
