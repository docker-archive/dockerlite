#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char* argv[]) {
	if (argc>1 && 0==strcmp(argv[1], "--stop-hammer-time")) {
		int fd, afd;
		char* debug=getenv("DOCKERLITE_DEBUG");
		struct sockaddr_in addr;
		socklen_t len = sizeof(addr);
		if (debug) puts("dockerlite: Stopped. Waiting for signal to resume.");
		fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
		addr.sin_family = AF_INET;
		addr.sin_port = htons(9);
		addr.sin_addr.s_addr = inet_addr("127.0.0.1");
		if (-1 == bind(fd, (struct sockaddr*)&addr, sizeof(addr))) {
			perror("bind");
		} else {
			if (-1 == listen(fd, 1)) {
				perror("listen");
			} else {
				afd = accept(fd, (struct sockaddr*)&addr, &len);
				if (-1 == afd) {
					perror("accept");
				}
				close(afd);
			}
		}
		close(fd);
		if (debug) puts("dockerlite: Got signal. Resuming.");
		execvp(argv[2], argv+2);
	}
	exit(0);
}
