#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <time.h>

#define HIGH 40000
#define LOW 30000

void decode(uint32_t connfd);



int main()
{
	//open a listener on a random high port, when it registers a connection,
	//decode and send that through the connection. hopefully they use telnet.
	uint32_t sockfd, connfd, len;
	struct sockaddr_in servaddr, peer;
	
	uint16_t port;
	srand(time(NULL));


	port = (uint16_t) ((rand() % (HIGH - LOW + 1)) + LOW);


	#ifdef DEBUG
		printf("the port: %hu\n", port);
	#endif

	printf("I don't have a witty joke for you this time...\n");


	//network code goes here
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	
	if(sockfd == -1)
	{
		printf("Something went wrong, yo\n");
		exit(0);
	}

	bzero(&servaddr, sizeof(servaddr));

	servaddr.sin_family = AF_INET;
	inet_pton(AF_INET, "127.0.0.1", &servaddr.sin_addr.s_addr);
	servaddr.sin_port = htons(port);
	
	if((bind(sockfd, (struct sockaddr*)&servaddr, sizeof(servaddr))) != 0)
	{
		printf("Something went wrong, yo\n");
		exit(0);
	}	

	if(listen(sockfd, 1) != 0)
	{
		printf("Something went wrong, yo\n");
		exit(0);
	}

	connfd = accept(sockfd, (struct sockaddr*)&peer, &len);

	if(connfd < 0)
	{
		printf("Something went wrong, yo\n");
		exit(0);
	}else
	{

#ifdef DEBUG
		printf("socket connection made, connfd: %d\n", connfd);
#endif

		decode(connfd);
		//uint8_t msg[] = "You should have the flag now\n";

		//write(connfd, flag, strlen(flag));
		close(connfd);
		close(sockfd);

	}



	return 0;
}

void decode(uint32_t connfd)
{
	uint8_t key = 0x47;

	uint8_t flag[] = {0x01,0x15,0x02,0x04,0x0c,0x0b,0x02,0x14,0x04,0x08,0x09,0x75,0x75,0x3c,0x24,0x28,0x2a,0x2e,0x29,0x20,0x67,0x32,0x37,0x67,0x30,0x2e,0x33,0x2f,0x67,0x30,0x2e,0x33,0x33,0x3e,0x67,0x2d,0x28,0x2c,0x22,0x34,0x67,0x2e,0x34,0x67,0x2f,0x26,0x35,0x23,0x6b,0x67,0x28,0x2c,0x66,0x78,0x3a, 0x00};//some xor string.
	//xor a string to get the flag.
	uint32_t flaglen = strlen(flag);
	#ifdef DEBUG
		printf("Flaglen: %d\n", flaglen);
	#endif

	for(int k = 0; k < flaglen; k++)
	{
		flag[k] = flag[k] ^ key;
	}
	//printf("Flag: %s\n", flag);
	write(connfd, flag, flaglen);

}
