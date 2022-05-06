
#!/bin/bash


##conf file import
source /idea_backup/script/default/default_conf

BLACK="\\033[1;30m"
RED="\\033[1;31m"
GREEN="\\033[1;32m"
BROWN="\\033[1;33m"
BLUE="\\033[1;34m"
MAGENTA="\\033[1;35m"
CYAN="\\033[1;36m"
WHITE="\\033[1;37m"

BOLD="\\033[1m"
RESET="\\033[0m"
SPARK1="\\033[1;4;5m"
SPARK2="\\033[1;4;0m"

BACK_BLACK="\\033[40;30m"
BACK_RED="\\033[41;30m"
BACK_GREEN="\\033[42;30m"
BACK_BROWN="\\033[43;30m"
BACK_BLUE="\\033[44;30m"
BACK_MAGENTA="\\033[45;30m"
BACK_CYAN="\\033[46;30m"
BACK_WHITE="\\033[47;30m"


echo -e "${BLACK}black${RESET}"
echo -e "${RED}Red${RESET}"
echo -e "${GREEN}green${RESET}"
echo -e "${BROWN}brown${RESET}"
echo -e "${BLUE}blue${RESET}"
echo -e "${MAGENTA}magenta${RESET}"
echo -e "${CYAN}cyan${RESET}"
echo -e "${WHITE}white${RESET}"
echo -e "${BOLD}BOLD${RESET}"
echo -e "${RESET}RESET${RESET}"
echo -e "${SPARK1}SPARK${SPARK2}"

echo -e "${BACK_BLACK}BACK_BLACK${RESET}"
echo -e "${BACK_RED}BACK_RED${RESET}"
echo -e "${BACK_GREEN}BACK_GREEN${RESET}"
echo -e "${BACK_BROWN}BACK_BROWN${RESET}"
echo -e "${BACK_BLUE}BACK_BLUE${RESET}"
echo -e "${BACK_MAGENTA}BACK_MAGENTA${RESET}"
echo -e "${BACK_CYAN}BACK_CYAN${RESET}"
echo -e "${BACK_WHITE}BACK_WHITE${RESET}"