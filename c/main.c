#include <unistd.h>
#include <fcntl.h>
#include <string.h>

int main() {
    const char* buf = "This is some text";
    int fd = open("somefile.txt", O_RDWR | O_CREAT);
    write(fd, buf, strlen(buf));
    close(fd);
}
