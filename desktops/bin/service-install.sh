PKGIN_LIST=../netbsd/pkginlist/
INSTALL_FILE=services.pkg
sudo pkgin -y im ${PKGIN_LIST}${INSTALL_FILE}
./cprcd.sh
./startservices.sh
