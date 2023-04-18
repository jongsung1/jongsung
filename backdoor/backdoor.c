#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char* argv[]){
    uid_t uid = geteuid();      // 현재 실행 중인 사용자의 uid를 가져옴
    setuid(0);                  // root 권한으로 실행하기 위해 uid를 0으로 변경

    if(argc < 2){
        printf("Usage: %s /path/to/script.sh\n", argv[0]);
        return 1;
    }

    char* script_path = argv[1];
    system(script_path);        // 실행할 스크립트 경로를 변수로 받아와서 system 함수로 실행

    setuid(uid);                // 프로그램 실행 후 다시 원래 사용자의 권한으로 변경
    return 0;
}

