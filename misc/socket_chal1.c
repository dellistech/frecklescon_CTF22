#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>

#define PORT 23

void decode(uint32_t connfd);

int main()
{
	//open a listener on port 22, when it registers a connection,
	//decode and send that through the connection. hopefully they use telnet.
	uint32_t sockfd, connfd, len;
	struct sockaddr_in servaddr, peer;

	printf("You know what they say about gossip: Tell Freckles, telephone, telnet!\n");


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
	servaddr.sin_port = htons(PORT);
	
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
		decode(connfd);
		//uint8_t msg[] = "You should have the flag now\n";

		//write(connfd, msg, strlen(msg));
		close(connfd);
		close(sockfd);

	}



	return 0;
}

void decode(uint32_t connfd)
{
	uint8_t key = 0x57;

	uint8_t flag[] = {0x11,0x05,0x12,0x14,0x1c,0x1b,0x12,0x04,0x14,0x18,0x19,0x65,0x65,0x2c,0x23,0x32,0x3b,0x39,0x32,0x23,0x7b,0x30,0x32,0x23,0x77,0x3e,0x23,0x68,0x77,0x3b,0x38,0x3b,0x2a,0x00};//some xor string.
	//xor a string to get the flag.
	uint32_t flaglen = strlen(flag);
	#ifdef DEBUG
		printf("Flaglen: %d\n", flaglen);
	#endif

	for(int k = 0; k < flaglen; k++)
	{
		flag[k] = flag[k] ^ key;
	}
	write(connfd, flag, flaglen);
	//printf("Flag: %s\n", flag);

}
