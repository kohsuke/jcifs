#!/bin/sh

JAVA_HOME=/usr/local/java5
CLASSPATH=../build:.
PROPERTIES=../../user2.prp
RUN="${JAVA_HOME}/bin/java -cp ${CLASSPATH} -Djcifs.properties=${PROPERTIES}"

SERVER=192.168.2.110
#SERVER=dc1.w.net
SHARE=tmp
DIR=test

# Domain-based DFS
#SERVER=192.168.2.110
#SERVER=w.net
#SHARE=root2
#DIR=test

# smb://fs4.w.net/DFSStandaloneRoot/DFSStandaloneLink/test/
# smb://dc1.w.net/root2/link2/test/
# smb://dc1.w.net/tmp/test/
# smb://dc3.x.net/tmp/test/
# Stand-alone DFS
#SERVER=192.168.2.113
#SERVER=fs1.w.net
#SHARE=DFSStandaloneRoot
#DIR=DFSStandaloneLink/test

WRITE_DIR=${DIR}/
SRC_DIR=${DIR}/Junk
FILE1=${DIR}/Junk/10883563.doc
URL_SERVER=smb://${SERVER}/
URL_SHARE=${URL_SERVER}${SHARE}/
URL_WRITE_DIR=${URL_SHARE}${WRITE_DIR}

set -x

$RUN ListACL ${URL_WRITE_DIR}
$RUN LargeListFiles ${URL_WRITE_DIR}
$RUN CountPerms ${URL_WRITE_DIR} 100
$RUN AclCrawler ${URL_WRITE_DIR} 100
$RUN SidCacheTest ${URL_WRITE_DIR}
$RUN GetSecurity ${URL_WRITE_DIR}
$RUN GetSecurity ${URL_SHARE}
$RUN GetShareSecurity ${URL_WRITE_DIR}
$RUN SidCrawler ${URL_WRITE_DIR} 5
$RUN GetGroupMemberSidsFromURL ${URL_WRITE_DIR}
$RUN InterruptTest ${URL_SHARE}${FILE1}
$RUN AllocInfo ${URL_SHARE}
$RUN Append ${URL_WRITE_DIR}Append.txt
$RUN AuthListFiles smb://bogus\@${SERVER}/${SHARE}/
$RUN CopyTo ${URL_SHARE}${SRC_DIR}/ ${URL_SHARE}${WRITE_DIR}CopyTo/
$RUN CreateFile ${URL_WRITE_DIR}CreateFile.txt
$RUN Delete ${URL_WRITE_DIR}CreateFile.txt
$RUN Equals ${URL_WRITE_DIR}CreateFile.txt ${URL_SHARE}${WRITE_DIR}../${WRITE_DIR}CreateFile.txt
$RUN Exists ${URL_WRITE_DIR}
$RUN FileInfo ${URL_SHARE}${FILE1} 0
$RUN FileOps ${URL_WRITE_DIR}
$RUN FilterFiles ${URL_SHARE}${SRC_DIR}/
$RUN GetDate ${URL_SHARE}${FILE1}
$RUN Get ${URL_SHARE}${FILE1}
$RUN GetType ${URL_SHARE}
$RUN GrowWrite ${URL_WRITE_DIR}GrowWrite.txt
$RUN GetURL ${URL_WRITE_DIR}Append.txt
$RUN HttpURL ${URL_WRITE_DIR} ../Append.txt
$RUN Interleave ${URL_WRITE_DIR} 3
$RUN IsDir ${URL_SHARE}${SRC_DIR}/
$RUN Length ${URL_SHARE}${FILE1}
$RUN ListFiles ${URL_WRITE_DIR}
$RUN ListFiles ${URL_SERVER}
$RUN List ${URL_WRITE_DIR}
$RUN ListTypes ${URL_WRITE_DIR}
$RUN Mkdir ${URL_WRITE_DIR}Mkdir
$RUN NodeStatus ${SERVER}
$RUN Put ${URL_WRITE_DIR}Makefile
$RUN Query ${SERVER}
$RUN RenameTo ${URL_WRITE_DIR}Makefile ${URL_WRITE_DIR}Makefile.txt
$RUN SetAttrs ${URL_WRITE_DIR}Makefile.txt FFFF
$RUN SetTime ${URL_WRITE_DIR}Makefile.txt
$RUN SlowWrite ${URL_WRITE_DIR}SlowWrite.txt
$RUN SlowRead ${URL_WRITE_DIR}SlowWrite.txt
$RUN SmbCrawler ${URL_WRITE_DIR} 1000
$RUN T2Crawler ${URL_WRITE_DIR} 3 1000
$RUN TestRandomAccess ${URL_WRITE_DIR}TestRandomAccess.bin 1
$RUN TestRandomAccess ${URL_WRITE_DIR}TestRandomAccess.bin 2 0
$RUN TestRandomAccess ${URL_WRITE_DIR}TestRandomAccess.bin 3 1234


